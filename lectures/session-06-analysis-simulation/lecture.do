version 18.0
clear all
set more off
set varabbrev off

capture log close session06
log using "output/logs/session06.log", name(session06) text replace

use "data/derived/hotel_panel.dta", clear
keep if accommodation_type == "Hotel"
keep if price_per_night <= 1000 & !missing(distance, rating, stars)

regress ln_price c.distance c.rating c.stars i.city_id i.weekend, vce(robust)
assert e(N) > 100

margins city_id
marginsplot, ///
    title("Adjusted hotel price by search city") ///
    ytitle("Predicted log price per night")
graph export "output/figures/session06_city_margins.png", replace width(1600)

predict residual if e(sample), residuals
summarize residual
twoway scatter residual distance if e(sample), msize(vsmall) ///
    yline(0) title("Regression residuals and distance") ///
    xtitle("Distance to city center (miles)") ytitle("Residual")
graph export "output/figures/session06_residuals.png", replace width(1600)

capture program drop resample_mean_price
program define resample_mean_price, rclass
    version 18.0
    preserve
    bsample 60
    quietly summarize price_per_night
    return scalar mean = r(mean)
    restore
end

simulate mean_price=r(mean), reps(250) seed(20260914) nodots: ///
    resample_mean_price
summarize mean_price
histogram mean_price, percent ///
    title("Resampling distribution of mean hotel price") ///
    xtitle("Mean price per night (EUR)") ytitle("Percent")
graph export "output/figures/session06_resampling.png", replace width(1600)

log close session06
