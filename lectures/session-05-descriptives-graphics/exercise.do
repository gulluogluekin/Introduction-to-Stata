version 18.0
clear all
set more off
set varabbrev off

capture mkdir "output/figures"
capture mkdir "output/tables"
use "data/derived/hotel_panel.dta", clear
keep if accommodation_type == "Hotel"

* TODO 1: Produce appropriate descriptives for price, distance, and rating.
* TODO 2: Create a two-way table involving city and weekend status.
* TODO 3: Export a city-level price summary to output/tables/.
* TODO 4: Make and export one distribution or group-comparison graph.
* TODO 5: Make and export one graph of price against distance or rating.
* TODO 6: Give both graphs informative titles, axes, and units.

display as text "Complete the TODO items and submit the do-file plus two exported graphs."
