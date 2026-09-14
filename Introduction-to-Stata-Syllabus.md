# Introduction to Stata (ECBS5241)

**Academic year** 2026–2027 · **Term** Fall · **Host unit** Department of Economics<br>
**Course level** 7 · **US credits** 1 · **ECTS credits** 2<br>
**Instructor** Ulrich Wohak, PhD · [wohaku@ceu.edu](mailto:wohaku@ceu.edu)<br>
**Meetings** Mondays, 08:50–10:30 · 14 September–19 October 2026 (5 teaching sessions and a final exam) · Room TBC<br>
**Course repository** [github.com/ulrichwohak/Introduction-to-Stata](https://github.com/ulrichwohak/Introduction-to-Stata)

---

## Background and overall aim

**Content.** This course introduces Stata as a reproducible research environment. Students
learn to organize a project, write and run do-files, import and validate data, clean and
transform variables, combine and reshape datasets, automate repeated tasks, produce
descriptive output and graphics, and carry out a descriptive analysis. The five teaching
sessions contribute to one complete workflow that can be rerun from raw data. The sixth
meeting is the final in-class exam.

**Relevance.** Stata is widely used in economics, public policy, and other quantitative social
sciences. Reliable research requires more than knowing individual commands: analysts must
understand the unit of observation, test keys, record cleaning decisions, separate raw inputs
from generated outputs, and produce results that another person can reproduce. The course
emphasizes these habits from the first do-file.

**Scope.** The course is entirely in Stata. Git may be used to distribute updates, but the
command line, Git, Python, and other programming languages are not course topics.

## Course prerequisites and technical requirements

There is no formal programming prerequisite. Students should be comfortable with basic
quantitative concepts such as variables, observations, means, percentages, and simple linear
relationships.

Students must bring a laptop to every session and have:

- Stata 18 or newer, with permission to create and modify local files.
- A local copy of the course repository.
- Internet access for obtaining course updates; the teaching workflow itself works offline.

Before Session 1, students should open Stata, change the working directory to the repository
root, and confirm that Stata can run:

```stata
do "scripts/00_master.do"
```

Students who cannot access the required Stata version should contact the instructor before
the first meeting.

## Waiting list handling

Priority is given to students from the Department of Economics, with special attention to
students in Economics, Data, and Policy programs. Other students are admitted from the
waiting list subject to program priorities and available places.

## Learning outcomes

By the end of the course, students will be able to:

- Organize a reproducible Stata project using relative paths, do-files, logs, and a master
  script.
- Import CSV and Stata data, inspect storage types and values, identify the unit of
  observation, and validate candidate keys.
- Diagnose and correct unit-bearing strings, missing values, duplicate records, and invalid
  values.
- Generate, label, and verify transformed variables using documented assumptions.
- Append, merge, reshape, and aggregate data while checking that the resulting unit of
  observation is correct.
- Automate repeated work with local macros, loops, conditions, and a small reusable Stata
  program.
- Produce descriptive tables and purposeful graphics and export them reproducibly.
- Read unfamiliar Stata output and documentation and explain every submitted command and
  analytic decision.

Supplementary materials introduce regression, adjusted predictions, and resampling. These
are available for further study and are outside the exam scope for the five-session
teaching plan.

## Learning activities and teaching methods

The course consists of five interactive 100-minute teaching sessions and a final in-class
exam in the sixth scheduled meeting. Teaching time combines concise
explanations, live coding, prediction questions, debugging, and individual practice. Students
type, run, inspect, and revise code throughout the session rather than watching a completed
demonstration.

The teaching sessions have two connected components:

1. An annotated lecture do-file introduces the session's concepts.
2. An exercise applies a variation of those concepts to real, anonymized hotel-price data.

Session 1's exercise is ungraded practice. In Sessions 2–5, students submit an individual,
reproducible exercise attempt as the graded checkpoint. There is no checkpoint in the exam
meeting.

The course uses hotel data prepared for Békés and Kézdi's Data Analysis for Business,
Economics, and Policy. The source anonymized and slightly altered hotel records to protect
confidentiality. Small attributed extracts are committed to the repository, so classroom
work does not require a live data download.

## Assessment

The course is graded **Pass/Fail** on a total score out of 100. A total score of **60 or
higher** is required to pass.

| Component | Weight | Detail |
| --- | ---: | --- |
| In-class checkpoints | 40% | Four short individual do-files in Sessions 2–5, each worth 10% of the total course score. Assessed for a reasonable, reproducible attempt. |
| Final in-class exam | 60% | Individual exam in Session 6 on 19 October, covering the material taught in Sessions 1–5. |

Session 1 is ungraded practice. Session 6 has the final exam and no checkpoint. The
four checkpoints and the final exam are the only graded components.

### In-class checkpoints

Checkpoint work is assessed on whether the student:

- Uses the requested Stata concepts for the session.
- Works from the repository root with relative paths.
- Preserves raw inputs and writes generated material to the designated folders.
- Includes useful validation or diagnostic commands.
- Submits an executable do-file with concise comments.

Perfect results are not required for full checkpoint credit; a complete and clearly documented
attempt is. Submission instructions and any make-up procedure are announced in class.

### Final in-class exam

The individual final exam takes place during Session 6 on 19 October 2026. It assesses
the Stata concepts and reproducible workflow taught in Sessions 1–5. There is no new
lecture or separate checkpoint in this meeting.

The exam format, duration within the scheduled meeting, task-level marking scheme,
dataset, permitted resources, and submission instructions are **TBD** and will be
announced before the exam. Assessment tasks and marking materials are distributed
separately by the instructor, rather than in the public repository.

## AI and assistance policy

In-class checkpoints are completed without generative AI or AI-enabled coding tools unless an
activity explicitly states otherwise. Students may consult Stata's built-in help and the
course materials.

The final exam's permitted-resource and AI rules are **TBD** and will be announced before
the exam. Permission to use help or other resources during practice and checkpoints does
not establish permission to use them in the exam. Students remain responsible for every
submitted line and conclusion.

## Course contents and schedule

### Session 1 — 14 September · Stata workflow

- Stata's data, command, results, and do-file workflow.
- Repository structure, relative paths, logs, and generated output.
- Importing a CSV; `describe`, `codebook`, `summarize`, `tabulate`, and `list`.
- Candidate keys, duplicate reports, labels, compression, and saving `.dta` files.
- Ungraded practice: load the saved `.dta` file, inspect different fields, and compare
  star-category subsamples.

### Session 2 — 21 September · Cleaning and transforming

- Diagnosing missingness, duplicate hotel records, and inconsistent strings.
- Parsing distances, guest ratings, accommodation types, and night counts.
- Numeric conversion, missing-value decisions, labels, and units.
- Assertions as executable documentation of data expectations.
- Checkpoint 1 (10%): clean alternative distance/rating fields, convert units, and validate
  hotel records.

### Session 3 — 28 September · Combining and reshaping

- Unit of observation and key structure.
- Appending annual hotel-price extracts and validating stacked records.
- Many-to-one merges of repeated prices and hotel attributes; interpretation of `_merge`.
- Wide and long search-date data, `reshape`, and `collapse`.
- Checkpoint 2 (10%): reverse the merge perspective and reshape city-month aggregates.

### Session 4 — 5 October · Programming in Stata

- Local macros and evaluation with backticks and apostrophes.
- `foreach` and `forvalues` loops for genuinely repeated work.
- Conditional execution based on data and stored results.
- Small r-class programs, `syntax`, `marksample`, and returned scalars.
- Checkpoint 3 (10%): automate cutoff comparisons with a reusable spread-summary program.

### Session 5 — 12 October · Descriptive analysis and graphics

- Choosing descriptive statistics for variables and questions.
- Grouped tables, correlations, aggregation, and export.
- Histograms, bar charts, scatterplots, fitted lines, labels, and graph export.
- Distinguishing informative graphics from decorative output.
- Checkpoint 4 (10%): compare star categories with robust summaries and two purposeful
  graphs.

### Session 6 — 19 October · Final in-class exam

- Individual final exam, worth 60% of the total course score.
- Scope: material taught in Sessions 1–5.
- No new lecture and no checkpoint.
- Detailed exam instructions: **TBD**, to be announced before the exam.

The existing `session-06-analysis-simulation` scripts remain available as supplementary,
ungraded material. They are not the exam paper or a sixth teaching session.

## Course materials and reproducibility

All required classroom files are stored in the course repository. Attributed hotel CSV files
live under `data/raw/`; derived `.dta` files, logs, figures, and tables are regenerated and
are not part of the published source history. The data are covered by source-specific reuse
terms documented in `DATA_LICENSE.md`: hotel files are for educational, non-commercial use.

For instructor verification, the complete repository workflow, including supplementary
analysis examples, is:

```stata
do "scripts/00_master.do"
```

Students should use Stata's `help` command before relying on third-party examples. Relevant
reference material includes Stata's official documentation, Békés and Kézdi's
[Data Analysis for Business, Economics, and Policy](https://gabors-data-analysis.com/), and
the Data Carpentry [Economics with Stata](https://datacarpentry.org/stata-economics/)
lessons. Dataset documentation is available for
[hotels in Vienna](https://gabors-data-analysis.com/datasets/hotels-vienna/),
[hotels in Europe](https://gabors-data-analysis.com/datasets/hotels-europe/). The official CEU
module description is available in the
[Study Guide](https://ceu.studyguide.timeedit.net/modules/ECBS5241?mainTab=module&type=CORE),
and meeting dates are published in the CEU timetable.
