***QUESTION 1***
clear
set more off
log using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/hw6.smcl", replace 
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/pension.dta"
reg pctstck choice age educ female black married finc25 finc35 finc50 finc75 finc100 finc101 wealth89 prftshr, robust
est store m1
ologit pctstck choice age educ female black married finc25 finc35 finc50 finc75 finc100 finc101 wealth89 prftshr, or
mfx, predict(outcome(0))
est store m2
mfx, predict(outcome(50))
est store m3
mfx, predict(outcome(100))
est store m4

esttab m1 m2 m3 m4  using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/q1.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(OLS vs. ordered logit \label{tab1})


***QUESTION 2***
clear 
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/keane.dta"
reg status educ exper expersq black
est store m1
mlogit status educ exper expersq black, rrr baseoutcome(1) 
**predict probabilities**
mfx, predict(outcome(1)) 
est store m2
mfx, predict(outcome(2))
est store m3
mfx, predict(outcome(3))
est store m4
estout m1 m2 m3 m4, cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend 
predict pmlogit1 pmlogit2 pmlogit3, pr
summarize pmlogit* 
*compare with actual frequencies*
tab status
esttab m1 m2 m3 m4  using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/q2.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(OLS vs. multinomial logit \label{tab2})
sum exper
display -.131+2*.009*1.651969 
display 0.305+2*(-0.027)*1.651969 
display -0.174+2*(0.018)*1.651969 



***QUESTION 3***
clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/mroz.dta"
reg hours nwifeinc educ exper expersq age kidslt6 kidsge6, robust
est store m1
tobit hours nwifeinc educ exper expersq age kidslt6 kidsge6, ll(0)
mfx compute, predict (p(0,.))
est store m2
eststo clear
esttab m1 m2  using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/q3.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(Comparison of models \label{tab3}) 


***QUESTION 4***

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/recid.dta"
sum ldurat
cnreg ldurat workprg priors tserved felon alcohol drugs black married educ age, censored(cens)
mfx compute
est store m1
esttab m1 using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/q4.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(CNREG \label{tab4})

**Question 5**
clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/mroz.dta"
reg lwage educ exper expersq
est store m1
heckman lwage educ exper expersq, select (inlf=nwifeinc educ exper expersq age kidslt6 kidsge6) twostep
est store m2

esttab m1 m2  using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/q5.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(OLS and two-stage Heckman \label{tab5})


**Question 6**
clear
use"/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/crime1.dta"
reg narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan born60, robust
mfx compute
est store m1
poisson narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan born60, vce(robust)
estat gof
mfx compute
est store m2
nbreg narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan born60
mfx compute 
est store m3

esttab m1 m2 m3  using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #6/q6.tex", cells(b(star fmt(3)) p(par fmt(3))) margin stats(N) legend label replace booktabs ///
  alignment(D{.}{.}{-1}) width(1.1\hsize)        ///
  title(OLS, Poisson, negative binomial \label{tab6})
  
  log close

