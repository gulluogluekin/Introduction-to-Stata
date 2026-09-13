version 18.0
clear all
set more off
set varabbrev off

* Optional, ungraded supplementary exercise; not the Session 6 exam.
* Session 6 is the final exam (60%); it covers material taught in Sessions 1-5.
* Regression and resampling here are supplementary, not additional exam topics.
capture mkdir "output"
capture mkdir "output/figures"
use "data/derived/hotel_panel.dta", clear

* Transfer task: adapt supplementary lecture.do's model and resampling program,
* rather than rerunning them. Change how stars enter, which predictions you plot,
* and which statistic you resample. Allow about 20-25 minutes; keep the code compact.

* TODO 1: Define one sample of Hotels with 0 < price_per_night <= 1000, nonmissing
*         ln_price, distance, rating, city_id, and weekend, and stars in 1,2,3,4,5.
*         Count and validate the retained quotes. Whole-star categories are a
*         deliberate sample restriction, not a claim that half-star values are
*         invalid: Stata's factor-variable notation requires integer codes.
*         Help: help f_missing; help f_inlist; help assert; help fvvarlist.
* TODO 2: Adapt the lecture regression using stars as categories rather than a
*         continuous predictor. Keep distance and rating continuous, include city
*         and weekend categories, and use robust standard errors. In comments,
*         interpret the rating coefficient and one star-category coefficient,
*         naming its reference category. How does the star interpretation differ
*         from a single coefficient per additional star? Help: help fvvarlist;
*         help regress. These are conditional associations, not causal effects.
* TODO 3: Calculate adjusted predictions by weekend status, not by city, and
*         export output/figures/session06_exercise_weekend_margins.png. Label the
*         vertical axis as predicted log price per night, not euros; identify
*         weekday/weekend categories. Help: help margins; help marginsplot.
* TODO 4: Predict residuals only for e(sample), summarize them, and comment on
*         whether their mean is close to zero. Why does this alone not establish
*         that the model is a good explanation? Help: help regress postestimation.
* TODO 5: Adapt the lecture's resampling program to return the MEDIAN nightly
*         price from 60 quotes sampled with replacement from this estimation
*         sample. Give it a new name and simulate 250 repetitions with a fixed
*         seed. Help: help summarize (detail and stored results); help return;
*         help bsample; help simulate. Keep preserve/restore inside the program.
* TODO 6: Summarize and graph the simulated medians; export
*         output/figures/session06_exercise_median_resampling.png. Label the
*         statistic and euro units. In comments, explain what changes across
*         repetitions. This resamples individual quotes, not whole hotels: use it
*         to illustrate variation, not uncertainty for a full-sample hotel estimate.
*         Note: simulate replaces the data in memory; do not save over the input.

display as text "Optional ungraded practice: keep your do-file, interpretations, and both figures."
