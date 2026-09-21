version 18.0
clear all
set more off
set varabbrev off

* Assessment: individual checkpoint 1 of 4; 10% of the overall course grade.
* Prerequisite: the raw .dta saved in Lecture 1, not Lecture 2's cleaned output.
* Variation: clean a different distance and rating, then change distance units.
use "data/derived/session01_vienna_raw.dta", clear

* center2label names a reference location. center2distance gives each hotel's
* distance to that location. The landmark_ prefix below refers to this location.
*
* TODO 1: Inspect center2label to identify the place that center2distance measures
*         distance to. Inspect center2distance to check the unit, and rating2_ta
*         to identify the text used for an unavailable alternative rating.
* TODO 2: Adapt the lecture's distance conversion to create landmark_distance_miles
*         from center2distance. Preserve the source string. Label the new variable
*         as distance to the place named in center2label, in miles (help destring).
* TODO 3: Create double-precision landmark_distance_km using 1 mile = 1.609344 kilometres.
*         Label it and inspect both units for a few rows (help generate).
* TODO 4: Create numeric alternative_rating from rating2_ta, explicitly treating
*         "NA" as missing. Preserve rating2_ta, document the conversion, and
*         check that missing ratings have not become zeros (help destring).
* TODO 5: Diagnose missing hotel identifiers and exact duplicate records before
*         removing them. Keep one valid observation per hotel and explain your
*         decisions. Do not remove hotels only because their rating is missing.
* TODO 6: Check the hotel key with isid and write at least three assertions for
*         distance ranges, the unit conversion, and rating/missingness rules.
*         Save data/derived/session02_exercise_landmark.dta, leaving lecture
*         datasets unchanged. Explain why numeric conversion alone is not validation.

display as text "Complete the six TODO items, save your validated variation, and submit this do-file."
