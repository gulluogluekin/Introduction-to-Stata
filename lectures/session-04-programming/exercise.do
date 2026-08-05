version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture confirm file "data/derived/firm_year_analysis.dta"
if _rc != 0 quietly do "scripts/02_build_analysis_data.do"

capture log close checkpoint04
log using "output/logs/checkpoint-04.log", name(checkpoint04) text replace
use "data/derived/firm_year_analysis.dta", clear

* TODO 1: Store three numeric variables in a local macro.
* TODO 2: Loop over them and display each 2024 mean and observation count.
* TODO 3: Use forvalues to summarize each quarterly revenue variable.
* TODO 4: Write an r-class program that returns the median and N for one variable.
* TODO 5: Call the program for investment among exporting firms and inspect return list.

display as text "Complete the TODO items and submit your do-file."
log close checkpoint04
