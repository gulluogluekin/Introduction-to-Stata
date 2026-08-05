version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture confirm file "data/derived/firms_2024_imported.dta"
if _rc != 0 quietly do "scripts/01_prepare_data.do"

capture log close checkpoint02
log using "output/logs/checkpoint-02.log", name(checkpoint02) text replace
use "data/derived/firms_2024_imported.dta", clear

* TODO 1: Standardize industry_code, region_code, and export_status.
* TODO 2: Create and label a numeric exporter indicator.
* TODO 3: Convert founded to a numeric Stata date and apply %td formatting.
* TODO 4: Replace negative investment with missing and explain why zero is different.
* TODO 5: Create annual_revenue but set it missing when fewer than four quarters exist.
* TODO 6: Add at least two assert statements that document data expectations.

display as text "Complete the TODO items, save a clean dataset, and submit this do-file."
log close checkpoint02
