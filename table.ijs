NB. Replace non-space whitespace characters with spaces.
clean =: monad define
ws =. TAB,CR,LF,FF
mask =. +./ y ="1 0 ws
' ' (I.mask) } y
)

NB. Read a file into a table.  Use _ for non-numeric entries.
NB. y: file name
read_table =: monad define
data =. _&".@:clean ;. _2 fread y
NB. Filter out rows made entirely of _.
good_row =. +./"1@:~:&_
(#~ good_row) data
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
