* Problem 1 Using data set countries;
* 1. Create a table with Continent, sum of Population, and number of the Countries;

libname Week5 '/home/u60648806/My Folders/Week5';
proc sql; 
    title 'Population and Countries by Continent'; 
    select Continent, sum(Population) as Population format=comma16., count(*) as Countries
    from Week5.countries
    where Continent is not missing
    group by Continent;
Quit;


* 2. Sub-set a data set from Continent that only includes the Continents with more than 40 
countries, then, create a table with Continent, sum of Population, and number of the Countries;

libname Week5 '/home/u60648806/My Folders/Week5';
proc sql; 
    title 'Population and Countries by Continent'; 
    select Continent, sum(Population) as Population format=comma16., count(*) as Countries
    from Week5.countries
    where Continent is not missing
    group by Continent
    having count(*) gt 40;
Quit;


* Problem 2;
* Using data sets unitedstates, postalcodes, uscitycoords, create a table containing all States 
in US with columns of State, State_code, Capital, Latitude, and Longitude;

libname Week5 '/home/u60648806/My Folders/Week5';
proc sql outobs=10;
    select us.Name 'State' format=$15., pc.Code, us.Capital format=$15., c.Latitude, c.Longitude 
    from Week5.unitedstates us, Week5.postalcodes pc, Week5.uscitycoords c 
    where us.Capital = c.City and us.Name = pc.Name and pc.Code = c.State;
    title 'States, Codes, Capitals, and Coordinates';
Quit;


* Problem 3;
* Compare DATA step match-merges with PROC SQL joins, and see how they work similarly and 
differently. Create a table with columns of FLD_ID, Farmer, and Crop by joining below two tables 
together using data step and PROC SQL joins;

* Create tables;
DATA FLDFarmers;
    INFILE DATALINES;
    INPUT Field_id Farmer $;
    DATALINES;
12678 Farmer_A
12678 Farmer_A
11857 Farmer_B
11857 Farmer_B
10446 Farmer_A
10446 Farmer_C
14789 Farmer_G
;
RUN;

DATA FLDCrops;
    INFILE DATALINES;
    INPUT Field_id Crop $;
    DATALINES;
12678 Corn
12678 Soybeans
11857 Wheat
11857 Corn
13229 Soybeans
13229 Wheat
10889 Corn
10446 Soybeans
15668 Wheat
;
RUN;

* Sort Tables;
PROC SORT DATA = FLDFarmers;
	BY Field_id;
RUN;

PROC SORT DATA = FLDCrops;
	BY Field_id;
RUN;

* Merges;
Data datastepmatchmerge;
	MERGE FLDFarmers FLDCrops;
	By Field_id;
RUN;
PROC PRINT DATA = datastepmatchmerge;
	TITLE 'Data Step Match Merge';
RUN;

proc sql; 
	title 'Inner Join';
    select f.Field_id, Farmer, Crop 
    from FLDFarmers f inner join FLDCrops c
    on f.Field_id = c.Field_id
    order by Field_id;
Quit;

proc sql;
	title 'Left Outer Join';
    select f.Field_id, Farmer, Crop 
    from FLDFarmers f left join FLDCrops c
    on f.Field_id = c.Field_id
    order by Field_id;
Quit;

proc sql;
	title 'Right Outer Join';
    select c.Field_id, Farmer, Crop 
    from FLDFarmers f right join FLDCrops c
    on f.Field_id = c.Field_id
    order by Field_id;
Quit;

proc sql; 
	title 'Full Outer Join';
    select coalesce(f.Field_id,c.Field_id) as Field_id, Farmer, Crop 
    from FLDFarmers f full join FLDCrops c
    on f.Field_id = c.Field_id
    order by Field_id;
Quit;

* Observations:
Both PROC SQL and DATA step allow for separate tables to be combined through common columns. 
While PROC SQL provides more options for joins than DATA step, the tables must be sorted first.
Furthermore, PROC SQL doesn't seem to handle duplicate values as well as DATA step, as can be
seen when comparing the Data Step Merge Match table with the Full Outer Join table. Were it not 
for these duplicates, the tables would be the same.