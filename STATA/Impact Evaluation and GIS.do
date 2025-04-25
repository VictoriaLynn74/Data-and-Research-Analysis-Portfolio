// Analysis to evaluate the impact of an education intervention in Indonesia.
//	Renaming and Labelling Variables
use "C:\Users\user\Downloads\Stata Test\Data Files\students.dta"
br

rename var1 district_id
label variable district_id "District identifier"
rename var2 student_id
label variable student_id "Student identifier"
rename var3 income_quintile
label variable income_quintile "Income quintile"
label define Income_quintile 1 "Q1(Highest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5(Highest)"
label values income_quintile Income_quintile
rename var4 gender
label variable gender "Student's gender"
label define students_gender 1 "Male" 5 "Female"
label values gender students_gender
rename var5 dob_day
label variable dob_day "Student's date of birth - day"
rename var6 dob_month
label variable dob_month "Student's date of birth - month"
rename var7 dob_year
label variable dob_year "Student's date of birth - year"
label variable var8 "Mother's education level"
rename var8 mother_educ
label define education_level 1 "No schooling" 2 "Primary" 3 "Secondary" 4 "Tertiary and above"
label values mother_educ education_level
label variable var9 "Father's education level"
label values var9 education_level
rename var9 father_educ
label variable var10 "Literacy score, baseline"
rename var10 baseline_literary_score
rename baseline_literary_score lit_score_base
label variable var11 "Literacy score, Endline"
rename var11 lit_score_end
label variable var12 "Numeracy score"
rename var12 num_score
save "C:\Users\user\Downloads\Stata Test\Data Files\students.dta", replace
clear
// Opening Schools Dataset
use "C:\Users\user\Downloads\Stata Test\Data Files\schools.dta"
br
//Reaming and labelling variable
label variable var1 "District identifier"
rename var1 district_id
label variable var2 "School identifier"
rename var2 school_id
label variable var3 "Treatment assignment"
rename var3 treatment
label define treatment_assignment 0 "Control Group" 1 "Treatment 1" 2 "Treatment 2"
label values treatment treatment_assignment
label variable var4 "Number of teachers in the school"
rename var4 num_teachers
label variable var5 "Number of classrooms in the school"
rename var5 num_classroom
label variable var6 "Urban/rural status"
rename var6 status
label define urban_rural_status 1 "Urban" 7 "Rural"
label values status urban_rural_status
save "C:\Users\user\Downloads\Stata Test\Data Files\schools.dta", replace

//Cleaning Datasets

// Convert negative values to positive for num_teachers
replace num_teachers = abs(num_teachers) if num_teachers < 0
// Convert negative values to positive for num_classrooms
replace num_classroom = abs(num_classroom) if num_classroom < 0
// Replace extreme values over 100 with missing
replace num_classroom = . if num_classroom > 100

save "C:\Users\user\Downloads\Stata Test\Data Files\schools.dta", replace
use "C:\Users\user\Downloads\Stata Test\Data Files\students.dta"
//Remove negatives from dates
foreach var in dob_day dob_month {
    replace `var' = abs(`var') if `var' < 0
}

//Combining the datasets
joinby district_id using "C:\Users\user\Desktop\rct\Test files\Stata data test\Data Files\students.dta", unmatched(none)
save "C:\Users\user\Desktop\rct\Test files\student_schools.dta"

//Importing and Merging CSV file
import delimited "C:\Users\user\Downloads\Stata Test\Data Files\take-up.csv", clear 
br
replace school= trim(school)
rename school school_id
replace school_id = regexr(school_id, "^0+", "")
replace school_id = regexr(school_id, "-", "")
replace school_id = subinstr(school_id, " ", "", .)
save "C:\Users\user\Desktop\rct\Test files\takeup.dta"

//Merging the datasets
use "C:\Users\user\Desktop\rct\Test files\student_schools.dta"
br
duplicates drop student_id, force
joinby school_id using "C:\Users\user\Desktop\rct\Test files\takeup.dta", unmatched(none)
br
duplicates drop student_id, force
save "C:\Users\user\Desktop\rct\Test files\students_schools_takeup.dta"

//Summary Statistics
summarize, detail

