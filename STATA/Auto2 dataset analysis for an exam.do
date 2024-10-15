//Analysis using Sample auto2 dataset

log using "C:\Users\user\Documents\ECO801\ecoexam.smcl"
sysuse auto2.dta
//a part i)
//generating kpl variable
gen kpl = mpg/2.352145
label variable kpl "Kilometres Per Litre"
//a part ii)
//generating log of price
gen lprice = ln( price)
label variable lprice "Natural Log of price"
//a part iii)
//generate Condition
gen condition = rep78
label variable condition "Car Condition"
//combine ppor and fair records
recode condition 1=1 2=1 3=2 4=3 5=4
browse
//label condition 
label define Condition 1 "Poor/Fair" 2 "Average" 3 "Good" 4 "Excellent"
label values condition Condition
//part b
//hypothesis test of fuel effiiency between foreign and domestic cars
ttest kpl, by(foreign)
//hypothesis test of dependence of efficiency on condition
oneway kpl condition, tabulate
browse

//Question 3
//part i
regress foreign lprice kpl weight condition, vce(robust)
logit foreign lprice kpl weight condition, vce(robust)
//part ii
regress foreign lprice kpl weight condition, vce(robust)
estimates store LPM
logit foreign lprice kpl weight condition, vce(robust)
mfx
estimates store mfx
regress foreign lprice kpl weight condition, vce(robust)
mfx
estimates store mfx_lpm
esttab _est_mfx _est_mfx_lpm, label margin ar2 title (COMPARISON OF MARGINAL EFFECTS) nonumbers mtitles("Coefficients" "Marginal Effects") addnote("Source: auto2.dta")
clear

//Question 2
use "C:\Users\user\Documents\ECO801\fuel prices.dta"
br
///part a
//generating variables
gen lfuel = ln(Fuel)
label variable lfuel "Log of real expenditure of fuel"
gen lprice = ln(Price)
label variable lprice "Log of real fuel prices"
gen sqprice = lprice ^2
label variable sqprice "Price Squared"
gen lincome = ln(Income)
label variable lincome "log of  per  capita disposable income"
gen lpriceinc = lprice*lincome
label variable lpriceinc "Product of price and income"
regress lfuel lprice sqprice lincome lpriceinc
predict residuals, residuals
swilk residuals
vif
hettest
estat vce, correlation
//part c
gen month = tm(2020m1)+_n-1
format %tm month
tsset month
gen elasticity =lprice/lfuel
tsline elasticity
//part d
mfx
