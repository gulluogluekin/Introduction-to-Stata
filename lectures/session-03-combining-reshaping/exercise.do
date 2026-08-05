version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture confirm file "data/derived/firms_2023_imported.dta"
if _rc != 0 quietly do "scripts/01_prepare_data.do"

capture log close checkpoint03
log using "output/logs/checkpoint-03.log", name(checkpoint03) text replace

use "data/derived/firms_2023_imported.dta", clear

* TODO 1: Append the 2024 imported dataset and verify firm_id year is unique.
* TODO 2: Standardize the industry and region keys.
* TODO 3: Merge both lookup datasets and investigate _merge before dropping it.
* TODO 4: Reshape revenue_q1-revenue_q4 into a firm-quarter dataset.
* TODO 5: Collapse mean revenue by year and region, then export a CSV summary.

display as text "Complete the TODO items and submit your reproducible do-file."
log close checkpoint03
