ods pdf file="/home/u60648806/My Folders/Week2/Project2_results.pdf";

* Problem 1. Export Dataset;
* 1. Create a libname using the command: LIBNAME Week2 '/folders/myfolders/Week2';

LIBNAME Week2 '/home/u60648806/My Folders/Week2';


* 2. Read data from the file: '/folders/myfolders/Week2/2010-2015-Age65above Final Death Count.csv'.
Save the data as a permanent SAS dataset named death_count in the library Week2.;

DATA Week2.death_count;
   INFILE '/home/u60648806/My Folders/Week2/2010-2015-Age65above Final Death Count.csv'
   DSD FIRSTOBS = 2;
   INPUT year month gender $ age ICD10 death;
RUN;


* 3. Use SET to read data from the permanent dataset death_count in the library Week2.
Use WHERE to select data that year =2015. Name the selected data as death_2015;

LIBNAME  Week2 '/home/u60648806/My Folders/Week2';
DATA death_2015; 
    SET Week2.death_count; 
    WHERE year = 2015;
RUN;

* 4. Use PROC EXPORT to save the data death_2015 as a CSV file named death_2015.csv;

PROC EXPORT DATA = death_2015
OUTFILE ='/home/u60648806/My Folders/Week2/death_2015.csv' 
    dbms=csv
    replace;
RUN;


* Problem 2 PROC MEANS
* 1. Read data from the file: '/folders/myfolders/Week2/2010-2015-Age65above Final Death Count.csv'
 with INPUT year month gender $ age ICD10 $ death. Name the data as death_count;

DATA death_count;
    INFILE '/home/u60648806/My Folders/Week2/2010-2015-Age65above Final Death Count.csv'
    DSD FIRSTOBS = 2;
    INPUT year month gender $ age ICD10 death;
RUN;


* 2. Use Class statement to calculate the sum of the variable death by year;

PROC MEANS DATA = death_count SUM MAXDEC = 0;
     CLASS year;
     VAR  death;
     TITLE 'Proc Means - Sum of Deaths by Year';
RUN;


* 3. Use Class statement to calculate the mean and std of the variable death by month. 
Use OUTPUT statement to save the mean and std into a data set named death_by_month;

PROC SORT DATA = death_count;
     BY month;
RUN;

PROC MEANS DATA = death_count NOPRINT;
     CLASS month;
     VAR  death;
     OUTPUT OUT = death_by_month MEAN(death) = Mean_Death STD(death) = STD_Death;
     TITLE 'Proc Means - Mean and STD of Deaths by Month';
RUN;

PROC PRINT DATA = death_by_month;
	TITLE 'Proc Means - Mean and STD of Deaths by Month';
RUN;


* 4. Use By under PROC MEANS to calculate the sum of the variable death by gender;

PROC SORT DATA = death_count; 
    BY gender;
RUN;

PROC MEANS DATA = death_count SUM MAXDEC = 0 ;
     VAR  death;
     BY gender;
     TITLE 'Proc Means - Sum of Deaths by Gender';
RUN;


* Problem 3 PROC FREQ
* 1. Use PROC FREQ to find the frequency distributions for the variables year and gender 
respectively in the dataset death_count;

PROC FREQ DATA = death_count;
    TABLES year gender;
    TITLE 'One-Way Frequency Tables';
RUN;


* 2. Use PROC FREQ to find the 2-way frequency distributions for the variables gender*month 
in the dataset death_count;

PROC FREQ DATA = death_count;
     TABLES gender*month ;
     TITLE 'Two-way Frequency Table Gender by Month';
RUN;

ods pdf close;