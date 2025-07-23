#%%
'''
Problem 1
1. Generate a data set with size =1000 from a normal distribution with mean 2 and 
   variance 9.
2. Plot the histogram of the data set with 50 bins. Based on the histogram, do you 
   think the data set follows a normal distribution or not?
3. Use the Q-Q plot to check the normality of the data set.
4. Use Shapiro-Wilk Test, D’Agostino’s K^2 Test (normaltest), and Anderson-Darling 
   Test respectively to check the normality of the data set.
'''
#1
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats  
from statsmodels.graphics.gofplots import qqplot

data = 3 * np.random.randn(1000) + 2
# print(data)

#2
plt.hist(data, bins=50)
plt.show
# The data seems to be normal

#3
qqplot(data, line='s')
plt.show()

#4
#Shapiro Wilk Test
stat, p = stats.shapiro(data)
print('Statistics={0:.3f}, p={1:.3f}'.format(stat, p)) 
#D'Agostino's K^2 Test
stat2, p2 = stats.normaltest(data)
print('Statistics={0:.3f}, p={1:.3f}'.format(stat2, p2)) 
#Anderson Darling Test
result = stats.anderson(data)
print(result)
#%%
'''
Problem 2.
1. Generate a data set with size =100 from a t-distribution with degree freedom=10.
2. Plot the histogram of the data set with 50 bins. Based on the histogram, do you 
   think the data set follows a normal distribution or not?
3. Use the Q-Q plot to check the normality of the data set.
4. Use Shapiro-Wilk Test, D’Agostino’s K^2 Test (normaltest), and Anderson-Darling 
   Test respectively to check the normality of the data set.
'''
#1
data = np.random.standard_t(10, size=(100))
# print(data)

#2
plt.hist(data, bins=50)
plt.show
# The data seems to be normal

#3
qqplot(data, line='s')
plt.show()

#4
#Shapiro Wilk Test
stat, p = stats.shapiro(data)
print('Statistics={0:.3f}, p={1:.3f}'.format(stat, p)) 
#D'Agostino's K^2 Test
stat2, p2 = stats.normaltest(data)
print('Statistics={0:.3f}, p={1:.3f}'.format(stat2, p2)) 
#Anderson Darling Test
result = stats.anderson(data)
print(result)
#%%
'''
Problem 3
1. Read data 'DC bike sharing.csv'
2. For the variables ‘casual’, ‘cnt’ and ‘windspeed’, use the following methods to 
   test their normality respectively:
    a) Plot the histogram of the data set with 50 bins. Based on the histogram, do 
       you think the data set follows a normal distribution or not?
    b) Use the Q-Q plot to check the normality of the data set.
    c) Use Shapiro-Wilk Test, D’Agostino’s K^2 Test (normaltest), and Anderson-Darling
       Test respectively to check the normality of the data set.
'''
#1
bikes = pd.read_csv('/Users/GrahamMacbookPro/Desktop/Week 10/DC bike sharing.csv')

#2 casual
#A
plt.hist(bikes['casual'], bins=50)
plt.show
# No, it's not normal

#B
qqplot(bikes['casual'], line='s')
plt.show()

#C
#Shapiro Wilk Test
stat, p = stats.shapiro(bikes['casual'])
print('Statistics={0:.3f}, p={1:.3f}'.format(stat, p)) 
#D'Agostino's K^2 Test
stat2, p2 = stats.normaltest(bikes['casual'])
print('Statistics={0:.3f}, p={1:.3f}'.format(stat2, p2)) 
#Anderson Darling Test
result = stats.anderson(bikes['casual'])
print(result)

#2 cnt
#A
plt.hist(bikes['cnt'], bins=50)
plt.show
# No, it's not normal

#B
qqplot(bikes['cnt'], line='s')
plt.show()

#C
#Shapiro Wilk Test
stat, p = stats.shapiro(bikes['cnt'])
print('Statistics={0:.3f}, p={1:.3f}'.format(stat, p)) 
#D'Agostino's K^2 Test
stat2, p2 = stats.normaltest(bikes['cnt'])
print('Statistics={0:.3f}, p={1:.3f}'.format(stat2, p2)) 
#Anderson Darling Test
result = stats.anderson(bikes['cnt'])
print(result)

#2 windspeed
#A
plt.hist(bikes['windspeed'], bins=50)
plt.show
# No, it's not normal

#B
qqplot(bikes['windspeed'], line='s')
plt.show()

#C
#Shapiro Wilk Test
stat, p = stats.shapiro(bikes['windspeed'])
print('Statistics={0:.3f}, p={1:.3f}'.format(stat, p)) 
#D'Agostino's K^2 Test
stat2, p2 = stats.normaltest(bikes['windspeed'])
print('Statistics={0:.3f}, p={1:.3f}'.format(stat2, p2)) 
#Anderson Darling Test
result = stats.anderson(bikes['windspeed'])
print(result)