version 18.0
clear all
set more off
set varabbrev off

capture log close session01
log using "output/logs/session01.log", name(session01) text replace

display as text "Session 1: importing and inspecting raw Vienna hotel data"

import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear
assert _N == 430

describe
codebook hotel_id price accommodationtype center1distance guestreviewsrating
summarize price starrating rating_reviewcount
tabulate accommodationtype, missing

list hotel_id price accommodationtype center1distance guestreviewsrating ///
    in 1/8, abbreviate(20)

* A candidate identifier must be nonmissing and unique.
count if missing(hotel_id)
duplicates report hotel_id

label data "Raw Vienna hotel offers imported in Session 1"
save "data/derived/session01_vienna_raw.dta", replace

log close session01
