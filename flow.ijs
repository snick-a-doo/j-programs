require 'numeric'
require '~my/fit.ijs'
NB. Notation
NB.   eta:   Gas concentration: 0 <: eta <: 1.
NB.   eta_a: Concentration of the active gas on the carrier inlet.
NB.   phi:   Flow rate in gas/s, where 'gas' is anything proportional to moles.
NB.   phi_C: Carrier flow rate.
NB.   tau:   Raw TCD signal in volts.

eta_a =: 0.1              NB. 10% H2 in Ar
phi_C_cal =: 50r60        NB. 50 cm3/min STP for calibration
phi_C_anl =: 50r60        NB. 50 cm3/min STP for analysis
tau_max =: 0.9            NB. Full-scale TCD signal, V

eta_of_phi =: dyad define
NB. Return the concentration of active gas for the given consumption rate. 
phi_C =. x
phi_Q =. y
((eta_a * phi_C) - phi_Q) % phi_C - phi_Q
)
phi_of_eta =: dyad define
phi_C =. x
eta =. y
phi_C * (eta_a - eta) % 1 - eta
)

tau_of_eta =: monad define
NB. Return the TCD signal for the given active gas concentration.
eta =. y
NB. Model the TCD signal as linear in active concentration, not quite
NB. linear in active flow.  Zeroed and inverted for high TC active gas.
tau_max * 1 - eta % eta_a
)
eta_of_tau =: monad define
tau =. y
eta_a * 1 - tau % tau_max
)

tcd_cal =: adverb define
NB. Make a function that converts a raw TCD signal in volts to flow
NB. rate of the active gas as a fraction of total carrier flow.  The
NB. function is a polynomial of the given order.  The signal has the
NB. same units as the carrier flow rate.
order =. m

NB. Carrier flow steps from 100% to 0 in 10% decrements.  Inert flow
NB. from the loop inlet is adjusted to maintain constant inert flow.
NB. Total flow is not constant; this emulates gas consumption during
NB. an analysis.
phi_Ci =. phi_C_cal * 1 - 0.1 * i. 11
phi_Li =. (1 - eta_a) * phi_C_cal - phi_Ci
eta =. eta_a % >: phi_Li % phi_Ci
coeffs =. coeff order fit (tau_of_eta eta) ,: eta_a * phi_Ci % phi_C_cal
echo coeffs
coeffs&p.
)

calibrate =: dyad define
NB. Apply the calibration to a raw TCD signal
order =. x
'time signal' =. > y
time ; phi_C_anl * order tcd_cal signal
)

tpr =: dyad define
NB. Return a simulated TCD signal from a TPR analysis.  Return time
NB. array, s ; TCD signal, zeroed and inverted, V.
Q =. x                    NB. Absolute quantity consumed, cm3 STP
dt =. y                   NB. Time between samples, s
t_max =. 2000             NB. Duration of analysis, s
t_peak =. t_max % 4       NB. Time at peak TCD signal, s
t =. range 0 , t_max , dt NB. Array of TCD measurement times

NB. Model the consumption rate, 'phi_Q', as a Gaussian function of
NB. time.  Set the amplitude so that the maximum TCD signal is
NB. 'tau_peak' V.
tau_peak =. 0.8
amp =. phi_C_anl phi_of_eta eta_of_tau tau_peak

NB. Set the width so the total gas consumed equals 'Q'.  By the
NB. integral of Gaussian, Q = amp * width * %: 2p.
NB. FWHM = width * 2 * %: 2 * ^. 2
width =. Q % amp * %: 2p1
phi_Q =. amp * ^ _1r2 * *: (t - t_peak) % width
t ; tau_of_eta phi_C_anl eta_of_phi phi_Q
)

analyze =: dyad define
NB. Generate the TCD signal and apply the calibration.
q =. x                    NB. Specific quantity consumed, cm3/g STP
mass =. y                 NB. Sample mass
2 calibrate (q * mass) tpr 0.2
)

reduce =: dyad define
NB. Integrate a calibrated signal to get quantity consumed.  The first
NB. point gives the baseline.  Time interval is assumed to be
NB. constant, equal to the difference in the first two times.
mass =. x
'time active_flow' =. > y
dt =. -~/ 2 {. time
mass %~ dt * +/ (-~ {.) active_flow
)
