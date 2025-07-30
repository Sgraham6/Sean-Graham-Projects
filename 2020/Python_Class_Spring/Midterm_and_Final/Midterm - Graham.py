#%%
'''
Problem 1. Washington D.C. Bike Sharing Dataset
1.
A) Design for loop to find the total counts (cnt) in year 2011 and 2012 respectively. 
   Create a data frame to store your answer and save your data frame as 
   ‘midterm_yourgroup#_year_sum.csv’
B) Plot the pie chart for your data frame in A) (index is year, y= Total_Counts). 
   Save your figure as ‘midterm_yourgroup#_year_sum_pie.png’
C) Plot the bar chart for your data frame in A) (x=year, y= Total_Counts). 
   Save your figure as ‘midterm_yourgroup#_year_sum_bar.png’
'''
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#A
bikes = pd.read_csv('/Users/GrahamMacbookPro/Desktop/Week 7/DC bike sharing.csv')
sum2011 = 0
sum2012 = 0
for i in range(len(bikes)):
    if bikes['yr'][i] == 0:
        sum2011 += bikes['cnt'][i]
    else:
        sum2012 += bikes['cnt'][i]
        
year_sum = pd.DataFrame({'year':[2011, 2012], 'Total_Counts':[sum2011, sum2012]})
print(year_sum)
year_sum.to_csv('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_year_sum.csv')

#B
year_sum.index = year_sum['year']
year_sum_pie = year_sum.plot.pie(y = 'Total_Counts', figsize = (5, 5))
print(year_sum_pie)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_year_sum_pie.png')

#C
year_sum_bar = year_sum.plot.bar(x = 'year', y = 'Total_Counts')
print(year_sum_bar)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_year_sum_bar.png')
#%%
'''
2.
A) Design for loop to find the total counts (cnt) in each season.
B) Design a function to convert the season variable 1, 2, 3, 4 to Spring, Summer, 
   Fall, and Winter respectively.
C) Create a data frame to store your answer and save your data frame as 
   ‘midterm_yourgroup#_season_sum.csv’
D) Plot the pie chart for your data frame in A) (index is season, y= Total_Counts). 
   Save your figure as ‘midterm_yourgroup#_season_sum_pie.png’
E) Plot the horizontal bar chart for your data frame in A) (x=season, y= Total_Counts). 
   Save your figure as ‘midterm_yourgroup#_season_sum_barh.png’
'''
#A
sumspring = 0
sumsummer = 0
sumfall = 0
sumwinter = 0
for i in range(len(bikes)):
    if bikes['season'][i] == 1:
        sumspring += bikes['cnt'][i]
    elif bikes['season'][i] == 2:
        sumsummer += bikes['cnt'][i]
    elif bikes['season'][i] == 3:
        sumfall += bikes['cnt'][i]
    else:
        sumwinter += bikes['cnt'][i]
        
#B
def converttoseason(seasonint):
    if seasonint == 1:
        season = "Spring"
    elif seasonint == 2:
        season = "Summer"
    elif seasonint == 3:
        season = "Fall"
    else:
        season = "Winter"
    return season

seasonint = bikes['season']

season = map(converttoseason, seasonint)
print(list(season))

#C
season_sum = pd.DataFrame({'season':['Spring', 'Summer', 'Fall', 'Winter'], 'Total_Counts':[sumspring, sumsummer, sumfall, sumwinter]})
print(season_sum)
season_sum.to_csv('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_season_sum.csv')

#D
season_sum.index = season_sum['season']
season_sum_pie = season_sum.plot.pie(y = 'Total_Counts', figsize = (5, 5))
print(season_sum_pie)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_season_sum_pie.png')

