update_fpi =: dyad define
tc =. x
in_file =. y
out_file =. '../fpiv6/' , in_file

table =. 'b' freads in_file
NB. Consider writing an adverb that inserts an element at an index.
new_table =. }. (5 {. table) , (< 'TC: ' , ": tc) , (5 }. table)

NB. Use fwrites for the first line to get rid of the old contents.
'FPIv6' fwrites out_file
NB. Append line-by-line to avoid filling the lines.
NB.!! Consider writing a verb for writing an array of boxed strings without filling.
(fappends & out_file) @ > new_table
)
