version 18.0
clear all
set more off
set varabbrev off

capture mkdir "data/derived"

* -----------------------------------------------------------------------------
* Vienna: one deliberately messy raw observation per hotel
* -----------------------------------------------------------------------------
import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear
assert _N == 430

rename addresscountryname country
rename s_city city
rename starrating stars
rename rating2_ta ratingta
rename rating2_ta_reviewcount ratingta_count

destring center1distance, generate(distance) ignore(" miles")
destring center2distance, generate(distance_alter) ignore(" miles")

split accommodationtype, parse("@") generate(accommodation_part)
drop accommodation_part1 accommodationtype
rename accommodation_part2 accommodation_type

generate byte nnights = cond(strpos(price_night, "4 nights") > 0, 4, 1)
generate str8 rating_text = substr(guestreviewsrating, 1, ///
    strpos(guestreviewsrating, " ") - 1)
destring rating_text, generate(rating) force
drop rating_text

capture confirm numeric variable rating_reviewcount
if _rc == 0 {
    clonevar rating_count = rating_reviewcount
}
else {
    destring rating_reviewcount, generate(rating_count) force
}

replace stars = . if stars == 0
drop if missing(hotel_id) | missing(price)
duplicates drop
isid hotel_id

label variable hotel_id "Anonymized hotel identifier"
label variable price "Quoted price (EUR)"
label variable nnights "Number of nights in quoted price"
label variable distance "Distance to city center (miles)"
label variable distance_alter "Distance to alternative center (miles)"
label variable rating "Guest rating (0–5)"
label variable rating_count "Number of guest ratings"
label variable stars "Hotel star rating"

compress
save "data/derived/hotels_vienna_clean.dta", replace

* -----------------------------------------------------------------------------
* Central European panel: repeated price searches for three cities
* -----------------------------------------------------------------------------
import delimited using "data/raw/hotelbookingdata-central-europe.csv", ///
    varnames(1) clear
assert _N == 6908

rename addresscountryname country
rename s_city city
rename starrating stars
rename rating2_ta ratingta
rename rating2_ta_reviewcount ratingta_count

destring center1distance, generate(distance) ignore(" miles")
destring center2distance, generate(distance_alter) ignore(" miles")

split accommodationtype, parse("@") generate(accommodation_part)
drop accommodation_part1 accommodationtype
rename accommodation_part2 accommodation_type

generate byte nnights = cond(strpos(price_night, "4 nights") > 0, 4, 1)
generate str8 rating_text = substr(guestreviewsrating, 1, ///
    strpos(guestreviewsrating, " ") - 1)
destring rating_text, generate(rating) force
drop rating_text

capture confirm numeric variable rating_reviewcount
if _rc == 0 {
    clonevar rating_count = rating_reviewcount
}
else {
    destring rating_reviewcount, generate(rating_count) force
}

replace stars = . if stars == 0
drop if missing(hotel_id) | missing(price)
duplicates drop
assert _N == 6859
isid hotel_id year month weekend holiday nnights

label variable hotel_id "Anonymized hotel identifier"
label variable price "Quoted price (EUR)"
label variable nnights "Number of nights in quoted price"
label variable distance "Distance to city center (miles)"
label variable distance_alter "Distance to alternative center (miles)"
label variable rating "Guest rating (0–5)"
label variable rating_count "Number of guest ratings"
label variable stars "Hotel star rating"

preserve
    keep hotel_id accommodation_type country city city_actual neighbourhood ///
        center1label distance center2label distance_alter stars rating ///
        rating_count ratingta ratingta_count
    sort hotel_id
    by hotel_id: keep if _n == 1
    isid hotel_id
    compress
    save "data/derived/hotel_features.dta", replace
restore

keep hotel_id price offer offer_cat year month weekend holiday nnights scarce_room
isid hotel_id year month weekend holiday nnights
compress

preserve
    keep if year == 2017
    save "data/derived/hotel_prices_2017.dta", replace
restore

keep if year == 2018
save "data/derived/hotel_prices_2018.dta", replace
