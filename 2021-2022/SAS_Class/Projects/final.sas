* 1. Import the Bay Area House Price data set from the file '/folders/myfolders/Week8/Bay 
Area House Price.csv’. Name the data set as house_price;

PROC IMPORT
	DATAFILE = '/home/u60648806/My Folders/Week8/Bay Area House Price.csv'
	OUT = house_price DBMS = csv
	REPLACE ;
	GETNAMES = yes;
	GUESSINGROWS = 9999;
RUN;

PROC PRINT DATA = house_price (OBS=10);
    TITLE 'Bay Area House Price';
RUN;


* 2. Drop the variables: address, info, z_address, neighborhood, latitude, longitude, and 
zpid both using Data Statement and PROC SQL. Name the new data set as house_price;

DATA house_price;
	SET house_price (DROP = address info z_address neighborhood latitude longitude zpid);
RUN;

proc sql outobs = 10;
	Alter table house_price
	DROP address, info, z_address, neighborhood, latitude, longitude, zpid;
quit;

PROC PRINT DATA = house_price (Obs = 10);
    TITLE 'Bay Area House Price';
RUN;


* 3. Add a new variable price_per_square_foot defined by lastsoldprice/finishedsqft both 
using Data Statement and PROC SQL;

DATA house_price;
	SET house_price;
	price_per_square_foot = lastsoldprice/finishedsqft;
RUN;

proc sql undo_policy = none;
	create table house_price as
	select *, lastsoldprice/finishedsqft as price_per_square_foot
	from house_price;
quit;

PROC PRINT DATA = house_price (Obs = 10);
    TITLE 'Bay Area House Price';
RUN;


* 4. Find the average of lastsoldprice by zipcode both using Data Statement and PROC SQL;

PROC SORT DATA = house_price;
	BY zipcode;
RUN;

PROC MEANS DATA = house_price NOPRINT;
	VAR lastsoldprice;
	BY zipcode;
	OUTPUT OUT = Averages MEAN(lastsoldprice) = Mean_lastsoldprice;
RUN;

PROC PRINT DATA = Averages;
	TITLE 'Last Sold Price by Zipcode';
RUN;
	
proc sql;
	TITLE 'Last Sold Price by Zipcode';
	select zipcode, avg(lastsoldprice) as Mean_lastsoldprice
	from house_price
	group by zipcode;
quit;


* 5. Find the average of lastsoldprice by usecode, totalrooms, and bedrooms both using 
Data Statement and PROC SQL;

PROC SORT DATA = house_price;
	BY usecode totalrooms bedrooms;
RUN;

PROC MEANS DATA = house_price NOPRINT;
	VAR lastsoldprice;
	BY usecode totalrooms bedrooms;
	OUTPUT OUT = Averages MEAN(lastsoldprice) = Mean_lastsoldprice;
RUN;

PROC PRINT DATA = Averages;
	TITLE 'Last Sold Price by Use Code, Total Rooms, and Bedrooms';
RUN;
	
proc sql;
	TITLE 'Last Sold Price by Use Code, Total Rooms, and Bedrooms';
	select usecode, totalrooms, bedrooms, avg(lastsoldprice) as Mean_lastsoldprice
	from house_price
	group by usecode, totalrooms, bedrooms;
quit;


* 6. Plot the bar charts for bathrooms, bedrooms, usecode, totalrooms respectively, and 
save the bar chart of bedrooms as bedrooms.png;

PROC SGPLOT DATA = house_price;
    VBAR bathrooms / BARWIDTH = 0.5;
    LABEL bathrooms = 'Bathrooms';
    TITLE 'Number of Bathrooms';
RUN;

ODS LISTING GPATH = '/home/u60648806/My Folders/Week8';
ODS GRAPHICS / RESET
    IMAGENAME = 'Bedrooms'
    OUTPUTFMT = PNG;

PROC SGPLOT DATA = house_price;
    VBAR bedrooms / BARWIDTH = 0.5;
    LABEL bedrooms = 'Bedrooms';
    TITLE 'Number of Bedrooms';
RUN;

ODS LISTING CLOSE;

PROC SGPLOT DATA = house_price;
    VBAR usecode / BARWIDTH = 0.5;
    LABEL usecode = 'Use Code';
    TITLE 'Use Codes';
RUN;

PROC SGPLOT DATA = house_price;
    VBAR totalrooms / BARWIDTH = 0.5;
    LABEL totalrooms = 'Total Rooms';
    TITLE 'Total Number of Rooms';
RUN;


* 7. Plot the Histogram, boxplot for lastsoldprice, zestimate respectively. Are they 
normal or skewed? What’s the median of the lastsoldprice? What’s the median of the 
zestimate?;

PROC SGPLOT DATA = house_price;
    HISTOGRAM lastsoldprice / NBINS = 50 SHOWBINS SCALE = PERCENT;
    TITLE 'Last Sold Price Histogram';
RUN;

PROC SGPLOT DATA = house_price;
    VBOX lastsoldprice;
    TITLE 'Last Sold Price Box Plot';
RUN;

