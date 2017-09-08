clear
use "C:\HAIMANTI\utah\ECON7800\statafiles\WAGE1.DTA", clear

**RESET TEST**
*run the regression*
*TESTS FOR FUNCTION FORM SPECIFICATION (DID YOU EXCLUDE SOME HIGHER ORDER TERMS)
*1. Run the regression
*2. Get the y-hat then get the yhat^2 and yhat^3
*3. Run the regression of y on x, y hat^2, and yhat^3
* test H_0 \gamma_1 = \gamma_2 = 0
reg  wage educ exper tenure
*predict yhat*
predict wagehat
*generate yhat-square and yhat-cube*
gen wagehatsq = wagehat * wagehat
gen wagehatcube = wagehatsq * wagehat
*run reset test regression that includes yhat-square and yhat-cube*
reg  wage educ exper tenure wagehatsq wagehatcube
*test for joint significance of yhat-square and yhat-cube*
*note: H0: they are jointly insiginificant. Hence if we reject the H0, then it indicates that there is a functional form mis-specification*
test wagehatsq wagehatcube
*or equivalent test command* Implicity asking if you are testing this:
*Rejecting the null means you have significant effects of these square and cubed terms
test wagehatsq = wagehatcube = 0
*RESULTS TELL US WE HAVE PROBLEM, CAUSE WE REJECT THE NULL
*With interaction of x_1 and x_2, x_1x_2
*Need marginal effects: of x_1 and x_2; partial derivatives w.r.t to x_1 and x_2

reg wage educ exper tenure educsq expertenure
*To interpret marginal effect of experience: \beta_exp + \beta_expertenure*tenure (sample mean)
sum tenure
*2.i create a dummy variable based on a condition
* create dummy from existing variable
gen hseduc = 0 
replace hseduc = 1 if educ > 12
tab hseduc 

*Non-nested test

*J-test*
*H0 model*
reg  wage educ exper tenure
predict y0hat
*H1 model*
reg  wage educ female married nonwhite
predict y1hat
*run H0 model with y1hat added to it*
reg  wage educ exper tenure y1hat
*run H1 model with y0hat added to it*
reg  wage educ female married nonwhite y0hat


*Encompassing test*
*H0 model:*
reg  wage educ exper tenure
*H1 model:*
reg  wage educ female married nonwhite
*Encompassing model*
reg  wage educ exper tenure female married nonwhite
*test for H0 model*
test educ exper tenure
*test for H1 model*
test educ female married nonwhite


*HOMEWORK START

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/HPRICE.dta"
reg price age agesq rooms area y81
sum age
local meanage = r(mean)
display _b[age] + 2*_b[agesq]*`meanage' 

gen roomsarea = rooms*area
reg price age agesq rooms area y81 roomsarea
sum rooms 
local meanrooms = r(mean)
sum age
local meanage = r(mean)
sum area
local meanarea = r(mean)
display _b[area] + _b[roomsarea]*`meanrooms'
display _b[rooms] + _b[roomsarea]*`meanarea'
display _b[age] + 2*_b[agesq]*`meanage'
test area roomsarea
test rooms roomsarea

reg lprice age agesq rooms area y81

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/CEOSAL1.dta"

gen rosneg = 0
replace rosneg = 1 if ros < 0

reg lsalary lsales roe rosneg

predict lsalaryhat
gen lsalaryhatsq = lsalaryhat*lsalaryhat
gen lsalaryhatcube = lsalaryhatsq*lsalaryhat

reg lsalary lsales roe rosneg lsalaryhatsq lsalaryhatcube
test lsalaryhatsq lsalaryhatcube

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/bwght2.dta"

reg lbwght mage meduc npvis cigs drink
reg lbwght mage meduc npvis cigs drink magesq 
reg lbwght mage meduc npvis cigs drink magesq npvissq

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/beauty.dta"

reg lwage educ exper expersq belavg abvavg service female married
predict y0hat
reg lwage educ exper south bigcity union
predict y1hat
reg lwage educ exper expersq belavg abvavg service female married y1hat
reg lwage educ exper south bigcity union y0hat

*Non-nested test

