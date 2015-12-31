read_table =: monad define
_&".;._2 fread y
)

NB. Return a file or part of a file as a column of boxed strings.
report =: verb define
,.(<;._2) fread y
:
'start lines' =. x
NB. Start at 0 if x is a scalar.
start =. start*.(#x)>1
,.((start + i.lines){<;._2) fread y
)