PROC SGPLOT DATA = house_price;
    HISTOGRAM zestimate / NBINS = 50 SHOWBINS SCALE = PERCENT;
    TITLE 'Zestimate Histogram';
RUN;

PROC SGPLOT DATA = house_price;
    VBOX zestimate;
    TITLE 'Zestimate Box Plot';
RUN;

* Neither variable is normal - both are positively skewed. Both medians appear to be
1500000 (although it is hard to tell using these plots);


* 8. Calculate the correlation coefficients of all numerical variables with the variable 
zesitmate, and plot the scatter plot and matrix. (Hint: Use PLOTS(MAXPOINTS=none)=scatter 
in PROC CORR  so that the scatter graph is shown. Otherwise you may not see the graph 
because the data is very large.);

PROC CORR DATA = house_price PLOTS(MAXPOINTS=none) = scatter;
	VAR bathrooms bedrooms finishedsqft lastsoldprice totalrooms yearbuilt zipcode
	price_per_square_foot;
	WITH zestimate;
	TITLE 'Correlations of Numeric Variables with Zestimate';
RUN;


* 9. Find a regression model for zestimate with the first three most correlated 
variables;

ODS GRAPHICS OFF;
PROC REG DATA = house_price;
	MODEL zestimate = lastsoldprice finishedsqft bathrooms;
	TITLE 'Regression Model For Zestimate 1';
RUN;

* All p values are < 0.05, and are thus significant. The multiple linear regression 
fitted model is:
zestimate = -136521 + 0.78058 * lastsoldprice + 419.68249 * finishedsqft + 25373 * bathrooms;


* 10. Find a regression model for zestimate with the first five most correlated variables;

ODS GRAPHICS OFF;
PROC REG DATA = house_price;
	MODEL zestimate = lastsoldprice finishedsqft bathrooms bedrooms yearbuilt;
	TITLE 'Regression Model For Zestimate 2';
RUN;

* The p values for the intercept and yearbuilt are > 0.05, and are thus not significant.
The p values for the remaining variables are < 0.05, and are thus significant. The
multiple linear regression fitted model is:
zestimate = 193236 + 0.77160 * lastsoldprice + 447.00624 * finishedsqft + 
53029 * bathrooms - 45902 * bedrooms
Now a regression model will be made using only the significant variables;

ODS GRAPHICS OFF;
PROC REG DATA = house_price;
	MODEL zestimate = lastsoldprice finishedsqft bathrooms bedrooms;
	TITLE 'Regression Model For Zestimate 3';
RUN;

* All p values are < 0.05, and are thus significant. The multiple linear regression 
fitted model is:
zestimate = -106447 + 0.77216 * lastsoldprice + 448.48548 * finishedsqft + 50710 * bathrooms
- 44088 * bedrooms;


* 11. Compare the adjusted R^2 in the two models from question 9) and 10). The model 
that has a bigger adjusted R^2 is better;

* The models in questions 9 and 10 have adjusted R^2 values of 0.8319 and 0.8328 respecitvly.
The second model is better, but not by much;


* 12. Use the better model from question 11) to predict the house prices given the values 
of independent variables. (You name the values of independent variables for  4 houses);

ods graphics off;
PROC REG DATA = house_price outest = regout noprint;
    MODEL zestimate = lastsoldprice finishedsqft bathrooms bedrooms;
RUN;

DATA newobservations;
   INPUT lastsoldprice finishedsqft bathrooms bedrooms;
   datalines;
500000 1000 3 3
1000000 2500 5 4
3500000 4000 7 7
600000 1300 4 3
;
RUN;

PROC SCORE DATA = newobservations SCORE = regout OUT = NewPreds type = parms nostd predict;
   VAR lastsoldprice finishedsqft bathrooms bedrooms;
RUN;

PROC PRINT data = NewPreds;
   TITLE 'Predicted Zestimate for Four Houses';
RUN;


* 13. Export the predictive values from question 12) as an excel file named 
‘prediction.xlsx’;

proc export data = NewPreds
    dbms = xlsx 
    outfile = '/home/u60648806/My Folders/Week8/prediction.xlsx' 
    replace;
run;


* 14. Create a macro named average with two parameters category and price. In the macro, 
firstly use PROC MEANS for the data set house_price to calculate the mean of &price by 
&category. In the PROC MEANS, use option NOPRINT, and let OUT=averageprice. Then use 
PROC PRINT to print the data averageprice using the macro variables in the TITLE;

%MACRO average(category=, price=);
	PROC SORT DATA = house_price;
		BY &category;
	RUN;
	PROC MEANS DATA = house_price NOPRINT;
    	OUTPUT MEAN(&price) = Mean&price OUT = averageprice;
    	BY &category;
    RUN;
    PROC PRINT DATA = averageprice;
    	TITLE "Mean of &price by &category";
	RUN;
%MEND average;


* 15. Call the macro %average(category=zipcode, price=price_per_square_foot);

%average(category = zipcode, price = price_per_square_foot);


* 16. Call the macro %average(category=totalrooms, price=zestimate);

%average(category = totalrooms, price = zestimate);