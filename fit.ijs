NB. Generate a #x by y+1 matrix where each column is x^j.
x_powers =: |: @ (^"1 0 i.@>:)

NB. Return the coefficients for a polynomial fit.
NB. x: order
NB. y: 2-row table: x-values and y-values 
fit =: dyad define
'xs ys' =. y
order =. x
cs =. ys %. xs x_powers order
model =. cs p. xs
((# xs) {. cs) , xs , ys , model ,: (model - ys)
)

NB. Turn the result of fit into an argument for plot.
NB. x: the rows to plot as overlays vs. the x-values (row 1).  As a
monad, rows
NB. 2 (y-values) and 3 (model y-values) are plotted.
NB. y: the result of fit.
plot_fit =: verb define
2 3 plot_fit y
:
(1 { y) ; (x { y)
)
