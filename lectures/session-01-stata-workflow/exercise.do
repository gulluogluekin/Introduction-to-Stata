version 18.0
clear all
set more off

capture mkdir "output"
capture mkdir "output/logs"
capture log close checkpoint01
log using "output/logs/checkpoint-01.log", name(checkpoint01) text replace

import delimited using "data/raw/firms_2023.csv", clear varnames(1)

describe
count

* TODO 1: Use codebook on firm_id, industry_code, and export_status.
* TODO 2: Summarize employees and the four quarterly revenue variables.
* TODO 3: Check that firm_id uniquely identifies every row with isid.
* TODO 4: Generate year = 2023, label it, and move it after firm_id.
* TODO 5: Save your completed dataset under data/derived/.

display as text "Complete the five TODO items, rerun the file, and submit this do-file."
log close checkpoint01
