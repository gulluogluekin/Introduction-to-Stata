# Session 2: Cleaning and transforming hotel records

Date: 21 September 2026

Assessment: individual checkpoint 1 of 4, worth 10% of the overall course grade.

## Learning goals

- Parse values such as `3.1 miles`, `4.3 /5`, and `_ACCOM_TYPE@Hotel`.
- Distinguish missing ratings from valid zero values.
- Rename and label variables while preserving the raw input.
- Investigate and remove records with missing keys and perfect duplicates.
- Use `assert` and `isid` as executable documentation.

## Lecture sequence: text to numbers

The guest-rating example proceeds one command at a time:

1. Inspect the original strings, such as `4.3 /5` and `NA`.
2. Reuse `split` to separate the rating from the `/5` scale, then inspect the parts.
3. Replace the known `NA` marker with an empty string in the working variable.
4. Use `destring` to create the numeric rating and compare it with the original text.
5. Remove helper variables while preserving the source string.

In the supplied Vienna CSV, `rating_reviewcount` is a string variable. Inspect its type
with `describe`, make a working copy, handle `NA`, and convert it directly. No return-code
check or programming branch is needed. The lecture avoids `force` so that unexpected
nonnumeric text is reported rather than silently converted to missing.

## Graded checkpoint 1

Complete the six TODOs in `exercise.do`, starting with the raw
`data/derived/session01_vienna_raw.dta` saved in Lecture 1. Use `center2distance`, the
distance from each hotel to the reference location named in `center2label`, and the
alternative rating (`rating2_ta`). These differ from the lecture's city-centre distance
and guest rating. Inspect `center2label` to identify the place and include its name and
the distance unit in your new variable labels. The `landmark_` prefix in the exercise's
variable names refers to this reference location. Convert distance to kilometres,
explicitly handle the rating's `NA` marker, and preserve the source strings.

Diagnose invalid identifiers and exact duplicates, then validate one observation per hotel.
Write at least three assertions covering ranges, conversion, and missingness. Submit a
do-file that saves `data/derived/session02_exercise_landmark.dta` without overwriting any
lecture dataset. Allow about 20 minutes. You do not need the lecture's cleaned output.

## Lecture to exercise variation

The lecture demonstrates parsing, conversion, and validation. The exercise transfers those
ideas to other fields and adds a change of units. The key question is whether the converted
values mean what you intended, not only whether Stata accepts the command. Read the named
help entries, check examples against actual rows, and document any missing-value decision.
