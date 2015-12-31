NB. There's probably an easier way.
is_sorted =: (*./"1)@:(2&(</\)"1)

NB. A table where each row is a permutation of i.m
perms =: i.@:! A. i.

NB. Adverb that uses its verb to filter a table.
filter =: adverb define
(*./"1@:u # ]) y
)

NB. Not quite.  Need min-max of all non-zero entries.
span =: monad define
(>./"1) 2(- *. *@*)/\"1 y
)

NB. Form a list by choosing exactly 1 element from each row and 1 from each column of a
NB. table.  Repeat for each possible combination.  Return the lists as a table.
pick =: monad define
'rows cols' =. $ y
trimmed =. (is_sorted # ]) ~. (i.rows){"1 perms cols
NB. 2-column tables with ordered indices paired with permuted.
indices =. (($ trimmed) $ i.rows) (,."0) trimmed
NB. Box up the indices and select elements from the table.
candidates =. (;/"2 indices) { y
(<:&12 *. >:&0 *. <&6@:span) filter candidates
)
