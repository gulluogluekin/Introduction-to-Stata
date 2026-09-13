# Teaching data

The committed inputs are real, attributed teaching data from Békés and Kézdi's *Data
Analysis for Business, Economics, and Policy*. They are stored locally so all six sessions
work without a live download.

- `hotelbookingdata-vienna.csv`: the official raw Vienna extract (430 rows). Its deliberately
  awkward strings, missing ratings, and duplicate records support Sessions 1–2.
- `hotelbookingdata-central-europe.csv`: an unmodified-row extract of the full European raw
  file containing Vienna, Budapest, and Zagreb (6,908 rows). It covers ten search dates in
  2017–2018 and supports Sessions 3–6.

The source anonymized the hotels and slightly altered the records to protect confidentiality.
Use is limited to educational, non-commercial purposes; see `DATA_LICENSE.md`.

Run `scripts/01_prepare_data.do` to clean the CSV inputs and create separate hotel-feature
and annual price files. Run `scripts/02_build_analysis_data.do` to append and merge those
files into the analysis panel. Generated `.dta` files are written to `data/derived/` and are
not committed.
