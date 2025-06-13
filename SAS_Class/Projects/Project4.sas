* Problem 1
* Using data set worldtemps, create a table with title assigned, the table contains 20 observations, 
with city names (labeled as “City”), and their high temperature in Celsius (labeled as “HighTempC”) 
with 1 decimal, and order the table by HighTempC from high to low;

libname Week4 '/home/u60648806/My Folders/Week4';
proc sql outobs = 20; 
    title 'City and Temperatures'; 
    select City, AvgHigh as HighTempC format = 4.1, AvgLow as LowTempC format = 4.1
    from Week4.worldtemps
    order by HighTempC desc;
quit;


* Problem 2
* Using data set postalcodes, create a table containing states of Illinois, Ohio, North Carolina in 
the given format;

libname Week4 '/home/u60648806/My Folders/Week4';
proc sql; 
    title 'Postal Codes by State'; 
    select 'In United States', 'Postal code for', 'of', Name label='#', 'Is', Code label='#'
    from Week4.postalcodes
    having Name in ('Illinois', 'Ohio', 'North Carolina');
quit;


* Problem 3
* Using data set worldtemps, create a table containing City (Labeled as “City”), AvgHigh in 
Celsius (labeled as “AvgH”), AvgLow in Celsius (Labeled as “AvgL”), Range between AvgHigh and 
AvgLow in Celsius (Labeled as “RangeC”), and only contain the cities with RangeC between 38.0 
and 40.0 in Celsius, and order the table by RangeC from low to high;

libname Week4 '/home/u60648806/My Folders/Week4';
proc sql; 
    title 'City Temperatures'; 
    select City, AvgHigh as AvgH format = 4.1, AvgLow as AvgL format = 4.1, AvgHigh - AvgLow as RangeC format = 4.1
    from Week4.worldtemps
    where calculated RangeC >= 38.0 and calculated RangeC <= 40.0
    order by calculated RangeC;
quit;