NB. Langmuir isotherm
NB. x: list of parameters
NB. y: list of pressures
NB. return: list of quantity adsorbed for each pressure
langmuir =: dyad define
'Qm b' =. x
P =. y
Qm*b*P % >: b*P
)

NB. Toth isotherm
NB. x: list of parameters
NB. y: list of pressures
NB. return: list of quantity adsorbed for each pressure
toth =: dyad define
'Qm a t' =. x
P =. y
Qm*a*P % t %: >: (a*P)^t
)
