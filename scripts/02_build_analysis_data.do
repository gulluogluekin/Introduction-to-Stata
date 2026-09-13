version 18.0
clear all
set more off
set varabbrev off

use "data/derived/hotel_prices_2017.dta", clear
append using "data/derived/hotel_prices_2018.dta"
isid hotel_id year month weekend holiday nnights

merge m:1 hotel_id using "data/derived/hotel_features.dta"
assert _merge == 3
drop _merge

generate search_month = ym(year, month)
format search_month %tm
label variable search_month "Month of price search"

generate double price_per_night = price / nnights
label variable price_per_night "Price per night (EUR)"

generate double ln_price = ln(price_per_night)
label variable ln_price "Log price per night"

generate byte central_hotel = distance <= 2 if !missing(distance)
label define central_label 0 "More than 2 miles" 1 "Within 2 miles"
label values central_hotel central_label

encode city, generate(city_id)
label variable city_id "Search city"

assert inlist(city, "Budapest", "Vienna", "Zagreb")
assert price_per_night > 0
assert inlist(nnights, 1, 4)
assert inlist(weekend, 0, 1)

order hotel_id city city_id year month search_month weekend holiday nnights ///
    price price_per_night accommodation_type distance stars rating
compress
save "data/derived/hotel_panel.dta", replace

preserve
    collapse (count) price_quotes=price_per_night ///
        (mean) mean_price=price_per_night mean_rating=rating, by(city year)
    export delimited using "output/tables/hotel_city_year_summary.csv", replace
restore
