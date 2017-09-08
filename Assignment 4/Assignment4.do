
clear
log using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/hw4.smcl", replace
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/CARD.dta"
reg lwage educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66

eststo clear
eststo: reg lwage educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q1i.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(OLS Log wage regression \label{tab1})
  
reg educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 nearc4
eststo clear
eststo: reg educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 nearc4
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q1ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(Education on part (i) independent variables plus nearc4 \label{tab2})
  
ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc4), first
eststo clear
  ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc4), savefirst
esttab _ivreg2_educ using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q1iii.tex", label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage of regression using nearc4 as an IV for education \label{tab3})
  
  eststo clear
  ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc4)
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q1iiiV.tex", label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(IV regression using nearc4 as an IV for educ \label{tab15})
  

ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc2 nearc4), savefirst
eststo clear
  ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc2 nearc4), savefirst 
esttab _ivreg2_educ using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q1iv1.tex", label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage of regression using nearc4 and nearc2 as an IV for education \label{tab4})
  
ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc2 nearc4)
eststo clear
  ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc2 nearc4)
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q1iv.tex", stats(sargan sarganp) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(IV regression using near2 and nearc4 as IV for educ \label{tab5})

  *HAUSMAN TEST*
  reg  lwage educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 nearc4
  est store m1
  ivreg lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc4)
  est store m2
  hausman m1 m2

  
*END OF NUMBER 1

clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/MROZ.dta"

eststo clear
  ivreg2 lwage exper expersq (educ = fatheduc huseduc motheduc) 
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q2i.tex", stats(sargan sarganp) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(IV regression using fatheduc, huseduc, and motheduc as IV for educ \label{tab6})
  
  eststo clear
  ivreg2 lwage exper expersq (educ = fatheduc huseduc motheduc), savefirst 
esttab _ivreg2_educ using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q2ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage regression  \label{tab7})
  
ivreg2 lwage exper expersq (educ = fatheduc huseduc motheduc kidslt6 kidsge6)
eststo clear
eststo:   ivreg2 lwage exper expersq (educ = fatheduc huseduc motheduc kidslt6 kidsge6), savefirst
esttab _ivreg2_educ using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q2iv1.tex", se r2(4)  label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage regression \label{tab8})
  
  eststo clear
eststo:   ivreg2 lwage exper expersq (educ = fatheduc huseduc motheduc kidslt6 kidsge6)
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q2iv.tex", stats(sargan sarganp) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(IV regression with multiple IV for educ \label{tab9})
  

  
clear
use "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/NLS80.dta"  

  eststo clear
eststo:   ivreg2 lwage exper tenure married south urban black educ (iq = kww)
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q3i.tex", stats(sargan sarganp) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(IV regression with kww as IV for edu \label{tab10})
  
    eststo clear
eststo:   ivreg2 lwage exper tenure married south urban black educ (iq = kww), savefirst
esttab _ivreg2_iq using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q3ii.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage regression testing relevance \label{tab11})

eststo clear
eststo:   ivreg2 lwage exper tenure married south urban black (iq educ = kww meduc feduc)
esttab using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q3iii.tex", stats(sargan sarganp) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(IV regression adding kww, meduc, and feduc as instruments for educ and iq \label{tab12})
  
  eststo clear
eststo:   ivreg2 lwage exper tenure married south urban black (iq educ = kww meduc feduc), savefirst
esttab _ivreg2_iq using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q3iviq.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage regression testing relevance of IV with iq \label{tab13})
  
    eststo clear
eststo:   ivreg2 lwage exper tenure married south urban black (iq educ = kww meduc feduc), savefirst
esttab _ivreg2_educ using "/Users/mdk31/Documents/Economics/Fall 2014/Econometrics/Homework #4/q3ived.tex", se r2(4) label replace booktabs ///
  alignment(D{.}{.}{-1}) width(0.8\hsize)        ///
  title(First stage regression testing relevance of IV with educ \label{tab14})
 
 log close
