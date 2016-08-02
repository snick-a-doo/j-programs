before_each =: monad define
load '~my/flow.ijs'
load '~my/fit.ijs'
eta_a =: 0.1
tau_max =: 0.9
)

test_eta_of_phi =: monad define
assert (10 eta_of_phi 0) = 0.1
assert (10 eta_of_phi 0.5) = % 19
assert (10 eta_of_phi 1) = 0
)

test_phi_of_eta =: monad define
assert (10 phi_of_eta 0.1) = 0
assert (10 phi_of_eta % 19) = 0.5
assert (10 phi_of_eta 0) = 1
)

test_tau_of_eta =: monad define
assert (tau_of_eta 0) = tau_max
assert (tau_of_eta 0.05) = 0.45
assert (tau_of_eta 0.1) = 0
)

test_eta_of_tau =: monad define
assert (eta_of_tau tau_max) = 0
assert (eta_of_tau 0.45) = 0.05
assert (eta_of_tau 0) = 0.1
)

test_sim =: monad define
scale =: 0.9 1 1.1
q =. mass reduce 95 analyze mass =. 0.04
assert *./ 0.0001 > | q - 98.2971 94.9102 91.7115
)
