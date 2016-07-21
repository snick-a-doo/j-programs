NB. Return an array with 'x' inserted at the 'm'th element of y.
NB. You may need parentheses around 'm' and 'insert'.
insert =: adverb define
{. , m , }.
)

NB. Append the contents of an array of boxes to a file.  Return the number of bytes
NB. written.
fappendb =: dyad define
boxes =. x
file =. y
+/ (fappends & file) @ > boxes
)

NB. Write the contents of an array of boxes to a file.  Return the number of bytes
NB. written.
fwriteb =: dyad define
bytes =. (> {. x) fwrites y
NB. Append the trailing items to avoid blanking the file.
bytes + (}. x) fappendb y
)

NB. Write an FPI version 6 file given a v5 file.  Optionally, pass a value for the new
NB. thermal conductivity entry.
update_fpi =: verb define
0.0 update_fpi y
:
tc =. x
NB. in_file =. y

for_in_file. y do.
  out_file =. '../fpiv6/' , in_file

  in_table =. 'b' freads in_file
  echo $ in_file
  echo $ in_table
  tc_entry =. < 'TC ' , ": tc
  out_table =. 'FPIv6' ; }. 6 (tc_entry insert) in_table

  out_table fwriteb out_file
end.
)
