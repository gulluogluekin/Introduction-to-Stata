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

* TODO 1: Inspect center2label to identify the place that center2distance measures
*         distance to. Inspect center2distance to check the unit, and rating2_ta
*         to identify the text used for an unavailable alternative rating.
* center2label = Donauturm, center2distance = miles, rating2_ta missing marker = "NA"
* Reference location: Donauturm, Distance unit: miles, Missing marker in rating2_ta: "NA"

* TODO 2: Adapt the lecture's distance conversion to create landmark_distance_miles
*         from center2distance. Preserve the source string. Label the new variable
*         as distance to the place named in center2label, in miles (help destring).
* destring center2distance, generate(landmark_distance_miles) ignore(" miles")
label variable landmark_distance_miles "Distance to Donauturm (miles)"

* TODO 3: Create double-precision landmark_distance_km using 1 mile = 1.609344 kilometres.
*         Label it and inspect both units for a few rows (help generate).
* generate double landmark_distance_km = landmark_distance_miles * 1.609344
* label variable landmark_distance_km "Distance to Donauturm (kilometres)"
* list landmark_distance_miles landmark_distance_km in 1/10

* TODO 4: Create numeric alternative_rating from rating2_ta, explicitly treating
*         "NA" as missing. Preserve rating2_ta, document the conversion, and
*         check that missing ratings have not become zeros (help destring).
* 
* TODO 5: Diagnose missing hotel identifiers and exact duplicate records before
*         removing them. Keep one valid observation per hotel and explain your
*         decisions. Do not remove hotels only because their rating is missing.
* count if missing(hotel_id) - no missing hotel_id
* list hotel_id if missing(hotel_id) 
* duplicates report - exact duplicate is 2 
* duplicates list - after duplicate drop is 428

* TODO 6: Check the hotel key with isid and write at least three assertions for
*         distance ranges, the unit conversion, and rating/missingness rules.
*         Save data/derived/session02_exercise_landmark.dta, leaving lecture
*         datasets unchanged. Explain why numeric conversion alone is not validation.
* isid hotel_id
* For distance range: assert landmark_distance_miles >= 0 if !missing(landmark_distance_miles)
* For conversation check: assert abs(landmark_distance_km - landmark_distance_miles * 1.609344) < 1e-10 ///
    if !missing(landmark_distance_miles)
* For rating range: assert inrange(alternative_rating, 2, 5) if !missing(alternative_rating)
* NA in source must become numeric missing: assert missing(alternative_rating) if rating2_ta == "NA"

display as text "Complete the six TODO items, save your validated variation, and submit this do-file."
