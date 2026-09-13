version 18.0
clear all
set more off
set varabbrev off

capture log close session03
log using "output/logs/session03.log", name(session03) text replace

use "data/derived/hotel_prices_2017.dta", clear
isid hotel_id year month weekend holiday nnights
append using "data/derived/hotel_prices_2018.dta"
isid hotel_id year month weekend holiday nnights

merge m:1 hotel_id using "data/derived/hotel_features.dta"
tabulate _merge
assert _merge == 3
drop _merge

generate double price_per_night = price / nnights
label variable price_per_night "Price per night (EUR)"
egen search_id = group(year month weekend holiday nnights), label

preserve
    keep if city == "Vienna" & accommodation_type == "Hotel"
    keep hotel_id search_id price_per_night
    isid hotel_id search_id
    reshape wide price_per_night, i(hotel_id) j(search_id)
    describe price_per_night*
    reshape long price_per_night, i(hotel_id) j(search_id)
    isid hotel_id search_id
restore

preserve
    collapse (count) price_quotes=price_per_night ///
        (mean) mean_price=price_per_night, by(city year)
    list, separator(0)
    export delimited using "output/tables/session03_city_year.csv", replace
restore

save "data/derived/session03_hotel_panel.dta", replace
log close session03
