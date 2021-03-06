NB. Generate a #x by y+1 matrix where each column is x^j.
x_powers =: |: @ (^"1 0 i.@>:)

NB. Return a table for a polynomial fit.  Rows:
NB. - Coefficients
NB. - Passed-in x-values
NB. - Passed-in y-values
NB. - Fitted y-values
NB. - Residuals
NB. x: order
NB. y: 2-row table: x-values and y-values 
fit =: dyad define "0 2
'xs ys' =. y
order =. x
cs =. ys %. xs x_powers order
model =. cs p. xs
((# xs) {. cs) , xs , ys , model ,: (model - ys)
)

coeff =: monad define "2
NB. Return a list of the coefficients.  Trailing zero coefficients are removed.
cs =. {. y
order =. (0 = cs) i: 0  NB. The index of the last non-zero coefficient 
(>: order) {. cs
)

rms =: monad define "2
NB. Return the root mean square of the residuals.
%: (+/ % #) *: 4 { y
)

NB. Turn the result of fit into an argument for plot.  x: the rows to plot as
NB. overlays vs. the x-values (row 1).  As a monad, rows 2 (y-values) and 3
NB. (model y-values) are plotted.  y: the result of fit.
plot_fit =: verb define
2 3 plot_fit y
:
(1 { y) ; (x { y)
)
