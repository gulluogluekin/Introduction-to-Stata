# Session 2: Cleaning and transforming hotel records

Date: 21 September 2026

Assessment: individual checkpoint 1 of 4, worth 10% of the overall course grade.

## Learning goals

- Parse values such as `3.1 miles`, `4.3 /5`, and `_ACCOM_TYPE@Hotel`.
- Distinguish missing ratings from valid zero values.
- Rename and label variables while preserving the raw input.
- Investigate and remove records with missing keys and perfect duplicates.
- Use `assert` and `isid` as executable documentation.

## Graded checkpoint 1

Complete the six TODOs in `exercise.do`, starting with the raw
`data/derived/session01_vienna_raw.dta` saved in Lecture 1. Use the alternative landmark
distance (`center2distance`) and alternative rating (`rating2_ta`) rather than copying
the lecture's city-centre distance and guest-rating transformations. Convert distance
to kilometres, explicitly handle the rating's `NA` marker, and preserve the source strings.

Diagnose invalid identifiers and exact duplicates, then validate one observation per hotel.
Write at least three assertions covering ranges, conversion, and missingness. Submit a
do-file that saves `data/derived/session02_exercise_landmark.dta` without overwriting any
lecture dataset. Allow about 20 minutes. You do not need the lecture's cleaned output.

## Lecture to exercise variation

The lecture demonstrates parsing, conversion, and validation. The exercise transfers those
ideas to other fields and adds a change of units. The key question is whether the converted
values mean what you intended, not only whether Stata accepts the command. Read the named
help entries, check examples against actual rows, and document any missing-value decision.