clear
log using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/hw2.smcl", replace  
clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/HPRICE.dta"
reg price age agesq rooms area y81
sum age
local meanage = r(mean)
display _b[age] + 2*_b[agesq]*`meanage' 

gen roomsarea = rooms*area
reg price age agesq rooms area y81 roomsarea
sum rooms 
local meanrooms = r(mean)
sum age
local meanage = r(mean)
sum area
local meanarea = r(mean)
display _b[area] + _b[roomsarea]*`meanrooms'
display _b[rooms] + _b[roomsarea]*`meanarea'
display _b[age] + 2*_b[agesq]*`meanage'
test area roomsarea
test rooms roomsarea

reg lprice age agesq rooms area y81

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/CEOSAL1.dta"

gen rosneg = 0
replace rosneg = 1 if ros < 0

reg lsalary lsales roe rosneg

predict lsalaryhat
gen lsalaryhatsq = lsalaryhat*lsalaryhat
gen lsalaryhatcube = lsalaryhatsq*lsalaryhat

reg lsalary lsales roe rosneg lsalaryhatsq lsalaryhatcube
test lsalaryhatsq lsalaryhatcube

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/bwght2.dta"

reg lbwght mage meduc npvis cigs drink
reg lbwght mage meduc npvis cigs drink magesq 
reg lbwght mage meduc npvis cigs drink magesq npvissq
sum mage 
local meanmage = r(mean)
display _b[mage] + 2*_b[magesq]*`meanmage'
sum npvis
local meannpvis = r(mean)
display _b[npvis] + 2*_b[npvissq]*`meannpvis'
*display _b[mage] + 2*_b[magesq]*`meanage'
clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/beauty.dta"

*reg lwage educ exper expersq belavg abvavg service female married
*predict y0hat
*reg lwage educ exper south bigcity union
*predict y1hat
*reg lwage educ exper expersq belavg abvavg service female married y1hat
*reg lwage educ exper south bigcity union y0hat

*Non-nested test

reg lwage educ exper expersq belavg abvavg service female married
reg lwage educ exper south bigcity union
reg lwage educ exper expersq belavg abvavg service female married south bigcity union
test educ exper expersq belavg abvavg service female married
test educ exper south bigcity union

sum exper
local meanexper = r(mean)
display _b[exper] + 2*_b[expersq]*`meanexper'

log close

translate "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/hw2.smcl" "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/hw2.pdf", replace

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/HPRICE.dta"
gen roomsarea = rooms*area
eststo clear
eststo: reg price age agesq rooms area y81 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q1i.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First price regression \label{tab1})

eststo clear
eststo: reg price age agesq rooms area y81 roomsarea
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q1ii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Price regression with rooms-area interaction \label{tab2})
  
eststo clear
eststo: reg lprice age agesq rooms area y81
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q1vi.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Log price regression \label{tab3})
  
  clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/CEOSAL1.dta"
gen rosneg = 0
replace rosneg = 1 if ros < 0

reg lsalary lsales roe rosneg

predict lsalaryhat
gen lsalaryhatsq = lsalaryhat*lsalaryhat
gen lsalaryhatcube = lsalaryhatsq*lsalaryhat



  eststo clear
eststo: reg lsalary lsales roe rosneg
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q2i.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(CEO salary regression \label{tab4})
  
    eststo clear
eststo: reg lsalary lsales roe rosneg lsalaryhatsq lsalaryhatcube
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q2ii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(RESET \label{tab12})
  
  clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/bwght2.dta"

  eststo clear
eststo: reg lbwght mage meduc npvis cigs drink
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q3i.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First birthweight regression \label{tab5})
  
   eststo clear
eststo: reg lbwght mage meduc npvis cigs drink magesq 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q3ii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Second birthweight regression \label{tab6})
   
      eststo clear
eststo: reg lbwght mage meduc npvis cigs drink magesq npvissq 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q3iii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Third birthweight regression \label{tab7})
  
  clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/beauty.dta"
  
        eststo clear
eststo: reg lwage educ exper expersq belavg abvavg service female married 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q4i.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First model regression \label{tab8})

        eststo clear
eststo: reg lwage educ exper south bigcity union 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q4ii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Second model regression \label{tab9})

        eststo clear
eststo: reg lwage educ exper expersq belavg abvavg service female married south bigcity union
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #2/q4iii.tex", r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Encompassing model regression \label{tab10})


