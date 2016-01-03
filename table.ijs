NB. Read a file into a table.  Use _ for non-numeric entries.
NB. y: file name
NB.!! Consider making the fill value _.
read_table =: monad define
_&".;._2 fread y
NB.!! Consider filtering out rows made entirely of _.
NB.!! Verb that's false only for rows entirely made of _.
NB.!! good_row =. *./"1@:~:&_
NB.!! (#~ good_row) data
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
