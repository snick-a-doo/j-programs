require 'math/fftw/fftw'

seed =: {.&(1 _1)

NB. Filter a list by repeated shifting adding and normalizing.
filter =: dyad define
(%>./)@:(+1&|.)^:x seed y
)

binomial_gaussian =: monad define
c =. -:y
NB. The coefficient should be (2^y) % %: c*o.1 but it's not important; use 1 to
NB. keep numbers from getting too large.
a =. 1
b =. *: (i.y) - c
a*^-b%c
)

NB. Do the same as 'filter' by multiplying by a Gaussian in the frequency domain.
fft_filter =: dyad define
total =. x*y
spectrum =.(fftw binomial_gaussian total) * (fftw total$seed y)
NB. The imaginary part should be 0; return just the real.
(%>./) {.|:+. y {. ifftw spectrum
)
