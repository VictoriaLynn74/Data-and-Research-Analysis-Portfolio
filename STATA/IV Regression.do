*create a log file to save output
log using "C:\Users\user\Documents\EES 800\EES801\Exercise 1 ees 801.smcl"
*create a log file to save output
*Inspect dataset using summary statistics
sum
*read dataset first
import excel "C:\Users\user\Documents\EES 800\EES801\A2Q3 dataset.xls", sheet("A3") firstrow case(lower)
sum
*Estimate reduced form equations
*first generate lag of CEt
*use gen command
gen ce_1=ce[_n-1]
*use 'regress' command to estimate RFE
*format regress [depvar][indepen var]
*for Yt RF equation:
regress y ce_1 r g
*save predicted  value for 2sls
predict y_hat,xb
sum y_hat
regress ce ce_1 r g
predict ce_hat,xb
sum ce_hat
regress inv ce_1 r g
predict inv_hat,xb
sum inv_hat
*olsestimates for structural eqtns
regress ce y ce_1
*for INt
regress inv y r
*ols estimaes on structured equations show ce_1 and y to be insignificant which is not true, ie use 2sls
*2sls estimates
regress ce y_hat ce_1
regress inv y_hat r
*Use IV regressfor 2SLS estimates
ivregress 2sls ce ce_1 ( y= r g )
*for equation 2
ivregress 2sls inv r (y = ce_1 g)
*close log file
log close
regress inv y r
*create a log file to save output
