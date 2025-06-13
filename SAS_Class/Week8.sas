***************************************************************
*Example-PROC CORR;
**************************************************************;
*Read data;
PROC IMPORT out=auto DATAFILE='/folders/myfolders/Week8/auto.xlsx'
            DBMS=xlsx REPLACE;
            SHEET='auto';
            GETNAMES=YES;
RUN;
PROC PRINT data=auto (OBS=5);
    TITLE 'Auto data (first five observations)'; 
RUN;

*Part I;
PROC CORR DATA = auto  PLOTS = scatter;
    VAR weight acceleration;
    WITH mpg;
    TITLE 'Correlations of Weight and Acceleration with mpg';
RUN;

*Part II;
PROC CORR DATA = auto  PLOTS = matrix;
    WITH mpg;
    TITLE 'Correlations with mpg';
RUN;
***************************************************************
*Example- Simple Linear Regression Model of Auto Data;
**************************************************************;
ods graphics off;
PROC REG DATA=auto;
    MODEL mpg=weight;
    title 'Simple Linear Regression';
RUN;
***************************************************************
*Example- Multiple Linear Regression Model of Auto Data;
**************************************************************;
*Part I Multiple Linear Regression Model 1; 
ods graphics off;
PROC REG DATA=auto;
    MODEL mpg=cylinders displacement horsepower weight;
    title 'Multiple Linear Regression Model 1';
RUN;

*Part II Multiple Linear Regression Model 2; 
ods graphics off;
PROC REG DATA=auto;
    MODEL mpg=weight horsepower displacement cylinders acceleration model;
    title 'Multiple Linear Regression Model 2';
RUN;

*Part III Multiple Linear Regression Model 3; 
ods graphics off;
PROC REG DATA=auto;
    MODEL mpg=weight model;
    title 'Multiple Linear Regression Model 3';
RUN;
***************************************************************
*Example-Predictiton;
**************************************************************;
ods graphics off;
PROC REG DATA=auto outtest=regout noprint;
    MODEL mpg= weight model;
RUN;

DATA newobservation;
   INPUT weight model;
   datalines;
3000 90
4000 99
3500 95
;
RUN;

PROC SCORE DATA=newobservation SCORE=regout OUT=NewPred type=parms nostd predict;
   VAR weight model;
RUN;
PROC PRINT data=NewPred;
   title1 'Predicted MPG for Three Cars';
RUN;
