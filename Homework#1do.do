clear
use "/Users/mdk31/Downloads/WAGE2.dta"
reg wage educ exper tenure
eststo clear
eststo: quietly regress wage educ exper tenure 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q4i.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Standard wage equation regression \label{tab1})
  eststo clear
eststo: quietly regress wage educ exper tenure black 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q4ii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Race wage equation regression \label{tab1})
 gen blacked = black*educ
  eststo clear
eststo: quietly regress wage educ exper tenure black blacked
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q4iii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Interaction regression \label{tab3})
  
test exper = tenure
generate blackmarriedint = black*married
gen blackmarried = 1 
replace blackmarried = 0 if married==0 | black==0
gen blacknotmarried = 1 
replace blacknotmarried = 0 if married==1 | black==0
gen notblackmarried = 1 
replace notblackmarried = 0 if married==0 | black==1
gen notblacknotmarried = 1 
replace notblacknotmarried = 0 if married==1 | black==1

reg wage educ exper tenure black married blackmarriedint
* Exclude one as the base group (exclude NOT BLACK NOT MARRIED!)
*a. Difference between Fenale-Married and Male-Married *
* Now ask Stata to compute the differences
display _b[black]+_b[blackmarriedint]
test black = -blackmarriedint
*b. Difference between Female-Married and Female-non-Married*
display _b[married]+_b[blackmarriedint]
test married = -blackmarriedint
*c. Difference between Female-Married and Male-non-married*
display _b[black] + _b[married] + _b[blackmarriedint]
*d. Difference between Female-non-Married and Male-non-married*
display _b[married]-_b[black]
*e. Difference between Female-non-Married and Male-married*
display _b[married]
*f. Difference between Male-Married and Male-non-married*
display _b[black]

reg wage educ exper tenure blackmarried blacknotmarried notblackmarried
* Exclude one as the base group (exclude NOT BLACK NOT MARRIED!)
*a. Difference between Fenale-Married and Male-Married *
* Now ask Stata to compute the differences
display _b[blackmarried]-_b[notblackmarried]
test blackmarried = notblackmarried
*b. Difference between Female-Married and Female-non-Married*
display _b[blackmarried]-_b[blacknotmarried]
test blackmarried = blacknotmarried
*c. Difference between Female-Married and Male-non-married*
display _b[blackmarried]
*d. Difference between Female-non-Married and Male-non-married*
display _b[notblackmarried]-_b[blacknotmarried]
*e. Difference between Female-non-Married and Male-married*
display _b[notblackmarried]
*f. Difference between Male-Married and Male-non-married*
display _b[blacknotmarried]

***Testing hypotheses***
*Now we can do the same thing with this model





clear
use "/Users/mdk31/Downloads/bwght2.dta"
eststo clear
eststo: quietly reg bwght meduc feduc mage fage npvis cigs drink 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q5i.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Model for birth weight of babies \label{tab4})
test cigs = drink
gen drinkdaily = drink/7

eststo clear
eststo: quietly reg bwght meduc feduc mage fage npvis cigs drinkdaily 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q5ii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Model for birth weight of babies (drink daily) \label{tab5})
test cigs = drinkdaily

test meduc feduc

reg bwght meduc feduc mage fage npvis cigs drink estimates store m1reg bwght mage fage npvis cigs drink  if meduc != . & feduc != .estimates store m2**note: the restricted model is the first one in the test command**lrtest m2 m1

testnl _b[mage]*_b[fage]=1

eststo clear
eststo: quietly reg bwght meduc feduc mage fage npvis cigs drink male 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q5v.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Model for birth weight of babies (male) \label{tab6})

gen cigsmblck = cigs*mblck

eststo clear
eststo: quietly reg bwght meduc feduc mage fage npvis cigs drink cigsmblck
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/q5vi.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Model for birth weight of babies (race) \label{tab6})
  
log using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/trial.smcl", replace  
clear
use "/Users/mdk31/Downloads/WAGE2.dta"
reg wage educ exper tenure
 quietly regress wage educ exper tenure 
quietly regress wage educ exper tenure black 

 gen blacked = black*educ
 quietly regress wage educ exper tenure black blacked

  
test exper = tenure
generate blackmarriedint = black*married
gen blackmarried = 1 
replace blackmarried = 0 if married==0 | black==0
gen blacknotmarried = 1 
replace blacknotmarried = 0 if married==1 | black==0
gen notblackmarried = 1 
replace notblackmarried = 0 if married==0 | black==1
gen notblacknotmarried = 1 
replace notblacknotmarried = 0 if married==1 | black==1

reg wage educ exper tenure black married blackmarriedint
* Exclude one as the base group (exclude NOT BLACK NOT MARRIED!)

display _b[black]+_b[blackmarriedint]
test black = -blackmarriedint
display _b[married]+_b[blackmarriedint]
test married = -blackmarriedint
display _b[black] + _b[married] + _b[blackmarriedint]
display _b[married]-_b[black]
display _b[married]
display _b[black]

reg wage educ exper tenure blackmarried blacknotmarried notblackmarried
* Exclude one as the base group (exclude NOT BLACK NOT MARRIED!)

display _b[blackmarried]-_b[notblackmarried]
test blackmarried = notblackmarried
display _b[blackmarried]-_b[blacknotmarried]
test blackmarried = blacknotmarried
display _b[blackmarried]
display _b[notblackmarried]-_b[blacknotmarried]
display _b[notblackmarried]
display _b[blacknotmarried]


clear
use "/Users/mdk31/Downloads/bwght2.dta"
quietly reg bwght meduc feduc mage fage npvis cigs drink 
test cigs = drink
gen drinkdaily = drink/7

 quietly reg bwght meduc feduc mage fage npvis cigs drinkdaily 

test cigs = drinkdaily

test meduc feduc

reg bwght meduc feduc mage fage npvis cigs drink estimates store m1reg bwght mage fage npvis cigs drink  if meduc != . & feduc != .estimates store m2**note: the restricted model is the first one in the test command**lrtest m2 m1

testnl _b[mage]*_b[fage]=1

quietly reg bwght meduc feduc mage fage npvis cigs drink male 


gen cigsmblck = cigs*mblck

quietly reg bwght meduc feduc mage fage npvis cigs drink cigsmblck

log close

translate trial.smcl trial.pdf
