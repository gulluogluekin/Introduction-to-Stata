* SESSION 1: IMPORTING AND INSPECTING RAW HOTEL DATA
* A do-file is a saved sequence of Stata commands. Run the commands in order.
* Lines beginning with * are comments: Stata ignores them when executing the file.
* The purpose today is to inspect the raw data, not to clean or delete records.

* SETUP: START FROM A KNOWN STATE
* Use Stata 18's command behaviour, even when running a newer Stata version.
version 18.0

* Remove the current dataset and other objects from memory. This does not delete
* files on disk. Save any work you want to keep before running this command.
clear all

* Display output continuously instead of pausing at each --more-- prompt.
* The output is still shown; Stata simply does not wait for a keypress to continue.
set more off

* Require full variable names rather than allowing shortened, ambiguous names.
set varabbrev off

* RECORD THE SESSION IN A LOG
* Close the named log if it is already open. Here, capture lets us continue if
* there is no such log to close. It is housekeeping, not a data-cleaning step.
capture log close session01

* Paths are relative to Stata's current working folder. Work from the top folder
* of the course project: output/logs/ means the logs folder inside output/.
* The folders must exist already; opening a log does not create its parent folders.
* log using records subsequent commands and text output, including error messages.
* name(session01) identifies this log, text makes it a plain-text file, and replace
* allows a rerun to overwrite the previous log at this exact path.
log using "output/logs/session01.log", name(session01) text replace

* Print a heading in the Results window and log. This does not change the data.
display as text "Session 1: importing and inspecting raw Vienna hotel data"

* IMPORT THE CSV INTO MEMORY
* import delimited reads a text table, such as a comma-separated-values file.
* using gives the file path. The comma before varnames starts the options.
* varnames(1) uses the first row as variable names instead of a data observation.
* clear permits replacing any dataset currently in memory. The CSV is unchanged.
import delimited using "data/raw/hotelbookingdata-vienna.csv", varnames(1) clear

* _N is the number of observations currently in memory. The raw extract has 430
* rows, including duplicates. == tests equality; assert stops the do-file if the
* condition is false. This check helps detect loading the wrong input file.
assert _N == 430

* INSPECT THE DATA WITHOUT CHANGING IT
* describe reports the dataset's structure rather than individual row values.
* Storage type tells us how values are stored: str# is text, while byte and int
* are integer types. A number stored as text cannot yet be used in arithmetic.
* Display format tells us how a value is shown, not what value is stored:
* %13s displays text in a 13-character field; %8.0g is general numeric formatting
* in an 8-character field. In a g format, .0 lets Stata choose the decimal places.
* A variable label is a longer description; it is separate from the variable name.
describe

* codebook gives a closer look at the listed variables, including their types,
* missing values, and examples or ranges. Look for unexpected codes and strings.
* An observation is one row, and a variable is one column. Each raw row here
* describes a hotel offer, but repeated records mean rows are not yet unique hotels.
codebook hotel_id price accommodationtype center1distance guestreviewsrating

* summarize calculates numerical statistics such as the mean, standard deviation,
* minimum, and maximum. These calculations use nonmissing numeric observations.
* rating_reviewcount is text in this CSV because some entries contain "NA".
* Including it here does not convert it: we clean and convert it in Session 2.
summarize price starrating rating_reviewcount

* tabulate counts how often each accommodation category occurs. The missing
* option includes missing values in the table instead of excluding them.
tabulate accommodationtype, missing

* list displays actual values for selected variables. in 1/8 selects rows 1 to 8
* in the current order; it does not select hotels whose identifiers are 1 to 8.
* /// continues the same command on the next line. Run both lines together.
* abbreviate(20) allows variable headings up to 20 characters in this listing.
* It changes only the display, not the variable names stored in the dataset.
list hotel_id price accommodationtype center1distance guestreviewsrating ///
    in 1/8, abbreviate(20)

* CHECK WHETHER hotel_id CAN IDENTIFY ONE ROW
* A usable identifier must be present and unique. missing(hotel_id) is true for
* a missing identifier, and if restricts the count to rows meeting that condition.
* count reports how many rows meet it; it does not remove them.
count if missing(hotel_id)

* Check repeated hotel identifiers. Here we compare hotel_id only, so rows can
* share an identifier while differing in other fields. This report diagnoses a
* potential problem; it does not prove that entire rows are duplicates or delete any.
duplicates report hotel_id

* SAVE A STATA DATASET WHILE KEEPING THE RAW CSV
* label data adds a description for the dataset as a whole. It changes metadata,
* not observation values, and is different from labelling an individual variable.
label data "Raw Vienna hotel offers imported in Session 1"

* save writes the dataset in memory to a native .dta file, including variable
* types, formats, and labels. This saves data, not the do-file or the log.
* The data/derived/ folder must exist: save creates a file, not its parent folder.
* replace overwrites this output if it exists. The original CSV is left unchanged.
* This raw .dta is the starting file for the exercises in Sessions 1 and 2.
save "data/derived/session01_vienna_raw.dta", replace

* Finish the log so later commands are no longer recorded in this session's file.
log close session01

* To read the documentation, type help followed by a command name in Stata's
* Command window, for example: help describe, help summarize, or help save.
* Look for the command's purpose, syntax, options, and worked examples.
