* Problem 1: Macros;
* 1. Use %LET to create a macro variable named ClassAge, assigning to it a value of Pre-K 4;

%LET ClassAge = %STR(Pre-K 4);


* 2. Read the data set from the file '/folders/myfolders/Week6/School 1 final.csv' and name it 
final. Then use IF to subset with the macro variable &ClassAge. Name the subset as ClassAge_final. 
Print it using the macro variable in TITLE;

DATA final;
   INFILE '/home/u60648806/My Folders/Week6/school 1 final.csv' DSD FIRSTOBS = 2;
   INPUT ClassID ChildID Gender $ ClassAge $ Language $ f1 f2 f3 f4;
RUN;

DATA ClassAge_final; 
    SET final; 
    IF ClassAge = "&ClassAge";
RUN;

PROC PRINT DATA = ClassAge_final;
	TITLE "&ClassAge";
RUN;


* 3. Create a macro named average with two parameters category and question. In the macro, firstly 
apply PROC MEANS for the data set final to calculate the mean of &question by &category. In the 
PROC MEANS, use option NOPRINT, and let OUT=averagescore. Then apply PROC PRINT to print the data 
averagescore using the macro variables in the TITLE;

%MACRO average(category=, question=);
	PROC SORT DATA = final;
		BY &category;
	RUN;
	PROC MEANS DATA = final NOPRINT;
    	OUTPUT MEAN(&question) = Mean&question OUT = averagescore;
    	BY &category;
    RUN;
    PROC PRINT DATA = averagescore;
    	TITLE "Mean of &question by &category";
	RUN;
%MEND average;


* 4. Invoke the macro %average(category=Gender, question=f1);

%average(category = Gender, question = f1);


* 5. Invoke the macro %average(category= ClassAge, question=f3);

%average(category = ClassAge, question = f3);


* Problem 2: Visualization;
* 1. Read the data from the file: '/folders/myfolders/Week6/2010-2015-Age65above Final Death 
Count.csv' with INPUT year month gender $ age ICD10 $ death. Name the data as death_count;

DATA death_count;
   INFILE '/home/u60648806/My Folders/Week6/2010-2015-Age65above Final Death Count.csv' 
   DSD FIRSTOBS = 2;
   INPUT year month gender $ age ICD10 $ death;
RUN;


* 2. Use PROC MEANS to get the total death of each year. Create a horizontal Bar Chart for the 
total death of each year;

PROC MEANS DATA = death_count SUM MAXDEC = 0;
     CLASS year;
     VAR death;
RUN;

PROC SGPLOT DATA = death_count;
    HBAR year / BARWIDTH = 0.5 RESPONSE = death;
    LABEL year = 'Year' death = 'Death';
    TITLE 'Death by Year';
RUN;


* 3. Use PROC MEANS to get total death by ICD10. Create a scatter plot for the total death by 
ICD10. Label the x-axis as ‘Death Code’, y-axis as ‘Total Death’, and save the graph as ‘Scatter 
plot total death by Death Code.png’;

PROC MEANS DATA = death_count SUM MAXDEC = 0;
     CLASS ICD10;
     VAR death;
     OUTPUT OUT = death_by_ICD10 SUM(death) = Sum;
RUN;

ODS LISTING GPATH = '/home/u60648806/My Folders/Week6/';
ODS GRAPHICS / RESET
    IMAGENAME = 'Scatter plot total death by Death Code'
    OUTPUTFMT = PNG;

PROC SGPLOT DATA = death_by_ICD10;
    SCATTER X = ICD10 Y = Sum;
    TITLE 'Death Code by Total Death';
    xaxis label = 'Death Code';
    yaxis label = 'Total Death';
RUN;


* 4. Create a histogram for the death where the ICD=52;

DATA death_count_ICD52; 
    SET death_count; 
    WHERE ICD10 = '52';
RUN;

PROC SGPLOT DATA = death_count_ICD52;
    HISTOGRAM death / BINWIDTH = 100 SHOWBINS SCALE = PERCENT;
    TITLE 'Death Where ICD = 52';
RUN;


* 5. Create a vertical box plot for the death with category = gender;

PROC SGPLOT DATA = death_count;
    VBOX death / CATEGORY = gender;
    TITLE 'Death by Gender';
RUN;


* 6. Create a horizontal box plot for the death with category = month. Save the graph as ‘Boxplot 
death by month.png’;

ODS LISTING GPATH = '/home/u60648806/My Folders/Week6/';
ODS GRAPHICS / RESET
    IMAGENAME = 'Boxplot death by month'
    OUTPUTFMT = PNG;

PROC SGPLOT DATA = death_count;
    HBOX death / CATEGORY = month;
    TITLE 'Death by Month';
RUN;