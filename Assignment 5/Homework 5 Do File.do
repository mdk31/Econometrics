clear 
set more off
log using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/hw5.smcl", replace  
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/loanapp.dta"
**1 USE LOANAPP**
*i*
regress approve white
eststo clear
eststo: quietly regress approve white
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q1i.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(OLS regressression of approve on white \label{tab1}) 
*ii*
regress approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
est store m1
eststo clear
eststo: quietly regress approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q1ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(OLS regressression on multiple variables \label{tab2}) 
*iii*
gen raceobrat = white*obrat
regress approve white hrat raceobrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
display _b[white]+_b[raceobrat]*32
eststo clear
eststo: quietly regress approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q1iii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(OLS regressression with interaction \label{tab3}) 
*iv*
regress approve white hrat raceobrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
display _b[white]+_b[raceobrat]*64
*v*
display _b[obrat]*64
*vi*
logit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
mfx
est store m2
probit approve white hrat obrat loanprc unem male married dep sch cosign chist pubrec mortlat1 mortlat2 vr
mfx
est store m3
estout m1 m2 m3, cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend 
eststo clear
esttab m1 m2 m3 using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q1vi.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(Comparison of models \label{tab4}) 

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/401ksubs.dta"
**2 USE 401KSUBS**
*i*
regress e401k inc age male
eststo clear
eststo: quietly regress e401k inc age male
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q2i.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(OLS regressression  \label{tab5}) 
*ii*
regress e401k inc age male incsq agesq
est store m1
eststo clear
eststo: quietly regress e401k inc age male incsq agesq
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q2ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(OLS regressression with squared term \label{tab6}) 
display _b[age]+2*_b[agesq]*41.08
display _b[inc]+2*_b[agesq]*39.25
sum age inc
*iii*
*NO CODING!!*
*iv*
logit e401k inc age male incsq agesq
mfx
est store m2
probit e401k inc age male incsq agesq
mfx
est store m3
estout m1 m2 m3, cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend 
eststo clear
esttab m1 m2 m3 using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q2iv.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(LPM, logit, and probit \label{tab7}) 
clear 
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/apple.dta"
*i*
gen ecobuy = 1 if ecolbs > 0 
replace ecobuy = 0 if ecolbs ==0
tab ecobuy

*ii*
regress ecobuy ecoprc regprc faminc hhsize educ age
est store m1
*iii*
test faminc hhsize educ age
*iv*
logit ecobuy ecoprc regprc faminc hhsize educ age
mfx
est store m2
probit ecobuy ecoprc regprc faminc hhsize educ age
mfx
est store m3
estout m1 m2 m3, cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend
eststo clear
esttab m1 m2 m3 using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #5/q3iv.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(LPM, logit, and probit \label{tab8}) 

log close
