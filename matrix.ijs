NB. Utilities for treating tables as mathematical matrices.
NB. Also useful are the primitives
NB. /  table
NB. %. matrix inverse : matrix divide
NB. |: transpose

NB. Matrix multiplication, dot product, inner product.
mx =: +/ . *

NB. Outer product
ox =: *"0 _

NB. Identity matrix
mI =: i. =/ i.

NB. Column of a matrix
mcol =: {"1

NB. Matrix element
mij =: (<@:;/@:[) { ]
