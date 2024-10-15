* Test fo Conintegration, ENGLE GRANGER 2 STEP
*estimate erroe correction model
*generate differences of lcons and linc
*restimate cointegration regression and save residuals
*test whether ehat is stationary
dfuller ehat, regress noconstant
estat ic
estat ic
gen dlinc = d.linc
log close
log using "C:\Users\user\Documents\practical 3.smcl"
predict ehat, residual
regress dlcons dlinc l.ehat
regress dlcons l.dlcons l2.dlcons dlinc l.dlinc l2.dlinc l.ehat
regress dlcons l.dlcons l2.dlcons l3.dlcons dlinc l.dlinc l2.dlinc l3.dlinc l.ehat
regress lcons linc
save "C:\Users\user\Documents\EES 800\EES801\practical 2.dta", replace
use "C:\Users\user\Documents\EES 800\EES801\practical 2.dta"
