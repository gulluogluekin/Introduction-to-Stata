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

* Guest ratings arrive as text, for example "4.3 /5" or "NA".
* Step 1: inspect the original values.
tabulate guestreviewsrating, missing

* Step 2: split at the slash, just as we split at @ above.
* The first part holds the rating. The second part holds the scale (5).
split guestreviewsrating, parse("/") generate(rating_part)
rename rating_part1 rating_text
list guestreviewsrating rating_text rating_part2 in 1/8

* Step 3: "NA" means unavailable. An empty string is a missing text value.
replace rating_text = "" if rating_text == "NA"

* Step 4: convert the cleaned text to a new numeric variable.
* Without force, destring reports any unexpected nonnumeric text.
destring rating_text, generate(rating)
label variable rating "Guest rating (0–5)"

* Step 5: compare the original text and the numeric result.
list guestreviewsrating rating_text rating in 1/8
list guestreviewsrating rating if guestreviewsrating == "NA"

* Step 6: remove the helper variables. Keep the original source string.
drop rating_text rating_part2

* Review counts are also text in this CSV because some entries contain "NA".
describe rating_reviewcount

* Work on a copy, mark unavailable counts as missing, then convert to numbers.
generate rating_count_text = rating_reviewcount
replace rating_count_text = "" if rating_count_text == "NA"
destring rating_count_text, generate(rating_count)
list rating_reviewcount rating_count in 1/8
drop rating_count_text

replace stars = . if stars == 0
count if missing(hotel_id)
duplicates report

drop if missing(hotel_id) | missing(price)
duplicates drop

assert _N == 428
isid hotel_id
assert distance >= 0 if !missing(distance)
assert inrange(rating, 0, 5) if !missing(rating)
assert missing(rating) if guestreviewsrating == "NA"
assert missing(rating_count) if rating_reviewcount == "NA"
assert price > 0

label variable hotel_id "Anonymized hotel identifier"
label variable price "Quoted price (EUR)"
label variable stars "Hotel star rating"
label variable rating_count "Number of guest ratings"

compress
save "data/derived/session02_vienna_clean.dta", replace
log close session02
