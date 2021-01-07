*** 12. Run OLS Regression in Stata ***
*** 13. Create a graph of any type in Stata ***
*** 14. Save regression tables and graphs as files. ***


** Load the correct datasubset **
use "data/IKEA_SA_Furniture_Web_Scrapings_subset_correct.dta"

rename _sellable_online dummy_selling_online
rename _other_colors dummy_other_colors
rename _category category_num
drop newoldprice


** I am graphing a pie chart for the furniture categories, using variable "category_num". The pie chart will tell me the proportion of each furniture cateogry such as beds, tables etc. in the dataset*

ls
graph pie, over (category_num)
graph export "graph&reg/Piechart.png", replace


**I run three different specifications, price is always independent variable. All regressions adjust for robust standard errors**
ssc install outreg2

* In the first regression I use only furniture categories as a dependent variable, where the i.function indicates that the regression output will show the coefficient result for all the categories in the x-variable *
reg price i.category_num, r
outreg2 using "graph&reg/Regression_Output.xls", replace nolabel bracket bdec(3) 

* In the second regression I addtionally include depth, height and width *
reg price i.category_num depth height width, r
outreg2 using "graph&reg/Regression_Output.xls", append nolabel bracket bdec(3) 

* In the third regression I addtionally a dummy for the furniture being sold online and a dummy for the furniture being sold in another color *
reg price i.category_num depth height width dummy_other_colors dummy_selling_online, r
outreg2 using "graph&reg/Regression_Output.xls", append nolabel bracket bdec(3) 

* We can see that Regression specification 2 & 3 have less observations (1899 instead of 3694) as the variables added in specification 2, namely "depth", "width" and "height" have numerous missing values.* 