#E
season_sum_barh = season_sum.plot.barh(x = 'season', y = 'Total_Counts')
print(season_sum_barh)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_season_sum_barh.png')
#%%
'''
3.
A) Design for loop to find the total counts (cnt) in the four seasons in year 2011 
   and 2012 respectively.
B) Create a data frame to store your answer in and save your data frame as 
   ‘midterm_yourgroup#_season_year_sum.csv’
C) Plot the Total_Counts_2011 and Total_Counts_2012 along Season. Save your figure as 
   ‘midterm_yourgroup#_season_year_sum_plot.png’
'''
#A
sumspring2011 = 0
sumsummer2011 = 0
sumfall2011 = 0
sumwinter2011 = 0
sumspring2012 = 0
sumsummer2012 = 0
sumfall2012 = 0
sumwinter2012 = 0
for i in range(len(bikes)):
    if bikes['yr'][i] == 0:
        if bikes['season'][i] == 1:
            sumspring2011 += bikes['cnt'][i]
        elif bikes['season'][i] == 2:
            sumsummer2011 += bikes['cnt'][i]
        elif bikes['season'][i] == 3:
            sumfall2011 += bikes['cnt'][i]
        else:
            sumwinter2011 += bikes['cnt'][i]
    else:
        if bikes['season'][i] == 1:
            sumspring2012 += bikes['cnt'][i]
        elif bikes['season'][i] == 2:
            sumsummer2012 += bikes['cnt'][i]
        elif bikes['season'][i] == 3:
            sumfall2012 += bikes['cnt'][i]
        else:
            sumwinter2012 += bikes['cnt'][i]
            
#B
season_year_sum = pd.DataFrame({'Season':['Spring', 'Summer', 'Fall', 'Winter'], \
                                'Total_Counts_2011':[sumspring2011, sumsummer2011, sumfall2011, sumwinter2011], \
                                'Total_Counts_2012':[sumspring2012, sumsummer2012, sumfall2012, sumwinter2012]})
print(season_year_sum)
season_year_sum.to_csv('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_season_year_sum.csv')

#C
season_year_sum_plot = season_year_sum.plot.bar(x = 'Season', y =['Total_Counts_2011','Total_Counts_2012'])
print(season_year_sum_plot)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_season_year_sum_plot.png')
#%%
'''
Problem 2. Random Samples
1. Generate a random sample with size= 100 from a continuous uniform distribution 
   [-1, 5). And name your array as ‘midterm_yourgroup#_continuous_uniform’
2. Generate a random sample with size= 100 from a discrete uniform distribution 
   [-1, 5). And name your array as ‘midterm_yourgroup#_ discrete _uniform’
3. Generate a random sample with size= 100 from a binomial distribution with n=20, 
   p=0.3. And name your array as ‘midterm_yourgroup#_ binomial’
4. Generate a random sample with size= 100 from a normal distribution with mu=20, 
   sigma=30. And name your array as ‘midterm_yourgroup#_ normal’
5. Generate a random sample with size= 100 from a t-distribution with degree 
   freedom=10. And name your array as ‘midterm_yourgroup#_t’
6. Store the five random samples to a data frame and save it to a csv file named as 
   ‘midterm_YourGroup#_random_samples.csv’
'''
#1
midterm_Sean_Graham_continuous_uniform = np.random.uniform(-1, 5, 100) 
print(midterm_Sean_Graham_continuous_uniform)

#2
midterm_Sean_Graham_discrete_uniform = np.random.randint(-1, 5, 100) 
print(midterm_Sean_Graham_discrete_uniform)

#3
midterm_Sean_Graham_binomial = np.random.binomial(20, 0.3, 100)
print(midterm_Sean_Graham_binomial)

#4
midterm_Sean_Graham_normal = 30 * np.random.randn(100) + 20
print(midterm_Sean_Graham_normal)

#5
midterm_Sean_Graham_t = np.random.standard_t(10, 100)
print(midterm_Sean_Graham_t)

#6
index = list(range(1, 101))
random_samples = pd.DataFrame({'Continuous Uniform': midterm_Sean_Graham_continuous_uniform, \
                               'Discrete Uniform': midterm_Sean_Graham_discrete_uniform, \
                               'Binomial': midterm_Sean_Graham_binomial, \
                               'Normal': midterm_Sean_Graham_normal, \
                               'T' : midterm_Sean_Graham_t})
print(random_samples)
#print(random_samples.head())
random_samples.to_csv('/Users/GrahamMacbookPro/Desktop/Week 7/midterm_Sean Graham_random_samples.csv')