version 18.0
clear all
set more off
set varabbrev off

capture log close session04
log using "output/logs/session04.log", name(session04) text replace

use "data/derived/hotel_panel.dta", clear
keep if accommodation_type == "Hotel" & price_per_night <= 1000

local numeric_variables price_per_night distance rating
foreach variable of local numeric_variables {
    quietly summarize `variable'
    display as result "`variable': mean=" %9.2f r(mean) " N=" %8.0f r(N)
}

levelsof city, local(cities)
foreach place of local cities {
    quietly summarize price_per_night if city == `"`place'"'
    display as text `"`place': mean nightly price="' %9.2f r(mean)
}

forvalues selected_year = 2017/2018 {
    quietly count if year == `selected_year'
    display as text "Observations in `selected_year': " r(N)
}

capture program drop hotel_summary
program define hotel_summary, rclass
    version 18.0
    syntax varname [if]
    marksample touse
    quietly summarize `varlist' if `touse', detail
    return scalar N = r(N)
    return scalar mean = r(mean)
    return scalar median = r(p50)
end

hotel_summary price_per_night if city == "Vienna"
return list
assert r(N) > 0

log close session04
