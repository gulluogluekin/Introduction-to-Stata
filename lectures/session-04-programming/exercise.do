version 18.0
clear all
set more off
set varabbrev off

use "data/derived/hotel_panel.dta", clear
keep if accommodation_type == "Hotel"

* TODO 1: Store price_per_night, distance, and rating in a local macro.
* TODO 2: Loop over the macro and display each mean and observation count.
* TODO 3: Loop over the three cities and summarize nightly price in each one.
* TODO 4: Write an r-class program that returns N, mean, and median.
* TODO 5: Call the program for central Vienna hotels and inspect return list.

display as text "Complete the TODO items and submit your do-file."
