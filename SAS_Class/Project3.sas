* Problem 1.
* 1. Read the four data sets from the files: '/folders/myfolders/Week3/school 1 midterm.csv',
'/folders/myfolders/Week3/school 2 midterm.csv', '/folders/myfolders/Week3/school 1 final.csv',
'/folders/myfolders/Week3/school 2 final.csv'. And name the three data sets as s1m, s2m, and 
s1f, s2f respectively;

DATA s1m;
   INFILE '/home/u60648806/My Folders/Week3/school 1 midterm.csv' DSD FIRSTOBS = 2;
   INPUT ClassID ChildID Gender $ ClassAge $ Language $ m1 m2 m3 m4;
RUN;

DATA s2m;
   INFILE '/home/u60648806/My Folders/Week3/school 2 midterm.csv' DSD FIRSTOBS = 2;
   INPUT ClassID ChildID Gender $ ClassAge $ m1 m2 m3 m4;
RUN;

DATA s1f;
   INFILE '/home/u60648806/My Folders/Week3/school 1 final.csv' DSD FIRSTOBS = 2;
   INPUT ClassID ChildID Gender $ ClassAge $ Language $ f1 f2 f3 f4;
RUN;

DATA s2f;
   INFILE '/home/u60648806/My Folders/Week3/school 2 final.csv' DSD FIRSTOBS = 2;
   INPUT ClassID ChildID Gender $ ClassAge $ f1 f2 f3 f4;
RUN;


* 2. Interleave s1m and s2m by ChildID. Name the new data set as midterm and print it;

PROC SORT DATA = s1m;
    BY ChildID;
RUN;

PROC SORT DATA = s2m;
    BY ChildID;
RUN;

DATA midterm;
    SET s1m s2m;
    BY ChildID;
RUN;

PROC PRINT DATA = midterm;
    TITLE 'Midterm';
RUN;


* 3. Interleave s1f and s2f by ChildID. Name the new data set as final and print it.
PROC SORT DATA = s1m;

PROC SORT DATA = s1f;
    BY ChildID;
RUN;

PROC SORT DATA = s2f;
    BY ChildID;
RUN;

DATA final;
    SET s1f s2f;
    BY ChildID;
RUN;

PROC PRINT DATA = final;
    TITLE 'Final';
RUN;


* 4. Merge the data sets midterm and final by ChildID. Name the new data set as assess and 
print it;

PROC SORT DATA = midterm;
    BY ChildID; 
RUN; 

PROC SORT DATA = final; 
    BY ChildID; 
RUN; 
 
DATA assess; 
  MERGE midterm final; 
  BY ChildID; 
RUN; 

PROC PRINT DATA = assess; 
    TITLE 'Assess';
RUN; 


* 5. Find the mean of each numerical variables in the data set assess;

PROC MEANS DATA = assess MEAN MAXDEC=2;
     VAR  m1 m2 m3 m4 f1 f2 f3 f4;
     TITLE 'Means';
RUN;


* 6. Use OUTPUT statement and IF statement to regroup the data set assess into 4 data sets 
PREK4, PREK3, Female, and Male. Print the 4 data sets;

DATA PREK4 PREK3 Female Male;
    SET assess; 
    IF ClassAge = 'Pre-K 4' THEN OUTPUT PREK4;
    IF ClassAge = 'Pre-K 3' THEN OUTPUT PREK3;
    IF Gender = 'Female' THEN OUTPUT Female;
    IF Gender = 'Male' THEN OUTPUT Male;
RUN;

PROC PRINT DATA = PREK4; 
    TITLE 'PREK4';
RUN; 

PROC PRINT DATA = PREK3; 
    TITLE 'PREK3';
RUN; 

PROC PRINT DATA = Female; 
    TITLE 'Female';
RUN; 

PROC PRINT DATA = Male; 
    TITLE 'Male';
RUN;


* 7. Use KEEP or DROP data step statements to select the two variables m2 and f2 from the data 
set assess. Name the selected data set as select_m2_f2. Print the first five observations;

DATA select_m2_f2;
    SET assess (KEEP = m2 f2);

PROC PRINT DATA = select_m2_f2 (OBS = 5);
    TITLE 'Select m2 and f2';
RUN;


* 8. Use KEEP or DROP data set options to select the two variables m3 and f3 from the data set 
assess. Name the selected data set as select_m3_f3. Print the observations from the 50th row 
to the 100th row;

DATA select_m3_f3;
    SET assess (KEEP = m3 f3);

PROC PRINT DATA = select_m2_f2 (FIRSTOBS = 50 OBS = 100);
    TITLE 'Select m3 and f3';
RUN;


* 9. Add two new variables (columns) d1 and d2 in the data set assess, where d1=f1-m1, d2=f2-m2. 
Use Where data statement or data set option to select the observations with d1 >0 and d2>0. 
Name the selected data set as improvement and print it;

DATA differences; 
    SET assess; 
    d1 = f1 - m1; d2 = f2 - m2;
RUN;

DATA improvement; 
    SET differences (WHERE=(d1 > 0 and d2 > 0));
RUN;

PROC PRINT DATA = improvement;
     TITLE 'Improvement';
RUN;
