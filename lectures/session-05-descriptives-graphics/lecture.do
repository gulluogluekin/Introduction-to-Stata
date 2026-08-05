version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture mkdir "output/figures"
capture mkdir "output/tables"
capture confirm file "data/derived/firm_year_analysis.dta"
if _rc != 0 quietly do "scripts/02_build_analysis_data.do"

capture log close session05
log using "output/logs/session-05.log", name(session05) text replace
use "data/derived/firm_year_analysis.dta", clear
keep if year == 2024

summarize employees annual_revenue investment revenue_per_employee, detail
tabulate industry_name exporter, row
tabstat annual_revenue employees investment, by(industry_name) ///
    statistics(n mean median sd min max) columns(statistics)
correlate employees investment annual_revenue

preserve
collapse (count) firms=firm_id (mean) mean_revenue=annual_revenue ///
    mean_employees=employees, by(industry_name exporter)
sort industry_name exporter
export delimited using "output/tables/session05-descriptive-table.csv", replace
restore

histogram annual_revenue, percent width(2500) ///
    title("Distribution of annual firm revenue") ///
    xtitle("Annual revenue") ytitle("Percent") ///
    name(revenue_histogram, replace)
graph export "output/figures/session05-revenue-histogram.png", replace width(1600)

graph bar (mean) annual_revenue, over(industry_name, label(angle(30))) ///
    ytitle("Mean annual revenue") ///
    title("Revenue differs across synthetic industries") ///
    name(industry_bar, replace)
graph export "output/figures/session05-industry-revenue.png", replace width(1600)

twoway ///
    (scatter annual_revenue employees, mcolor(navy%55) msize(medsmall)) ///
    (lfit annual_revenue employees, lcolor(maroon)), ///
    legend(order(1 "Firm" 2 "Linear fit")) ///
    xtitle("Employees") ytitle("Annual revenue") ///
    title("Firm size and annual revenue") ///
    name(size_scatter, replace)
graph export "output/figures/session05-size-revenue.png", replace width(1600)

display as result "Session 5 descriptive and graphics workflow completed."
log close session05
