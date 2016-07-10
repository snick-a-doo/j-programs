NB. Random y-digit number, no leading zero.
n_digit_number =: monad define
digits =. y
min =. 10 ^ <: digits
range =. (10 ^ digits) - >: min
min + ? range
)

NB. The number of digits in the base-10 representation of y.
n_digits =: >:@:<.@:(10&^.)

NB. A list of the digits that make up the smaller factor.
bottom_digits =: monad define
NB. The larger factor.
top_factor =. y
NB. Ensure that each bottom digit times the top factor yields a
NB. product with one more digit than the top factor.
top_factor_digits =. n_digits top_factor
min_product =. 10 ^ top_factor_digits
min_digit =. >. min_product % top_factor
min_digit + ? (<: top_factor_digits) $ 10 - min_digit
)

NB. Generate a multiplication problem where the larger factor has y
NB. digits, the smaller has y-1 digits, and the y-1 intermediate
NB. products all have y+1 digits.  The result is a list of strings,
NB. one for each line in the worked-out problem, where the digits are
NB. replaced with letters. 
mult_problem =: monad define
n_top_digits =. y
top_factor =. n_digit_number n_top_digits
bottom =. bottom_digits top_factor
bottom_factor =. 10 #. bottom
encode top_factor , bottom_factor , (top_factor * |. bottom) , (bottom_factor * top_factor)
)

NB. Generate a random correspondence of letters with numbers.  Return
NB. the argument with digits replaced with letters.  Store the key in
NB. a global variable.
encode =: monad define
number =. y
mult_key =: ((a. i. 'A') + 10 ? 10) { a.
letters =. ((((# , >./@:n_digits) number) $ 10) #: number) { mult_key
mult_key remove_leading_zeroes letters
)

NB. Replace the letter that corresponds to zero with a space when it
NB. occurs at the beginning of a 1-cell. 
remove_leading_zeroes =. dyad define
key =. x
code =. y
mask =. *./\"1 code = {. key
' ' mask replace code
)

NB. Like 'amend' but the amended elements are selected with a logical
NB. array that's the same shape as y. 
replace =. adverb define
:
new =. x
mask =. m
array =. y
NB. Ravel the arrays to avoid fills in the result of I. .
($ array) $ new (I. , mask) } , array
)

mult_update =. monad define
letter =. y
number =. {. ": mult_key i. letter
mask =. letter = mult_puzzle
mult_puzzle =: number mask replace mult_puzzle
)

mult_guess =: dyad define
letter =. x
number =. y
if. -. letter e. mult_key do.
  echo '''' , letter , ''' not in puzzle.'
elseif. -. letter e. , mult_puzzle do.
  echo '''' , letter , ''' already found.'
elseif. letter = number { mult_key do.
  echo 'Yes'
  mult_update letter
  if. -. +./ mult_key e. , mult_puzzle do.
    echo 'Solved'
  end.
elseif. do.
   echo 'No'
end.
display_problem mult_puzzle
)

display_problem =: monad define
problem =. y
line =. ' -' {~ ' '&~:@:{&problem
echo 0 { problem
echo 'x' 1 } 1 { problem
echo line 2
i_added_rows =. i. (# problem) - 3
echo i_added_rows |."0 1 ((2 + i_added_rows) { problem)
echo line _1
echo _1 { problem
)

new_mult_puzzle =: monad define
top_digits =. y
display_problem mult_puzzle =: mult_problem top_digits
)
