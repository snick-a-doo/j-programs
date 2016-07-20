load '~Programs/fit.ijs'
NB. Notation
NB.   eta:   Gas concentration: 0 <: eta <: 1.
NB.   eta_a: Concentration of the active gas on the carrier inlet.
NB.   phi:   Flow rate in gas/s, where 'gas' is anything proportional to moles.
NB.   phi_C: Carrier flow rate.
NB.   rho:   Carrier flow rate fraction during calibration: 0 <: rho <: 1.
NB.   tau:   Raw TCD signal in volts.

eta_a   =: 0.1      NB. 10% H2 in Ar
phi_C   =: 50 % 60  NB. 50 cm3/min STP
tau_max =: 0.9      NB. Full-scale TCD signal

tcd_cal =: adverb define
NB. Make a function that converts a raw TCD signal in volts to concentration of
NB. the active gas.  The signal has the same units as the carrier flow rate.
order =. m

NB. Carrier steps from 100% to 0 in 10% decrements.  Inert flow from the loop
NB. inlet is adjusted to maintain constant inert flow.  The resulting
NB. concentration is not quite linear.
rho =. 0.1 * i. 11
phi_T =. phi_C
phi_C =. (1 - rho) * phi_T
phi_L =. rho * (1 - eta_a) * phi_T
eta =. eta_a % >: phi_L % phi_C
tau =. tau_max * 1 - eta % eta_a
                    NB. Linear in active concentration.  Zeroed and inverted.
NB. tau =. tau_max * 1 - rho
                    NB. Linear in carrier fraction
NB. coefficients =. phi_C * {. order fit tau ,: rho * eta_a
coefficients =. {. order fit tau ,: (1 - rho) * eta_a
                    NB. The first row of the fit has the coefficients,
                    NB. zero-filled.
coefficients&p.
)

calibrate =: dyad define
NB. Apply the calibration to a raw TCD signal
order =. x
'time signal' =. > y
time ; phi_C * order tcd_cal signal
)

tpr =: dyad define
NB. Return a simulated TCD signal from a TPR analysis.
NB. Return time array, s ; TCD signal, zeroed and inverted, V.
Q =. x              NB. Absolute quantity consumed, cm3 STP
dt =. y             NB. Time between samples, s
t_max =. 2000       NB. Duration of analysis, s
t_peak =. t_max % 4 NB. Time at peak TCD signal, s
t =. dt * i. >: <. 2000 % dt
                    NB. Array of TCD measurement times
tau_peak =. 0.8     NB. Peak TCD signal
width =. (Q * tau_max) % phi_C * eta_a * tau_peak * %: 2p1
                    NB. Peak width: FWHM = width * 2 * %: 2 * ^. 2
t ; tau_peak * ^ _1r2 * *: (t - t_peak) % width
)

consumption =: dyad define
NB. Integrate a calibrated signal to get quantity consumed.
mass =. x
'time active_flow' =. > y
dt =. -~/ 2 {. time
mass %~ dt * +/ (-~ {.) active_flow
)

analyze =: dyad define
q =. x              NB. Specific quantity consumed, cm3/g STP
mass =. y           NB. Sample mass
2 calibrate (q * mass) tpr 0.2
)

reduce =: dyad define
mass =. x           NB. Sample mass
data =. y           NB. TPR data: time, s ; active flow, cm3/s STP
mass consumption data
)
