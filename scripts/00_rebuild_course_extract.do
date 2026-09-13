version 18.0
clear all
set more off
set varabbrev off

* Instructor utility. It is not called by the student-facing master script.
* Download the full raw file from https://osf.io/yzntm/download and pass its
* local path as the first argument:
*
* do "scripts/00_rebuild_course_extract.do" "path/to/hotelbookingdata.csv"

args source_file
if `"`source_file'"' == "" {
    display as error "Provide the local path to hotelbookingdata.csv."
    exit 198
}

confirm file `"`source_file'"'
import delimited using `"`source_file'"', varnames(1) clear
keep if inlist(s_city, "Budapest", "Vienna", "Zagreb")
sort s_city hotel_id year month weekend holiday price_night
assert _N == 6908
export delimited using "data/raw/hotelbookingdata-central-europe.csv", replace
