version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture mkdir "output/figures"
capture mkdir "output/tables"
capture confirm file "data/derived/firm_year_analysis.dta"
if _rc != 0 quietly do "scripts/02_build_analysis_data.do"

capture log close checkpoint05
log using "output/logs/checkpoint-05.log", name(checkpoint05) text replace
use "data/derived/firm_year_analysis.dta", clear
keep if year == 2024

* TODO 1: Produce appropriate descriptive statistics for three numeric variables.
* TODO 2: Create a two-way frequency table with row or column percentages.
* TODO 3: Export a collapsed industry-level summary to output/tables/.
* TODO 4: Make and export one distribution graph.
* TODO 5: Make and export one relationship or group-comparison graph.
* TODO 6: Give both graphs informative titles and axis labels.

display as text "Complete the TODO items and submit the do-file plus two exported graphs."
log close checkpoint05
