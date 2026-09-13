version 18.0
clear all
set more off
set varabbrev off

capture log close session02
log using "output/logs/session02.log", name(session02) text replace

import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear

rename addresscountryname country
rename s_city city
rename starrating stars

destring center1distance, generate(distance) ignore(" miles")
label variable distance "Distance to city center (miles)"

split accommodationtype, parse("@") generate(accommodation_part)
drop accommodation_part1 accommodationtype
rename accommodation_part2 accommodation_type

generate str8 rating_text = substr(guestreviewsrating, 1, ///
    strpos(guestreviewsrating, " ") - 1)
destring rating_text, generate(rating) force
drop rating_text
label variable rating "Guest rating (0–5)"

capture confirm numeric variable rating_reviewcount
if _rc == 0 {
    clonevar rating_count = rating_reviewcount
}
else {
    destring rating_reviewcount, generate(rating_count) force
}

replace stars = . if stars == 0
count if missing(hotel_id)
duplicates report

drop if missing(hotel_id) | missing(price)
duplicates drop

assert _N == 428
isid hotel_id
assert distance >= 0 if !missing(distance)
assert inrange(rating, 0, 5) if !missing(rating)
assert price > 0

label variable hotel_id "Anonymized hotel identifier"
label variable price "Quoted price (EUR)"
label variable stars "Hotel star rating"
label variable rating_count "Number of guest ratings"

compress
save "data/derived/session02_vienna_clean.dta", replace
log close session02
