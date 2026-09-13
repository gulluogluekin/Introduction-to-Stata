version 18.0
clear all
set more off
set varabbrev off

capture mkdir "output/figures"
use "data/derived/hotel_panel.dta", clear
keep if accommodation_type == "Hotel"

* TODO 1: Define and validate a complete-case estimation sample.
* TODO 2: Regress log nightly price on distance, rating, stars, city, and weekend.
* TODO 3: Interpret one continuous and one categorical coefficient in comments.
* TODO 4: Use margins for city and export a margins plot.
* TODO 5: Predict residuals and check whether they are centered near zero.
* TODO 6: Resample the data repeatedly and graph the distribution of mean price.

display as text "Complete the TODO items and submit the do-file plus exported figures."
