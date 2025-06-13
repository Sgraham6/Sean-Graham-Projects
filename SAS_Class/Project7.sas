* Problem 1: PROC UNIVARIATE;
* Read the data set from the file: '/folders/myfolders/Week7/school 2 final.csv'. Name it 
as  s2f.  Then do the following analysis;

DATA s2f;
   INFILE '/home/u60648806/My Folders/Week7/school 2 final.csv' DSD FIRSTOBS = 2;
   INPUT ClassID ChildID Gender $ ClassAge $ f1 f2 f3 f4;
RUN;


* 1. Use PROC UNIVARIATE to analyze the variables f1, f2, f3, f4. Which variable is normal? 
Which variable is right-skewed? Which variable is left-skewed?;

proc univariate data = s2f;
    var f1;
    var f2;
    var f3;
    var f4;
run;

* The skewness for f1 is -0.4041, so the data is normal.
* The skewness for f2 is -0.6524, so the data is left-skewed.
* The skewness for f3 is -0.2702, so the data is normal.
* The skewness for f2 is -0.0973, so the data is normal.


* 2. Use PROC UNIVARIATE with option plot to graph the histogram, box-plot, and Normal 
Probability Plot for the variable f3, and only print the graphs;

ODS SELECT PLOTS;
proc univariate data = s2f PLOT;
    var f3;
run;


* 3. Add a new variable difference defined as difference = f4-f2. Analyze the variable 
difference and graph its histogram, ppplot, qqplot. Print only the TestsNormality and 
TestsForLocation. Does the mean of the variable difference equal to 0 statistically?;

DATA difference; 
    SET s2f; 
    difference = f4 - f2;
RUN;

ODS SELECT TestsForNormality TestsForLocation;
proc univariate data = difference normal;
    var difference;
run;

proc univariate data = difference NOPRINT;
	var difference;
    histogram; ppplot; qqplot;
run;

* In the TestForLocaiton chart, the p values are all less than 0.05, so the null hypothesis
(mu = 0) is rejected. The mean of the variable difference is not 0;


* 4. Use PROC UNIVARIATE to analyze the variable difference by Gender;

PROC SORT DATA = difference;
	BY Gender;
RUN;

proc univariate data = difference;
	var difference;
	BY Gender;
RUN;


* 5. For the variable difference, calculate custom percentiles from 5 to 100 by 5 and 
export these percentiles to an xlsx file named percentiles.xlsx;

proc univariate data = difference noprint;
    var difference;
    output out = percentiles
    	pctlpts = 5 to 100 by 5
    	pctlpre = P_;
run;

proc print data = percentiles;
run;

proc export data = percentiles
    dbms = xlsx 
    outfile = '/home/u60648806/My Folders/Week7/percentiles.xlsx' 
    replace;
run;