//Mapping student-teacher ratio by dustrict
//Generating number of students per district
egen num_students_per_district = count(student_id), by(district_id)
br
//Generating number of teachers per district
egen total_teachers_per_district = total(num_teachers), by(district_id)
//Calculating  the average student-teacher ratio for each district 
gen student_teacher_ratio = num_students_per_district / total_teachers_per_district
save "C:\Users\user\Desktop\rct\Test files\students_schools_takeup.dta", replace
// Installing spmap
ssc install spmap
shp2dta using "C:\Users\user\Desktop\rct\Test files\sumatra.shp", database("sumatra1.dta") coordinates("sumatra_coords1.dta") genid(id)
use "C:\Users\user\Desktop\rct\Test files\sumatra1.dta"
rename KAB district_id
br
//Merging Map data with Master dataset
collapse (mean) student_teacher_ratio, by(district_id)
merge 1:1 district_id using "C:\Users\user\Desktop\rct\Test files\sumatradata.dta"
//Generating map
spmap student_teacher_ratio using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta",id(id) fcolor(Blues) ocolor(white) clmethod(quantile)  

//Generating the average literacy score before the treatment and the average literacy score after treatment 
//Variables are aggregated by district since data will be plotted across districts
use "C:\Users\user\Desktop\rct\Test files\students_schools_takeup.dta"
egen avg_lit_base_control = mean(lit_score_base) if treatment == 0, by(district_id)
egen avg_lit_base_t1 = mean(lit_score_base) if treatment == 1, by(district_id)
egen avg_lit_base_t2 = mean(lit_score_base) if treatment == 2, by(district_id)
egen avg_lit_end_control = mean(lit_score_end) if treatment == 0, by(district_id)
egen avg_lit_end_t1 = mean(lit_score_end) if treatment == 1, by(district_id)
egen avg_lit_end_t2 = mean(lit_score_end) if treatment == 2, by(district_id)
//Generating change in means
gen change_lit_t1 = avg_lit_end_t1 - avg_lit_base_t1
gen change_lit_t2 = avg_lit_end_t2 - avg_lit_base_t2
collapse (mean) change_lit_t1, by(district_id)
collapse (mean) change_lit_t2, by(district_id)
merge 1:1 district_id using "C:\Users\user\Desktop\rct\Test files\sumatradata.dta"

//Plotting baseline literacy scores for Treatment 1 - used "https://www.youtube.com/watch?v=F3OlqXTndU4" for help on this
spmap avg_lit_base_t1 using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta", id(id) fcolor(Blues) ocolor(white) clmethod(quantile) title("Baseline Literacy - T1")
graph save Graph "C:\Users\user\Downloads\Stata Test\Data Files\baseline_t1.gph"
//Plotting Endline  Average Lieracy Scrores for Treatment 1
spmap avg_lit_end_t1 using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta", id(id) fcolor(Blues) ocolor(white) clmethod(quantile) title("Endline Literacy - T1")
graph save Graph "C:\Users\user\Downloads\Stata Test\Data Files\endline_t1.gph"
//Plotting baseline average literacy scores for Treatment 2
spmap avg_lit_base_t2 using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta", id(id) fcolor(Reds) ocolor(white) clmethod(quantile) title("Baseline Literacy - T2")
graph save Graph "C:\Users\user\Downloads\Stata Test\Data Files\baseline graph t2.gph"
//Plotting endline average literacy scores for Treatment 2
spmap avg_lit_end_t2 using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta", id(id) fcolor(Reds) ocolor(white) clmethod(quantile) title("Endline Literacy - T2")
graph save Graph "C:\Users\user\Downloads\Stata Test\Data Files\endline graph t2.gph"
//Plotting Changes in mean for the different treatment groups
//Treatment 1
spmap change_lit_t1 using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta" , id(id) fcolor(Blues) ocolor(white) clmethod(quantile) title("Change in Literacy Scores - T1")
graph save Graph "C:\Users\user\Downloads\Stata Test\Data Files\change T1.gph"
//Treatment 2
spmap change_lit_t2 using "C:\Users\user\Desktop\rct\Test files\sumatra_coords1.dta" , id(id) fcolor(Reds) ocolor(white) clmethod(quantile) title("Change in Literacy Scores - T2")
graph save Graph "C:\Users\user\Downloads\Stata Test\Data Files\changes t2.gph"

//Estimating Treatment Effects of the program on literacy score
//Regression estimates is used to estimate endline literacy scores while controlling for baseline literacy score.  
// The i.treatment sets treatment as a categorical variable. The treatment coefficients show the effects of each treatment group.
// Robust standard errors are used to correct for potential heteroskedasticity.  
reg lit_score_end i.treatment lit_score_base, robust 

//Clustering should be done at school level, because randomization is at school level, since students in a school receive similar treatment and thus their outcomes may be correlated.
reg lit_score_end i.treatment lit_score_base, cluster(school_id)










