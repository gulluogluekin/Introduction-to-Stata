version 18.0
clear all
set more off
set varabbrev off

* Assessment: individual checkpoint 2 of 4; 10% of the overall course grade.
* Run from the project root after the prepared data files have been supplied
* or created. This exercise uses only the 2018 prices, not both years.
capture mkdir "output"
capture mkdir "output/tables"
use "data/derived/hotel_features.dta", clear

* Variation: start with one row per hotel rather than repeated price quotes.
* Then reshape a summary table, not the individual hotel/search observations.

* TODO 1: Verify that hotel_id uniquely identifies the feature records.
* Explain in a comment why hotel_id need not be unique in a price file.

* TODO 2: With features still in memory, merge in hotel_prices_2018.dta from
* data/derived. Use help merge to select the cardinality for this direction.

* TODO 3: Tabulate _merge and count feature records without a 2018 quote.
* Explain what these unmatched records mean; do not assume all records match.
* Verify that no price quote lacks features. Keep matched observations for
* the price summary, then remove _merge.

* TODO 4: Generate price_per_night. Collapse its mean (mean_price) and
* nonmissing quote count (price_quotes) by city and month. Verify the new key.
* These are quote counts, not counts of distinct hotels.

* TODO 5: Reshape both summary variables wide: one row per city, with month
* identifying the columns. List the result and explain one column suffix.

* TODO 6: Reshape back to long, verify the city/month key, and export
* output/tables/session03_exercise_city_month.csv. Add a comment explaining
* why this table needs a different reshape key from the lecture's hotel panel.

display as text "Complete the TODO items and submit your reproducible do-file."
