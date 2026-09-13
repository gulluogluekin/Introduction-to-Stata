# Session 1: Stata workflow and raw hotel data

Date: 14 September 2026

Assessment: ungraded practice. There is no graded checkpoint in Session 1.

## Learning goals

- Work from the repository root with a do-file and text log.
- Import the raw Vienna hotel CSV and identify its unit of observation.
- Use `describe`, `codebook`, `summarize`, `tabulate`, and `list` deliberately.
- Diagnose missing identifiers and duplicate hotel records before cleaning.
- Save an imported Stata dataset without modifying the raw CSV.
- Reopen a native `.dta` file and adapt inspection commands to selected observations.

## Data context

The file contains raw, anonymized hotel offers collected for Békés and Kézdi's *Data
Analysis for Business, Economics, and Policy*. Its 430 rows include awkward string fields,
missing ratings, and duplicate records that later sessions will clean.

## Ungraded practice

Complete the five TODO items in `exercise.do` after the lecture has saved
`data/derived/session01_vienna_raw.dta`. Start with that file, not the original CSV.
Use `help use` to learn how Stata opens its native format, inspect different fields, and
compare prices for three-star and four-star records without removing observations.
Save a separately labelled copy as `data/derived/session01_exercise_vienna.dta`, then
clear and reopen it to check that the saved file contains what you intended.

Keep your reproducible do-file for practice; no graded submission is required.
It also produces `output/logs/session01_exercise.log`.
Allow about 15-20 minutes. The lecture's input and output must remain unchanged.

## Lecture to exercise variation

The lecture imports a CSV, inspects the full sample, and saves a Stata dataset. The
exercise opens that saved dataset with a different command, investigates other variables,
and uses conditional summaries. Students explain what changes and what stays the same,
including the distinction between data in memory and a file on disk.
