cos =: 2&o.
sin =: 1&o.
mx =: +/ . *

Rz =: dyad define
cosx =. cos x
sinx =. sin x
R =. 3 3 $ cosx , -sinx , 0 , sinx , cosx , (0 0 0 1)
R mx y
)

Rx =: dyad define
cosx =. cos x
sinx =. sin x
R =. 3 3 $ (1 0 0 0) , cosx , -sinx , 0 , sinx , cosx
R mx y
)

cartesian =: dyad define"1 0
NB. x: Orbital elements
NB.   a: semi-major axis, average distance
NB.   e: ecentricity, unitless
NB.   i: inclination angle
NB.   w (small omega): periapsis angle
NB.   O (big omega): ascending node angle
NB. y: v (nu): angle to object
'a e i w O' =. x
v =. y
r =. (a * 1 - *: e) % 1 + e * cos v
O Rz i Rx w Rz (r*cos v) , (r*sin v) , 0
)