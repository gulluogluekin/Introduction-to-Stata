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

capture log close session02
log using "output/logs/session-02.log", name(session02) text replace

use "data/derived/firms_2024_imported.dta", clear

* Diagnose keys, missing values, and inconsistent text.
isid firm_id
duplicates report firm_id
misstable summarize employees revenue_q1 revenue_q2 revenue_q3 revenue_q4 investment
tabulate industry_code
tabulate region_code
tabulate export_status

* Standardize string codes before merging or grouping.
replace industry_code = upper(strtrim(industry_code))
replace region_code = upper(strtrim(region_code))
replace export_status = upper(strtrim(export_status))
replace export_status = "YES" if inlist(export_status, "Y", "YES")
replace export_status = "NO" if inlist(export_status, "N", "NO")
assert inlist(export_status, "YES", "NO")

generate byte exporter = export_status == "YES"
label define exporter_label 0 "No" 1 "Yes"
label values exporter exporter_label

* Convert the ISO text date to Stata's numeric daily-date representation.
generate founded_date = daily(founded, "YMD")
format founded_date %td
assert !missing(founded_date)

* Treat an impossible negative investment as missing; do not silently turn it into zero.
list firm_id firm_name investment if investment < 0, noobs
replace investment = . if investment < 0

* Row functions make repeated-variable calculations concise.
egen quarters_reported = rownonmiss(revenue_q1 revenue_q2 revenue_q3 revenue_q4)
egen annual_revenue = rowtotal(revenue_q1 revenue_q2 revenue_q3 revenue_q4)
replace annual_revenue = . if quarters_reported < 4
egen mean_quarterly_revenue = rowmean(revenue_q1 revenue_q2 revenue_q3 revenue_q4)
generate revenue_per_employee = annual_revenue / employees if employees > 0
generate ln_annual_revenue = ln(annual_revenue) if annual_revenue > 0

label variable exporter "Firm exports"
label variable founded_date "Date founded"
label variable annual_revenue "Annual revenue"
label variable mean_quarterly_revenue "Mean quarterly revenue"
label variable revenue_per_employee "Revenue per employee"

assert annual_revenue > 0 if !missing(annual_revenue)
assert revenue_per_employee > 0 if !missing(revenue_per_employee)

drop export_status founded
order firm_id year firm_name industry_code region_code founded_date exporter
compress
save "data/derived/session02_firms_clean.dta", replace

display as result "Session 2 cleaning workflow completed."
log close session02
