# Session 3: Combining and reshaping

Date: 28 September 2026

## Learning goals

- Identify the unit of observation and test whether keys are unique.
- Distinguish `append` from `merge` and inspect merge results before dropping `_merge`.
- Reshape quarterly variables from wide to long form.
- Aggregate observations to a new unit with `collapse`.

## Files

- `lecture.do`: appends years, merges lookup data, reshapes revenue, and exports a summary.
- `exercise.do`: checkpoint reproducing the complete combination workflow.

## Checkpoint

Submit a do-file that ends with one row per firm-year-quarter and exports a region-year
summary. Include at least one `isid` and one merge assertion.

## Before the next session

Read `help append`, `help merge`, `help reshape`, and `help collapse`.
