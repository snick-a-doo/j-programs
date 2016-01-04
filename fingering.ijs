NB. Compute possible guitar fingerings.

NB. Indices give number of semitones above E.
semitones =: 'ef g a bc'
NB. Flat, natural, sharp, double-sharp symbols.  Index - 1 gives number of
NB. semitones to modify the original pitch.
mods =: 'fnsx'
NB. Number of semitones per octave
octave =: 12
NB. The lowest note that can be played on a string from low E (6) to high E (1).
string_min =: 0 5 10 15 19 24

NB. Convert a note name into the number of semitones above low open E.  Negative
NB. numbers are allowed.
number =: monad define"1
'note mod oct' =. y
(semitones i. note) + <:(mods i. mod) + octave*".oct
)

NB. Return an table of frets for the passed-in array of notes.
string_and_fret =: string_min&(-~"1 0)

NB. True for strictly ascending lists.
is_sorted =: (*./"1)@:(2&(</\)"1)

NB. A table where each row is a permutation of i.m 
perms =: i.@:! A. i.

NB. Adverb that uses its verb to filter a table. 
filter =: adverb define 
(*./"1@:u # ]) y
) 

NB. Min - max of all non-zero entries. 
span =: (>./ - <./)@:(>&0 # ])"1

NB. Form a list by choosing exactly 1 element from each row and 1 from each
NB. column of a table.  Repeat for each possible combination.  Return the lists
NB. as a table.
pick =: monad define 
'rows cols' =. $ y 
trimmed =. (is_sorted # ]) ~. (i.rows){"1 perms cols 
NB. 2-column tables with ordered indices paired with permuted. 
indices =. (($ trimmed) $ i.rows) (,."0) trimmed 
NB. Box up the indices and select elements from the table. 
candidates =. (;/"2 indices) { y
NB. Filter out impractical fingerings.
(<:&12 *. >:&0 *. <&6@:span) filter candidates 
)

tab_line =: dyad define"1
x y } (# string_min) $ _
)

tab =: monad define
NB. Split the note string into an array of 3-character note specifications.
notes =. (] $~ %&3@:# , 3:) y
frets =. string_and_fret number notes
picked =. pick frets
strings =. frets&(i."1 0)"1 picked
|. picked tab_line strings
)
