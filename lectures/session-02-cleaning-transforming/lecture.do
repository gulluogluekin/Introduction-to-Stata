* SESSION 2: CLEANING AND TRANSFORMING HOTEL RECORDS
* We start again from the raw CSV so every cleaning decision is reproducible.
* Read and run this do-file from top to bottom. Comments beginning with * are
* explanations, not commands. Inspect intermediate results before moving on.

* SETUP AND LOGGING
* Use Stata 18's command behaviour and remove any previous dataset from memory.
* clear all does not delete files, but unsaved work in memory will be lost.
version 18.0
clear all

* Avoid pauses in long output and require full, unambiguous variable names.
set more off
set varabbrev off

* Close this session's log if it is open; capture allows the command to continue
* when there is no such log. The next line opens a fresh plain-text log containing
* the commands and text output. replace overwrites only the log at this path.
* Work from the course project's top folder, with output/logs/ already present.
capture log close session02
log using "output/logs/session02.log", name(session02) text replace

* LOAD THE RAW INPUT AND GIVE VARIABLES SHORTER NAMES
* Read the CSV into memory. varnames(1) takes the names from its first row, and
* clear permits replacing data already in memory. The raw file on disk is unchanged.
import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear

* rename takes an old name followed by a new name. It changes neither values nor
* storage types. Use the new names in all subsequent commands in this do-file.
rename addresscountryname country
rename s_city city
rename starrating stars

* CONVERT DISTANCE TEXT TO A NUMBER
* A string such as "3.1 miles" is text, even though it contains digits.
* destring interprets numeric text as numbers. generate(distance) creates a new
* variable, preserving center1distance for comparison with the source.
* ignore(" miles") permits removal of the space and the letters m, i, l, e, s.
* This is appropriate for the known unit text here; it is not a conversion of units.
* The resulting value 3.1 is still a distance in miles.
destring center1distance, generate(distance) ignore(" miles")

* A variable label describes meaning and units. It does not rename the variable
* or change its values. Clear labels help someone else interpret the saved data.
label variable distance "Distance to city center (miles)"

* SEPARATE THE ACCOMMODATION CATEGORY FROM ITS PREFIX
* split divides text at the character specified by parse(). For example,
* "_ACCOM_TYPE@Hotel" becomes "_ACCOM_TYPE" and "Hotel".
* generate(accommodation_part) supplies the prefix for the new variable names:
* accommodation_part1 and accommodation_part2. The original is initially retained.
split accommodationtype, parse("@") generate(accommodation_part)

* With variable names, drop removes columns. Keep the useful category in part2
* and remove part1 and the original column from memory. The raw CSV is untouched.
drop accommodation_part1 accommodationtype

* Give the remaining category column a meaningful name. It is still text.
rename accommodation_part2 accommodation_type

* CONVERT THE GUEST RATING IN SEPARATE STEPS
* Guest ratings arrive as text, for example "4.3 /5" or "NA".
* Step 1: inspect the original values and their frequencies before changing them.
* "NA" is an ordinary string to Stata, not an automatically recognized missing value.
tabulate guestreviewsrating, missing

* Step 2: split at the slash, just as we split at @ above.
* The first part holds the rating. The second part holds the scale (5).
split guestreviewsrating, parse("/") generate(rating_part)

* rename changes the first helper's name. list then lets us check the split
* against the original string in the first eight rows of the current dataset.
rename rating_part1 rating_text
list guestreviewsrating rating_text rating_part2 in 1/8

* Step 3: "NA" means unavailable. An empty string is a missing text value.
* replace modifies an existing variable. The single = assigns a new value;
* == tests whether the old value matches "NA". if limits the replacement to
* those observations, so valid rating strings are left alone.
replace rating_text = "" if rating_text == "NA"

* Step 4: convert the cleaned text to a new numeric variable.
* Without force, destring reports any unexpected nonnumeric text.
* An empty string becomes numeric missing, shown as a dot (.). It does not
* become zero: an unavailable rating and a genuine rating of zero are different.
destring rating_text, generate(rating)
label variable rating "Guest rating (0–5)"

