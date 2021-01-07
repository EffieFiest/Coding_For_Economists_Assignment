*******************************************
********** STATA ASSIGNMENT ***************
*******************************************

*** 6. Break up work into smaller components using Stata.do files ***
*** 7. Read .csv data in Stata ***


** Before starting my code I check my working directory
** and set it accordingly to load the data into stata 
** I also used the "mkdir" function to make the "code" and "graph&reg" folders,
** however, I deleted them from the coding lines here as whenever I re-run my do files to make 
** sure they work ok, I receive an error message that the directory has already been made. 


clear
pwd
cd "/Users/EffieFiest/Documents/CEU/Coding/"
ls
cd "/Users/EffieFiest/Documents/CEU/Coding/stata"
import delimited "data/IKEA_SA_Furniture_Web_Scrapings_sss.csv", encoding ("utf-8")

** I loaded open-source data on IKEA stores in Saudia Arabia. The online catalogue was web-scraped (Kaggle) and the final webscraping csv file for Saudi Arabian IKEA stores will be used for this assignment. I thought it is a fun dataset to work with ***
**The data was downloaded from: https://www.kaggle.com/ahmedkallam/ikea-sa-furniture-web-scraping **


*** 5. Automate repeating tasks using Stata "for" loops. 
*** 8. Fix common data quality errors in Stata (for example string vs. number, missing values) ***
*** 9. Aggregate, reshape, and combine data for analysis in Stata *** 
*** 10. Prepare a sample for analysis by filtering observations and variables and creating transformations of variables ***
** In the following section of the do-file you can find multiple tasts on the above listed assignments **

* First let's label the variables *
rename v1 index
lab var index "Index"
lab var item_id "item id wich can be used later to merge with other IKEA dataframes"
lab var name "the commercial name of items"
lab var category "the furniture category that the item belongs to (Sofas, beds, chairs, Trolleys,...)"
lab var price "the current price in SAR as it is shown in the website by 4/16/2020"
lab var old_price "the price of item in SAR before discount"
lab var sellable_online "if the item is available for online purchasing or in-stores only"
lab var link "the web link of the item"
lab var other_colors "if other colors are available for the item, or just one color as displayed in the website"
lab var short_description "a brief description of the item"
lab var designer "The name of the designer who designed the item. this is extracted from the full_description column"
lab var depth "Depth of the item in Centimeter"
lab var height "Height of the item in Centimeter"
lab var width "Width of the item in Centimeter"

* The label description is also found on https://www.kaggle.com/ahmedkallam/ikea-sa-furniture-web-scraping, where I directly downloaded the raw csv file from + 

describe


**In my dataset, I have only integers, strings and floats, however the strings often look really weird. I need to adjust some of the string variables**

tab old_price, missing
tab depth, missing
tab height, missin
tab width, missing

*** 15. iInstall a Stata package ***
** The package "Strkeep" is useful to clean messy string variables **

ssc install strkeep

* I transform my old_price string variables with spaces and words into numeric values only *

strkeep old_price, gen(newoldprice) numeric
destring newoldprice, generate (oldprice)
rename oldprice old_price_num
lab var old_price_num "Numerical values of old prices of item in SAR before discount"
* I now have the old price variable instead of a string transfomred into a simple float variable*



* Transforming "other_colors" and "sellable_online" variables into dummies using a for loop*
foreach varlist in sellable_online other_colors category {
	encode `varlist', generate (_`varlist')
}
 

* The "short description" variable contains both a short text and the size of the item. However the size of the item is already defined in three other variables, namely "depth", "width" and "height". *
* Hence, I split the short_description variable so I am only left with the short text *

split short_description, p(",")
drop short_description2 short_description3 short_description4
rename short_description1 short_description_text
lab var short_description_text "Short description text only"


*** 11. Save data in Stata *** 
** I have cleaned all the data now, transforming all variables into useful format **
** Let's save the clean data file **

** CSV FILE, in case it should be used for another software program **
save "data/IKEA_SA_Furniture_Web_Scrapings_CLEAN.csv", replace 
** DTA FILE **
save "data/IKEA_SA_Furniture_Web_Scrapings_CLEAN.dta", replace 

