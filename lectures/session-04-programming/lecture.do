version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture confirm file "data/derived/firm_year_analysis.dta"
if _rc != 0 quietly do "scripts/02_build_analysis_data.do"

capture log close session04
log using "output/logs/session-04.log", name(session04) text replace
use "data/derived/firm_year_analysis.dta", clear

* Local macros store text for the current do-file or program.
local outcomes annual_revenue employees investment
local target_year 2024

foreach variable of local outcomes {
    quietly summarize `variable' if year == `target_year'
    display as text "`variable': mean = " as result %9.2f r(mean) ///
        as text ", N = " as result %5.0f r(N)
}

* forvalues is convenient for numeric sequences.
forvalues quarter = 1/4 {
    quietly summarize revenue_q`quarter' if year == `target_year'
    display as text "Quarter `quarter' mean revenue: " as result %9.2f r(mean)
}

* Conditions let code respond to results without manual editing.
quietly summarize annual_revenue if year == `target_year'
if r(mean) > 10000 {
    display as result "Mean annual revenue exceeds 10,000 in `target_year'."
}
else {
    display as result "Mean annual revenue is at most 10,000 in `target_year'."
}

* A small r-class program packages a repeated calculation.
capture program drop firmstats
program define firmstats, rclass
    version 18.0
    syntax varname [if]
    marksample sample
    quietly summarize `varlist' if `sample'
    return scalar mean = r(mean)
    return scalar sd = r(sd)
    return scalar N = r(N)
    display as text "`varlist': mean = " as result %9.2f r(mean) ///
        as text ", sd = " as result %9.2f r(sd) ///
        as text ", N = " as result %5.0f r(N)
end

firmstats revenue_per_employee if year == 2024
return list

display as result "Session 4 programming workflow completed."
log close session04
