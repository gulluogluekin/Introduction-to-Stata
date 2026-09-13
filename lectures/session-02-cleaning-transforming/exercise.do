version 18.0
clear all
set more off
set varabbrev off

capture mkdir "data/derived"
import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear

* TODO 1: Convert center1distance from a string with "miles" to a numeric variable.
* TODO 2: Extract a readable accommodation type from accommodationtype.
* TODO 3: Convert guestreviewsrating to a numeric 0–5 rating.
* TODO 4: Recode a zero star rating as missing and explain the decision.
* TODO 5: Investigate missing hotel_id values and perfect duplicate records.
* TODO 6: Validate the cleaned key and ranges with isid and at least three asserts.

display as text "Complete the TODO items, save a clean hotel file, and submit this do-file."
