version 18.0
clear all
set more off

capture mkdir "data/derived"
capture mkdir "output"
capture mkdir "output/logs"

capture log close session01
log using "output/logs/session-01.log", name(session01) text replace

* Import a local CSV. The working directory must be the repository root.
import delimited using "data/raw/firms_2024.csv", clear varnames(1)

* Learn the shape, variables, types, and selected values.
describe
count
codebook firm_id industry_code region_code export_status
summarize employees revenue_q1 revenue_q2 revenue_q3 revenue_q4
tabulate industry_code
list firm_id firm_name industry_code employees revenue_q1 in 1/6, noobs abbreviate(22)

* A key should identify observations uniquely.
isid firm_id

* Add metadata, arrange variables, and save a Stata-format copy.
generate int year = 2024
label variable year "Calendar year"
order firm_id year firm_name
compress
save "data/derived/session01_firms_2024.dta", replace

describe using "data/derived/session01_firms_2024.dta"
display as result "Session 1 workflow completed."
log close session01
