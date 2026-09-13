version 18.0
clear all
set more off
set varabbrev off

* Assessment: ungraded Session 1 practice; no graded submission is required.
* Prerequisite: the lecture saved data/derived/session01_vienna_raw.dta.
* Variation: open Stata's native format and inspect different fields/subsamples.
* Keep the lecture's dataset unchanged; save your own copy under a new name.

capture mkdir "output"
capture mkdir "output/logs"
capture log close session01exercise
log using "output/logs/session01_exercise.log", name(session01exercise) text replace

* TODO 1: Load data/derived/session01_vienna_raw.dta, saved during the lecture.
*         Read help use to find the syntax. Why does this file need a different
*         command from a CSV? Explain in a comment; do not re-import the CSV.
* TODO 2: Use describe and codebook to inspect center2distance, rating2_ta, and
*         starrating. Which are strings? Explain why saving a .dta does not
*         automatically clean these values. Check that all 430 rows are present.
* TODO 3: Tabulate starrating, including missing values, then count records with
*         exactly three stars. Adapt the lecture's count if example.
* TODO 4: Summarize price separately for three-star and four-star records using
*         if qualifiers (help summarize). Comment on the two means. Check that
*         the dataset still has 430 rows: summarizing a subset should not drop it.
* TODO 5: Give your copy a new dataset label and save it as
*         data/derived/session01_exercise_vienna.dta. Clear the data from memory,
*         reopen your saved copy, and verify its label and 430 rows. Make your
*         script safe to rerun without overwriting the lecture's input file.

display as text "Ungraded practice: complete the five TODO items, rerun, and keep your do-file."
log close session01exercise
