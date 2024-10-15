
//Practice Session

import excel "C:\Users\user\Documents\ECO801\bank.xlsx", sheet("Sheet1") firstrow case(lower)
browse
// generate new variable from marraige
encode mar_status, gen (marriage)
browse
label variable marriage "Marital Status"
browse
//combining two staff categories together

encode dept , gen (occupation)
browse
gen department = occupation
browse

recode department 1=1 2=2 4=2 3=3
browse

// rlabelling new categories
label define Department 1 "Bank TEller" 2 "Support staff" 3 "Manager"
label values department Department
browse
//testing for difference
ttest salary, by(marriage)


anova salary marriage department
clear

//New Analysis

import excel "C:\Users\user\Documents\ECO801\CTY_B.xls", sheet("Sheet1") firstrow case(lower)
save "C:\Users\user\Documents\ECO801\ctyb.dta"
clear
import excel "C:\Users\user\Documents\ECO801\CTY_B_MOB.xls", sheet("Sheet1") firstrow case(lower)

append using "C:\Users\user\Documents\ECO801\ctyb.dta"
browse
//setting data to quarterly time series
gen Quaterly = tq(2010q1)+_n-1

format %tq Quaterly
tsset Quaterly
//adding notes
note: NB include a time stamp
notes
clear

//New Analysis

import excel "C:\Users\user\Documents\ECO801\bank.xlsx", sheet("Sheet1") firstrow case(lower)
//generating new variable
gen experience = (age*tenure)^0.5
label variable experience "Experience"
browse
//dropping a variable
drop h

encode mar_status, gen (marriage)
encode dept, gen (department)
oneway salary department
oneway salary department, tabulate
describe
codebook
//generate new variabl
gen lsal = ln( salary)
//regression
regress lsal tenure grade age department
predict residuals

//normality test
kdensity residuals
kdensity residuals, normal
swilk residuals

//multicollinearity tes
estat vif

//heteroskedasticity test
estat hettest
clear

//New Analysis
sysuse auto2.dta
browse
//Visualizations
graph dot (mean) foreign
graph pie, over(foreign)
graph pie, over(foreign) plabel(_all name)
graph pie, over(foreign) pie(_all, explode) plabel(_all name)
ttest price, by(foreign)
clear

//New Analysis

import excel "C:\Users\user\Documents\ECO801\CTY_A.xls", sheet(

sum
browse
//set data to quaterly time series
gen quarter = tq(2010q1) +_n-1
format %tq quarter
tsset quarter
tsline dcp_gdp npl mobsub gdppc cpi hdi
tsline

tsline mobsub

//stationarity testing
dfuller inf, drift lags(0)
dfuller mobsub, trend lags(0)
dfuller inf, drift lags(1)
dfuller gdppc, lags(0)
dfuller gdppc, lags(1)
dfuller gdppc, trend lags(1)
dfuller gdppc, lags(2)
dfuller d.gdppc, lags(1)
dfuller d.gdppc, lags(0)
dfuller d.mobsub, trend lags(0)
dfuller d.mobsub, drift lags(0)
dfuller npl,  lags(0)
dfuller d.npl,  lags(0)
dfuller d.npl, trend  lags(0)
dfuller d.npl, drift  lags(0)

//ARDL 
ardl npl inf gdppc dcp_gdp mobsub hdi
predict residuals

//Testing for normality
swilk residuals
clear

//New Analyis
sysuse auto2.dta
browse


gen KPL = (1.61/3.79)*mpg

//Regression with robust standard errors
regress foreign price KPL headroom ,vce(robust)

//Logistic regression
logit foreign price KPL headroom ,vce(robust)
regress foreign price KPL headroom ,vce(robust)
estimates store LPM
logit foreign price KPL headroom ,vce(robust)
estimates store Logit
esttab _est_LPM _est_Logit using ERESULTS1.rtf, label margin ar2  title(COMPARISON OF LPM ABD LOGIT MODEL RESULTS) nonumbers mtitles("LPM" "LOGIT") addnote("Source: auto2.dta")
