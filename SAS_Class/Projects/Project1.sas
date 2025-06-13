* Problem 1. Read in Data from DATALINES;
* 1. Use list input with spaces delimiter to read in the data. Print the data.;

DATA course;
    INFILE DATALINES;
    INPUT Course_name $ Course_number Days $ Credits;
    DATALINES;
DSCI 200 . 3
DSCI 307 TT 3
MATH 371 MW .
MATH 372 MW 3
;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data Using List Input with Spaces Delimiter';
RUN;


* 2. Use column input to read in the data. Print the data.;

DATA course;
   INFILE DATALINES;
   INPUT Course_name $ 1-4 Course_number 6-8 Days $ 10-11 Credits 13;
   DATALINES;
DSCI 200    3
DSCI 307 TT 3
MATH 371 MW  
MATH 372 MW 3
;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data using Column Input';
RUN;


* Problem 2. Read in Data from DATALINES;
* 1. Use formatted column input with pointers and informats to read in the data. Print the data.;

DATA course;
   INFILE DATALINES ;
   INPUT @1 Course $8.
         @10 Days  $2.
         @13 BeginDate mmddyy10.
         @24 EndDate mmddyy10.
         @35 Credits 1.
         @37 Tuition dollar8.2;
        
   DATALINES;
DSCI 200    08/26/2019 10/29/2019 3 3000.00
DSCI 307 TT 08/26/2019 12/12/2019 3 3000.00
MATH 371 MW 08/26/2019 12/11/2019   3000.00
MATH 372 MW 08/26/2019            3 3000.00
;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data using Pointers and Informats';
    FORMAT BeginDate mmddyy10. EndDate mmddyy10. Tuition dollar5.;
RUN;


* 2. Use modified list input with ampersand(&) and colon(:) modifiers to read in the data. 
Print the data.;

DATA course;
   INFILE DATALINES ;
   INPUT Course : & $8. 
         Days : $2.
         BeginDate : mmddyy10.
         EndDate : mmddyy10.
         Credits : 1.
         Tuition : dollar8.2; 
   DATALINES;
DSCI 200  .   08/26/2019  10/29/2019  3  3000.00
DSCI 307  TT  08/26/2019  12/12/2019  3  3000.00
MATH 371  MW  08/26/2019  12/11/2019  .  3000.00
MATH 372  MW  08/26/2019  .           3  3000.00
;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data using Modified List Input';
    FORMAT BeginDate mmddyy10. EndDate mmddyy10. Tuition dollar5.;
RUN;


* 3. Use list input with the informat statement to read in the data.;
DATA course;
   INFILE DATALINES ;
   INFORMAT Course $8. Days $2. BeginDate mmddyy10. EndDate mmddyy10. Credits 1. 
   Tuition dollar8.2; 
   INPUT Course & $ Days $ BeginDate EndDate Credits Tuition;
   DATALINES;
DSCI 200  .   08/26/2019  10/29/2019  3  3000.00
DSCI 307  TT  08/26/2019  12/12/2019  3  3000.00
MATH 371  MW  08/26/2019  12/11/2019  .  3000.00
MATH 372  MW  08/26/2019  .           3  3000.00
;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data using List Input and Informat';
    FORMAT BeginDate mmddyy10. EndDate mmddyy10. Tuition dollar5.;
RUN;


* Problem 3. Read in Data from External Files;
* 1. Use DATA step with INFILE and INPUT to read in data from an external file 
('/folders/myfolders/Week1/class_schedule.csv'). Print the data.;

DATA course;
   INFILE '/home/u60648806/My Folders/Week1/class_schedule.csv' DSD FIRSTOBS = 2;
   INPUT CourseName $ CourseNumber $ Days $ BeginDate:mmddyy10. EndDate:mmddyy10. 
   Credits Tuition:dollar6.;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data from a CSV File using DATA step';
    FORMAT BeginDate mmddyy10. EndDate mmddyy10. Tuition dollar5.;
RUN;


* 2. Use PROC IMPORT to read in data from an external file 
('/folders/myfolders/Week1/class_schedule.xlsx'). Print the data.;

PROC IMPORT  
DATAFILE='/home/u60648806/My Folders/Week1/class_schedule.xlsx' 
    OUT = course  DBMS = xlsx
    REPLACE ;
    GETNAMES = yes;
RUN;

PROC PRINT DATA=course;
    TITLE 'Reading in Data from Excel Using PROC IMPORT';
RUN;