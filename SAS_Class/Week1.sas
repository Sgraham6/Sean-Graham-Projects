*---------------------------------------------------------------------------*
a simplest example with DATA step and PROC step
*---------------------------------------------------------------------------*;
DATA distance;
    Miles = 26.22;
    Kilometers = 1.61*Miles;
RUN;
    
PROC PRINT DATA = distance;
    TITLE 'first example';
RUN;



*---------------------------------------------------------------------------*
Example of List Input with Spaces Delimiter
*---------------------------------------------------------------------------*;
DATA score;
    INFILE DATALINES;
    INPUT first_name $ last_name $ age pre_score post_score;
    DATALINES;
Jason Miller 42 4  25
Tina Jacobson 36 31 .
Jake  . . 20  62
Amy Cooze . 23   70
;
RUN;

PROC PRINT DATA=score;
    TITLE 'Reading in Data Using List Input - Data Separated by Spaces';
RUN;


*---------------------------------------------------------------------------*
Example of List Input with Commas Delimiter
Reading data values separated by commas. Using DLM option.
Values can also be separated by other delimiters. 
*---------------------------------------------------------------------------*;

DATA score;
   INFILE DATALINES DLM=',' DSD;
   INPUT first_name $ last_name $ age pre_score post_score;
   DATALINES;
Jason , Miller, 42, 4, 25
Tina, Jacobson, 36, 31, .
Jake,  ., 24, 20, 62
Amy, Cooze, ., 23, 70
;
RUN;

PROC PRINT DATA=score;
    TITLE 'Reading in Data Using List Input - Data Separated by Commas';
RUN;


*---------------------------------------------------------------------------*
Example of Column Input
Each variable has to be in the same position in each row of data.  
Missing data can be represented by blanks. 
There are no DLM or DSD options when using column input.
*---------------------------------------------------------------------------*;
DATA score;
   INFILE DATALINES ;
   INPUT name $ 1-14 age 16-18 pre_score 20-22 post_score 24-26;
   DATALINES;
Jason Miller   42   4   25
Molly Jacobson 52       24 
;
RUN;

PROC PRINT DATA=score;
    TITLE 'Reading in Data using Column Input';
RUN;



* Example of Formatted Column Input with Pointers and Informats;
*---------------------------------------------------------------------------*
With this method we give the starting position (using the at character) 
followed by the variable name, followed by what is called an informat. 
Informats tell SAS how to bring in or decode the variable.
Informats must end with a period.
*---------------------------------------------------------------------------*;
DATA employnees;
   INFILE DATALINES ;
   INPUT @1 name $14.
         @16 age  3.
         @20 DOB    mmddyy10.
         @32 Salary   dollar10.2; 
        
   DATALINES;
Jason Miller   042 4/20/1965   25000.21
Molly Jacobson 52  12/9/72     75000.50 
;
RUN;

/* Another way to use pointer controls
+1 means moving the pointer 1 column forward.*/


DATA employnees;
   INFILE DATALINES ;
   INPUT name $14. +1 age 3. +1 DOB mmddyy10. +2 Salary dollar10.2; 
        
   DATALINES;
Jason Miller   42  4/20/1965   25000.21
Molly Jacobson 52  12/9/72     75000.50 
;
RUN;

PROC PRINT DATA=employnees;
    TITLE 'Reading in Data using Pointers/Informats';
    FORMAT DOB mmddyy10. Salary dollar10.2
RUN;




*Example of Modified List Input with Colon(:) and Ampersand(&) Modifers Example;

DATA employnees;
   INFILE DATALINES ;
   INPUT name : & $14. 
         age :3.
         DOB : mmddyy10.
         Salary : comma9.2; 
   DATALINES;
Jason Miller     42       4/20/1965   25,000.21
Molly Jacobson      52  12/9/72   75,000.50 
;
RUN;


PROC PRINT DATA=employnees;
    TITLE 'Reading in Data using Modifers';
    FORMAT DOB mmddyy10. Salary comma9.;
RUN;


*---------------------------------------------------------------------------*
Example of list input with informat statemeent
Note that we do not use colon in the informat statement
*---------------------------------------------------------------------------*;

DATA employnees;
   INFILE DATALINES ;
   INFORMAT name $14. age 3. DOB mmddyy10. Salary comma9.2; 
   INPUT name & $ age DOB Salary ; 
   DATALINES;
Jason Miller     42       4/20/1965   25,000.21
Molly Jacobson      52  12/9/72   75,000.50 
;
RUN;



PROC PRINT DATA=employnees;
    TITLE 'Reading in Data using List Input and Informat';
    FORMAT DOB mmddyy10. Salary comma9.;
RUN;


*---------------------------------------------------------------------------*
Example of Using a DATA step to read in data from external files 
FIRSTOBS = 2 to tell SAS to start with row 2 
Use the DSD option to read csv files 
Use pre_test_date:mmddyy10. to read the special data
*---------------------------------------------------------------------------*;
DATA score;
   INFILE '/folders/myfolders/Week1/test_score.csv' DSD FIRSTOBS = 2;
   INPUT first_name $ last_name $ age pre_score post_score pre_test_date;
   INFORMAT pre_test_date mmddyy10.;
RUN;

PROC PRINT DATA=score;
    TITLE 'Reading in Data from a CSV File using DATA step';
    FORMAT pre_test_date mmddyy10.
RUN;



*---------------------------------------------------------------------------*
Example of Using PROC IMPORT to read a csv file Example
*---------------------------------------------------------------------------*;

PROC IMPORT  
    DATAFILE='/folders/myfolders/Week1/test_score.csv' 
    OUT = score  DBMS = csv
    REPLACE ;
    GETNAMES = yes;
    GUESSINGROWS=9999;
RUN;

PROC PRINT DATA=score;
    TITLE 'Reading in Data Using PROC IMPORT';
*PROC CONTENTS DATA=score;
RUN;


*---------------------------------------------------------------------------*
Example of Using PROC IMPORT to read an excel file Example
*---------------------------------------------------------------------------*;

PROC IMPORT  
DATAFILE='/folders/myfolders/Week1/test_score.xlsx' 
    OUT = score  DBMS = xlsx
    REPLACE ;
    GETNAMES = yes;
RUN;

PROC PRINT DATA=score;
    TITLE 'Reading in Data from excel';
RUN;