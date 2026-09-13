version 18.0
clear all
set more off
set varabbrev off

capture mkdir "output/tables"
use "data/derived/hotel_prices_2017.dta", clear

* TODO 1: Append the 2018 price file and verify the composite key.
* TODO 2: Merge the hotel feature file with the correct merge cardinality.
* TODO 3: Investigate _merge and assert that every price has hotel attributes.
* TODO 4: Create price per night and a search-date identifier.
* TODO 5: Reshape a one-city subset from long to wide and back to long.
* TODO 6: Collapse mean price and quote count by city and year; export a CSV.

display as text "Complete the TODO items and submit your reproducible do-file."
