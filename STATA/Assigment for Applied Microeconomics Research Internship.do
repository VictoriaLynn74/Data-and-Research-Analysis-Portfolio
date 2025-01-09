
//Konnifel Assigment for Applied Microeconomics Research Internship
//Submitted by Victoria Kiboi

//Question 1
//Opening Dataset 1
use "C:\Users\Admin\Downloads\stata_exercise_data\Identification of Sample Household.dta"
browse
count  // No of observations is  50,297
sum
clear
// Viewing Dataset 2
use "C:\Users\Admin\Downloads\stata_exercise_data\Demographic and other particulars of household members.dta"
browse
clear

//Merging Datasets 1 and 2
use "C:\Users\Admin\Downloads\stata_exercise_data\Identification of Sample Household.dta"
merge 1:m HH_ID using "C:\Users\Admin\Downloads\stata_exercise_data\Demographic and other particulars of household members.dta"
keep if _merge == 3
drop _merge
count  // No of observations in the merged dataset in 242,369. This is different from Dataset 1
// HH_ID represents a household in Dataset 1 and is unique for each observation.
// In Dataset 2, HH_ID is not unique because it is repeated for each member of a household.
// This creates a one-to-many (1:m) relationship between Dataset 1 and Dataset 2.
// As a result, the number of observations in the merged dataset increases because
// each household in Dataset 1 is matched with all corresponding members in Dataset 2.
save "C:\Users\Admin\Downloads\stata_exercise_data\merged_12.dta"
clear

//Question 2
//Viewing Dataset 3
use "C:\Users\Admin\Downloads\stata_exercise_data\Household Characteristics.dta"
browse
clear
//Merging Datasets
use "C:\Users\Admin\Downloads\stata_exercise_data\merged_12.dta"
count
merge m:1 HH_ID using "C:\Users\Admin\Downloads\stata_exercise_data\Household Characteristics.dta"
keep if _merge ==3
count //No of observations in this new merged dataset is 242,369. It is the same as Question 1
// The merged dataset (Dataset 1 + Dataset 2) has multiple observations per HH_ID due to the demographic data for household members.
// The merge creates a many-to-one (m:1) relationship between the datasets.
// The number of observations in the merged dataset remains the same as in Question 1 because Dataset 3 only adds household-level variables.
save "C:\Users\Admin\Downloads\stata_exercise_data\merged_123.dta"
clear

// Question 3
//Viewing Dataset 4
use "C:\Users\Admin\Downloads\stata_exercise_data\Expenditure on education_medical during the last 365 days.dta"
browse
clear
//Opening Merged Dataset
use "C:\Users\Admin\Downloads\stata_exercise_data\merged_123.dta"
drop _merge
//merging Dataset 4
merge m:m HH_ID using "C:\Users\Admin\Downloads\stata_exercise_data\Expenditure on education_medical during the last 365 days.dta"
//// Dataset 4 contains multiple rows per HH_ID due to different expenditure items. The merged data from Question 2 also contains multiple rows per HH_ID due to household members.
//m:m merging has thus been used in this scenario

//Renaming Variables
rename Value expenditure
rename Item_Code item_code
//Destring all variables
destring, replace
//Retaining only provided observations
keep if inlist(item_code, 409, 410, 411, 412, 413, 414, 415, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 439, 449, 459, 479, 499)
save "C:\Users\Admin\Downloads\stata_exercise_data\merge_1234.dta"
//Dropping duplicates to allow for reshaping of dataset
duplicates drop HH_ID, force
//reshaping data from long to wide
 reshape wide expenditure, i(HH_ID) j(item_code)
browse
count // number of observations is 50,278
//Saving new dataset as nss_consumption_64
save "C:\Users\Admin\Downloads\stata_exercise_data\nss_consumption_64.dta"
clear

//Question 4
//viewing Dataset 5
use "C:\Users\Admin\Downloads\stata_exercise_data\nss_consumption_66.dta"
browse
clear
//Appending Dataset 5

use "C:\Users\Admin\Downloads\stata_exercise_data\nss_consumption_64.dta"
append using "C:\Users\Admin\Downloads\stata_exercise_data\nss_consumption_66.dta"
save "C:\Users\Admin\Downloads\stata_exercise_data\nss_consumption_6466.dta"

//End
