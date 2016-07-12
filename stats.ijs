mean =: +/ % #

variance =: +/@:*:@:(- mean) % #

std_dev =: %:@:variance

span =: >./ - <./

NB. y: array of measurements return: array of statistics: mean, standard
NB. deviation, std.dev. as a percent of the mean, span, span as a percent
NB. of the mean.
stats =: monad define
avg =. mean y
sd =. std_dev y
sp =. span y
avg , sd , (100*sd%avg) , sp , (100*sp%avg)
)

error =: -~ % [

NB. x: 2-element array of the smallest and largest allowed values
NB. y: value to compare with spec range.
NB. return: y - low, 0, or y - high depending on whether y is below, in,
NB.         or above the spec range.
spec_error =: dyad define
'low high' =. x
(((-&low) ` 0: ` (-&high)) @. (>&high + >&low)"1 0) y
)

NB. From http://www.jsoftware.com/jwiki/Essays/Histogram by Roger Hui.
NB. x: list of interval separators
NB. y: list of measurements
histogram_hui =: <: @ (#/.~) @ (i.@#@[ , I.)
NB. (i.@#@[ , I.) concatenates the list of indices of x with the list of
NB. intervals for each y.
NB.
NB. If the list is called a, (#/.~) is (a #/. a) which counts the number
NB. of items for each index.  The reason the list of indices is appended
NB. is so there's at least one item in each interval.
NB.
NB. Finally, decrement so the indices are not counted, just the data.
NB.
NB. This verb has two problems.  1. The result has one more item than x,
NB. so x can't be used as an axis for plotting.  2. Items in y that are
NB. outside of x are undercounted after decrementing.

NB. Find the number of items of y in each bin defined by x.
NB. x: 3-element list: min, max, N-bins.  Bins cover equal intervals that
NB.    are open on the left.  y_i = min is not in a bin, but y_i = max is.
NB. return: A list of 2 boxes that can be passed to plot.  The 1st box is
NB.         value of the middle of each bin.  The 2nd box is the number
NB.         of y-values in that bin.
histogram =: dyad define
'min max bins' =. x
NB. N+1 equally spaced values covering [min,max] defining N equal
NB. intervals.
xs =. min + ((max - min) % bins) * i.>:bins
NB. Exclude y-values outside the binning range.  Note that the xs are the
NB. upper ends of the intervals, so y=min is not in the binning range.
indices =. <:(#~ >&0 *. <:&bins) xs I. y
(-: 2 +/\ xs) ; <: (#/.~) (i.bins) , indices
)

gaussian =: dyad define
'mean std_dev' =. x
amp =. % std_dev * %: 2p1
exp =. (*:(y - mean)) % 2 * *: std_dev
amp * ^ - exp
)

NB. Make a list with the same length as x where each value is y.
line =: #@[ # ]

combi =: dyad define
if. x = # y do. y
elseif. x = 1 do. ((#y) , 1) $ y
elseif. 1 do. (({. y) ,. (<: x) combi }. y) , 
end.
)
