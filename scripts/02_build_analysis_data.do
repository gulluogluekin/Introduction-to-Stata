version 18.0
clear all
set more off

capture mkdir "data/derived"
capture mkdir "output"
capture mkdir "output/logs"

capture confirm file "data/derived/firms_2024_imported.dta"
if _rc != 0 {
    quietly do "scripts/01_prepare_data.do"
}

capture log close build
log using "output/logs/02_build_analysis_data.log", name(build) text replace

use "data/derived/firms_2023_imported.dta", clear
append using "data/derived/firms_2024_imported.dta"
isid firm_id year

replace industry_code = upper(strtrim(industry_code))
replace region_code = upper(strtrim(region_code))
replace export_status = upper(strtrim(export_status))
replace export_status = "YES" if inlist(export_status, "Y", "YES")
replace export_status = "NO" if inlist(export_status, "N", "NO")
assert inlist(export_status, "YES", "NO")

generate byte exporter = export_status == "YES"
label define exporter_label 0 "No" 1 "Yes"
label values exporter exporter_label
drop export_status

generate founded_date = daily(founded, "YMD")
format founded_date %td
assert !missing(founded_date)
drop founded

replace investment = . if investment < 0
egen quarters_reported = rownonmiss(revenue_q1 revenue_q2 revenue_q3 revenue_q4)
egen annual_revenue = rowtotal(revenue_q1 revenue_q2 revenue_q3 revenue_q4)
replace annual_revenue = . if quarters_reported < 4
egen mean_quarterly_revenue = rowmean(revenue_q1 revenue_q2 revenue_q3 revenue_q4)
generate revenue_per_employee = annual_revenue / employees if employees > 0
generate ln_annual_revenue = ln(annual_revenue) if annual_revenue > 0

merge m:1 industry_code using "data/derived/industry_lookup.dta", assert(3) nogen
merge m:1 region_code using "data/derived/region_lookup.dta", assert(3) nogen

encode industry_name, generate(industry_id)
encode region_name, generate(region_id)

label variable firm_id "Synthetic firm identifier"
label variable year "Calendar year"
label variable employees "Employees"
label variable exporter "Firm exports"
label variable investment "Annual investment"
label variable annual_revenue "Annual revenue"
label variable revenue_per_employee "Revenue per employee"
label variable ln_annual_revenue "Log annual revenue"
label variable founded_date "Date founded"

order firm_id year firm_name industry_code industry_name region_code region_name
compress
save "data/derived/firm_year_analysis.dta", replace

reshape long revenue_q, i(firm_id year) j(quarter)
rename revenue_q revenue
label variable quarter "Quarter"
label variable revenue "Quarterly revenue"
isid firm_id year quarter
sort firm_id year quarter
compress
save "data/derived/firm_quarter_analysis.dta", replace

display as result "Built clean firm-year and firm-quarter analysis datasets."
log close build
