pwd
use "data/IKEA_SA_Furniture_Web_Scrapings_CLEAN.dta", clear

*** 9. Aggregate, reshape and combine data for analysis in Stata ***
*** 10. Prepare a sample for analysis by filtering observations and variables and creating transformations of variables ***

** Let's filter only the variables of interest for the graphing and regressio n**

keep index item_id price _sellable_online _other_colors 

save "data/IKEA_SA_Furniture_Web_Scrapings_subset.dta", replace


** Oops, I dropped too many variables, hence let's merge the dataset together again and restart making a sample **

use "data/IKEA_SA_Furniture_Web_Scrapings_subset.dta", clear

merge 1:m index using "data/IKEA_SA_Furniture_Web_Scrapings_CLEAN.dta", keep(match)

** Let's resort variables of interest **

drop name category old_price sellable_online link other_colors short_description designer

** Let's save the adequate subset for regression and graphing **

save "data/IKEA_SA_Furniture_Web_Scrapings_subset_correct.dta", replace
