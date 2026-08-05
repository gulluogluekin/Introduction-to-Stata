version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture mkdir "output/figures"
capture confirm file "data/derived/firm_year_analysis.dta"
if _rc != 0 quietly do "scripts/02_build_analysis_data.do"

capture log close session06
log using "output/logs/session-06.log", name(session06) text replace
use "data/derived/firm_year_analysis.dta", clear

drop if missing(ln_annual_revenue, employees, investment)

* Factor-variable notation tells Stata which predictors are categorical.
regress ln_annual_revenue c.employees c.investment i.exporter i.year ///
    i.industry_id, vce(robust)
estimates store main_model

* Margins converts model coefficients into adjusted predictions.
margins exporter
marginsplot, ///
    title("Adjusted log revenue by export status") ///
    ytitle("Predicted log annual revenue") ///
    name(export_margins, replace)
graph export "output/figures/session06-export-margins.png", replace width(1600)

predict fitted_log_revenue, xb
predict regression_residual, residuals
summarize regression_residual

twoway scatter regression_residual fitted_log_revenue, ///
    yline(0, lcolor(maroon)) ///
    xtitle("Fitted log revenue") ytitle("Residual") ///
    title("Residual diagnostic") ///
    name(residual_plot, replace)
graph export "output/figures/session06-residuals.png", replace width(1600)

* Simulation reveals sampling variation by repeating the same random experiment.
capture program drop draw_mean
program define draw_mean, rclass
    version 18.0
    preserve
    sample 12, count
    quietly summarize annual_revenue
    return scalar mean = r(mean)
    restore
end

simulate sample_mean=r(mean), reps(250) seed(5241) nodots: draw_mean
summarize sample_mean, detail
histogram sample_mean, normal percent ///
    title("Sampling distribution of the mean") ///
    xtitle("Mean annual revenue in samples of 12") ///
    name(mean_simulation, replace)
graph export "output/figures/session06-sampling-distribution.png", replace width(1600)

display as result "Session 6 analysis and simulation workflow completed."
log close session06
