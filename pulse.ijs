require 'format/printf'
require '~/programs/J/table.ijs'

data_path =: '/media/sf_C_DRIVE/data/2920/Iowa State/%s.RPT'

get_data =: monad define
read_table data_path sprintf < y
)

summary =: monad define
(<(37+i.6);i.4){ get_data y
)

peaks =: monad define
(<(87+i.6);i.4){ get_data y
)

NB. Loop calibration syringe injection areas.
syringe =: monad define
(<(80+i.3);3){ get_data y
)

NB. Loop calibration loop injection areas.
loop =: monad define
(<(89+i.3);3){ get_data y
)

dispersion =: monad define
107 1 report data_path sprintf < y
)

area_ratio =: ((<_1 2)&{ % (<0 2)&{)"2

ads_fraction =: -@:<:@:%@:area_ratio

loop_qty =: monad define
(<105;6) { get_data y
)

NB. Calculate quantity adsorbed from a pulse chemisorption
NB. analysis. 
NB. x: gas quantity in the loop
NB. y: list of peak areas
NB. return: Quantity adsorbed
qty_ads =: * # - +/ % {:

sub =: dyad define
'start n col' =. x
(<(start + i.n);col) { y
)

