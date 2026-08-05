version 18.0
clear all
set more off

capture mkdir "data/derived"
capture mkdir "output"
capture mkdir "output/logs"
capture mkdir "output/tables"

capture confirm file "data/derived/firms_2024_imported.dta"
if _rc != 0 quietly do "scripts/01_prepare_data.do"

capture log close session03
log using "output/logs/session-03.log", name(session03) text replace

* Appending stacks observations with the same variables.
use "data/derived/firms_2023_imported.dta", clear
append using "data/derived/firms_2024_imported.dta", generate(source_file)
isid firm_id year
tabulate year source_file

* Clean the key codes before merging lookup tables.
replace industry_code = upper(strtrim(industry_code))
replace region_code = upper(strtrim(region_code))

* A many-to-one merge adds one lookup record to many firms.
merge m:1 industry_code using "data/derived/industry_lookup.dta"
tabulate _merge
assert _merge == 3
drop _merge

merge m:1 region_code using "data/derived/region_lookup.dta"
assert _merge == 3
drop _merge

* Wide quarterly columns become a long firm-quarter panel.
reshape long revenue_q, i(firm_id year) j(quarter)
rename revenue_q revenue
isid firm_id year quarter
sort firm_id year quarter

list firm_id year quarter revenue in 1/12, noobs sepby(firm_id)

* Collapse creates a new dataset at the requested level of observation.
preserve
collapse (mean) mean_revenue=revenue (count) firm_quarters=revenue, ///
    by(year industry_name)
sort year industry_name
export delimited using "output/tables/session03-industry-summary.csv", replace
list, noobs sepby(year)
restore

save "data/derived/session03_firm_quarter.dta", replace
display as result "Session 3 combining and reshaping workflow completed."
log close session03
