# Session 2: Cleaning and transforming

Date: 21 September 2026

## Learning goals

- Diagnose inconsistent codes, missing values, duplicates, and impossible values.
- Standardize strings and convert text dates to Stata dates.
- Create indicators, row totals, means, ratios, and logs.
- Use labels and `assert` statements to record data expectations.

## Files

- `lecture.do`: cleans the 2024 firm extract and creates derived measures.
- `exercise.do`: checkpoint that recreates the central cleaning decisions.

## Checkpoint

Submit a do-file that creates a validated clean dataset. Invalid negative investment must
be treated as missing, and incomplete annual revenue must not be reported as a complete
four-quarter total.

## Before the next session

Read `help missing`, `help string functions`, `help datetime`, `help egen`, and
`help assert`.
