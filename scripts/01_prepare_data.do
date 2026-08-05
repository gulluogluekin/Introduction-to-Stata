version 18.0
clear all
set more off

capture mkdir "data/derived"
capture mkdir "output"
capture mkdir "output/logs"

capture log close prepare
log using "output/logs/01_prepare_data.log", name(prepare) text replace

foreach year in 2023 2024 {
    import delimited using "data/raw/firms_`year'.csv", clear varnames(1)
    generate int year = `year'
    order firm_id year firm_name
    isid firm_id
    compress
    save "data/derived/firms_`year'_imported.dta", replace
}

import delimited using "data/raw/industry_lookup.csv", clear varnames(1)
replace industry_code = upper(strtrim(industry_code))
isid industry_code
compress
save "data/derived/industry_lookup.dta", replace

import delimited using "data/raw/region_lookup.csv", clear varnames(1)
replace region_code = upper(strtrim(region_code))
isid region_code
compress
save "data/derived/region_lookup.dta", replace

display as result "Imported raw CSV files into data/derived/."
log close prepare
