load '~Programs/fit.ijs'

NB. Apply the calibration to a raw TCD signal
tcd_cal =: dyad define
flow =. x NB. gas/s 'gas' is anything proportional to moles.
'time signal' =. > y
eta_a =. 0.1
rho =. 0.1 * i. 11
eta =. rho % rho + <: % eta_a
tau_max =. 0.9
tau =. tau_max * 1 - eta % eta_a
time ; flow * ({. 2 fit tau ,: rho * eta_a) p. signal
)

NB. Return a simulated TCD signal from a TPR analysis.
NB. Return time array (s) ; TCD signal (V).
tpr =: monad define
dt =. y NB. Time between samples, s
time =. dt * i. >: <. 2000 % dt
time ; 0.8 * ^ - *: (time - 500) % 20
)

NB. Integrate a calibrated signal to get quantity consumed.
consumption =: dyad define
mass =. x
'time active_flow' =. > y
dt =. -~/ 2 {. time
mass %~ dt * +/ (-~ {.) active_flow
)
