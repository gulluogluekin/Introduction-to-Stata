version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture mkdir "output/figures"
capture confirm file "data/derived/firm_year_analysis.dta"
if _rc != 0 quietly do "scripts/02_build_analysis_data.do"

capture log close checkpoint06
log using "output/logs/checkpoint-06.log", name(checkpoint06) text replace
use "data/derived/firm_year_analysis.dta", clear

* TODO 1: Define a complete-case estimation sample for your selected variables.
* TODO 2: Regress log annual revenue on firm size, investment, year, and one factor variable.
* TODO 3: Explain one continuous and one categorical coefficient in comments.
* TODO 4: Use margins for the categorical predictor and export a margins plot.
* TODO 5: Predict residuals and check whether they are centered near zero.
* TODO 6: Write a small simulation program that returns a sample mean.

display as text "Complete the TODO items and submit the do-file plus exported figure."
log close checkpoint06