* Step 5: compare the original text and the numeric result.
* The first list shows examples. The second selects all records marked "NA"
* in the source, so we can check that their numeric ratings really are missing.
list guestreviewsrating rating_text rating in 1/8
list guestreviewsrating rating if guestreviewsrating == "NA"

* Step 6: remove the helper variables. Keep the original source string.
drop rating_text rating_part2

* CONVERT THE NUMBER OF REVIEWS
* Review counts are also text in this CSV because some entries contain "NA".
* describe shows their storage type. We inspect the known input instead of
* writing a program that chooses between different possible variable types.
describe rating_reviewcount

* generate creates a working copy so the source field remains available to check.
* Because rating_reviewcount contains text, rating_count_text also contains text.
generate rating_count_text = rating_reviewcount

* Apply the same explicit missing-value decision as for the guest rating.
replace rating_count_text = "" if rating_count_text == "NA"

* Create the numeric count. Compare it with the original before dropping the
* temporary text column. Neither conversion changes the CSV on disk.
destring rating_count_text, generate(rating_count)
list rating_reviewcount rating_count in 1/8
drop rating_count_text

* CHECK MISSING VALUES AND DUPLICATE RECORDS
* For this cleaning rule, a star category of zero means unavailable. Store it
* as numeric missing (.) rather than using it as a genuine zero-star value.
* This is a decision about this field, not a rule that all zeros should be missing.
replace stars = . if stars == 0

* Count missing identifiers before removing any rows. A missing identifier cannot
* tell us which hotel an observation belongs to.
count if missing(hotel_id)

* With no variable list, duplicates report compares every column. Unlike the
* Session 1 check of hotel_id alone, this identifies completely identical rows.
duplicates report

* drop if removes observations (rows), rather than named variables (columns).
* The vertical bar | means OR: remove a row if either its hotel ID or price is
* missing. Missing ratings alone are not a reason to remove a hotel here.
drop if missing(hotel_id) | missing(price)

* With no variable list, duplicates drop keeps one copy of each entirely
* identical row. It does not choose between different records for the same hotel.
duplicates drop

* VALIDATE THE CLEANED DATA
* assert checks a condition and stops the do-file if it is false. These checks
* record what we expect; they do not repair values. If one fails, investigate
* the input or cleaning steps rather than deleting the check to keep going.
* _N is the current number of observations. Removing two duplicate rows from
* this specific 430-row extract should leave 428; other datasets need other checks.
assert _N == 428

* isid requires hotel_id to be unique and nonmissing. This is stronger than a
* duplicate report: if the key is invalid, execution stops before saving the data.
isid hotel_id

* ! means NOT. Check nonnegative distances only for observations with a known
* distance, and require known ratings to lie between 0 and 5, including endpoints.
assert distance >= 0 if !missing(distance)
assert inrange(rating, 0, 5) if !missing(rating)

* Check the missing-value decisions against the preserved source fields.
assert missing(rating) if guestreviewsrating == "NA"
assert missing(rating_count) if rating_reviewcount == "NA"

* Missing prices were removed above. The remaining prices must be positive.
assert price > 0

* DOCUMENT AND SAVE THE RESULT
* Labels explain what the numeric variables mean. For example, the identifier
* is an anonymized code, not a measure to interpret or average like a price.
label variable hotel_id "Anonymized hotel identifier"
label variable price "Quoted price (EUR)"
label variable stars "Hotel star rating"
label variable rating_count "Number of guest ratings"

* compress chooses smaller storage types where that can be done without losing
* information. It does not round the data or remove observations.
compress

* Save the cleaned dataset separately from Session 1's raw .dta and the CSV.
* The data/derived/ folder must exist. replace allows rerunning the do-file and
* overwriting this cleaned output; it does not overwrite the raw input files.
save "data/derived/session02_vienna_clean.dta", replace

* Stop recording this session's commands and text output.
log close session02

* For more detail in Stata, try help split, help destring, help missing,
* help duplicates, or help assert. Use the examples to check your understanding.
