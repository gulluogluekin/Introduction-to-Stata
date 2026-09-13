version 18.0
clear all
set more off
set varabbrev off

capture mkdir "data/derived"
capture mkdir "output/logs"
capture log close session01exercise
log using "output/logs/session01_exercise.log", name(session01exercise) text replace

import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear
assert _N == 430

* TODO 1: State the unit of observation in a comment.
* TODO 2: Use codebook on hotel_id, price, and two raw string variables.
* TODO 3: Summarize price, star rating, and the number of guest reviews.
* TODO 4: Count missing hotel identifiers and report duplicate hotel_id values.
* TODO 5: Save the imported data under data/derived/ without changing the CSV.

display as text "Complete the five TODO items, rerun the file, and submit this do-file."
log close session01exercise
