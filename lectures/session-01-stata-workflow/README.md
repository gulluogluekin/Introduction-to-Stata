# Session 1: Stata workflow and raw hotel data

Date: 14 September 2026

## Learning goals

- Work from the repository root with a do-file and text log.
- Import the raw Vienna hotel CSV and identify its unit of observation.
- Use `describe`, `codebook`, `summarize`, `tabulate`, and `list` deliberately.
- Diagnose missing identifiers and duplicate hotel records before cleaning.
- Save an imported Stata dataset without modifying the raw CSV.

## Data context

The file contains raw, anonymized hotel offers collected for Békés and Kézdi's *Data
Analysis for Business, Economics, and Policy*. Its 430 rows include awkward string fields,
missing ratings, and duplicate records that later sessions will clean.

## Checkpoint

Complete the TODO items in `exercise.do`. Submit a do-file that imports the raw CSV,
documents the unit of observation, inspects candidate identifiers, and saves an imported
`.dta` file under `data/derived/`.
