

clear
log using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/hw3.smcl", replace  
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/hprice1.dta"
reg price sqrft bdrms, robust
display e(r2_a)
gen bdrmssqrft = bdrms*sqrft
gen bdrmssq = bdrms^2
reg price sqrft bdrms bdrmssqrft bdrmssq, robust
display e(r2_a)


clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/HPRICE3.dta"
reg price rooms baths area land age agesq
sum age
local meanage = r(mean)
display _b[age] + 2*_b[agesq]*`meanage'
hettest
reg price rooms baths area land age agesq, robust


clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/LAWSCH85.dta"
reg lsalary LSAT GPA llibvol lcost studfac age rank north south east west
test llibvol lcost rank studfac age north south east west
test LSAT GPA

reg lsalary LSAT GPA llibvol lcost studfac age rank north south east west
hettest

reg lsalary LSAT GPA llibvol lcost studfac age rank north south east west, robust

  log close
  
  eststo clear
eststo: reg price sqrft bdrms, robust
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/q1i.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First regression \label{tab5})
  
  eststo clear
eststo: reg price sqrft bdrms bdrmssqrft bdrmssq, robust
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/q1ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Second regression \label{tab6})
  
  eststo clear
eststo: reg price rooms baths area land age agesq
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/q2i.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Non-robust regression \label{tab3})
  
  eststo clear
eststo: reg price rooms baths area land age agesq, robust
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/q2ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Regression \label{tab4})
  
  eststo clear
eststo: reg lsalary LSAT GPA llibvol lcost studfac age rank north south east west, robust
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/q3ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Non-robust regression \label{tab1})
  
  eststo clear
eststo: reg lsalary LSAT GPA llibvol lcost studfac age rank north south east west
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #3/q3i.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Robust regression \label{tab2})
  
