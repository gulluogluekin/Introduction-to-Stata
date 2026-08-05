# Teaching data

All files in `data/raw/` are synthetic and committed so the course works without internet
access. They are treated as immutable inputs.

- `firms_2024.csv`: wide quarterly firm records with deliberately inconsistent text coding
  and a small number of missing or invalid values for cleaning exercises.
- `firms_2023.csv`: a comparable prior-year extract used to teach appending.
- `industry_lookup.csv`: industry labels.
- `region_lookup.csv`: region labels and reference characteristics.

Run `scripts/01_prepare_data.do` to import the CSV inputs. Run
`scripts/02_build_analysis_data.do` to create the clean firm-year and firm-quarter datasets
used in later sessions. Generated `.dta` files are written to `data/derived/` and are not
committed.

The files do not describe real firms, people, or financial outcomes.
