version 18.0
clear all
set more off
set varabbrev off

* Assessment: individual checkpoint 3 of 4; 10% of the overall course grade.
* Run from the project root using the prepared analysis dataset.
capture mkdir "output"
capture mkdir "output/logs"
capture log close session04_exercise
log using "output/logs/session04_exercise.log", name(session04_exercise) text replace

use "data/derived/hotel_panel.dta", clear
keep if accommodation_type == "Hotel"

* Variation: automate choices of sample cutoff, not just variables or cities,
* and measure spread rather than repeating the lecture's mean/median summary.

* TODO 1: Use help summarize, summarize with detail, and return list to find
* the standard deviation and quartiles of price_per_night. The interquartile
* range (IQR) is the 75th percentile minus the 25th percentile.

* TODO 2: Adapt the lecture program into an r-class program named hotel_spread.
* Accept one numeric variable and an optional if condition; use marksample
* so both the condition and missing values are respected. Return N, sd, and
* iqr. Make the definition rerunnable without "program already defined" errors.

* TODO 3: Put upper price cutoffs 100, 200, and 500 in a local macro. Loop over
* them, calling hotel_spread for price_per_night at or below each cutoff.
* Display the cutoff, N, SD, and IQR each time. Read or store returned results
* before another command replaces them; do not permanently drop observations.

* TODO 4: For one cutoff, check the program's results against a direct
* summarize, detail call on the same sample. Record the comparison in a comment.

* TODO 5: Test hotel_spread on rating, which contains missing values, and on
* price_per_night with a condition that selects no observations (price below 0).
* Inspect return list. Verify that missing ratings are excluded, and that an
* empty sample returns N = 0 with missing SD/IQR rather than misleading zeros.

* TODO 6: In two sentences, explain how changing the price cutoff changes
* the sample and its measured spread. Note that N counts price quotes,
* not distinct hotels.

display as text "Complete the TODO items and submit your do-file."
log close session04_exercise
