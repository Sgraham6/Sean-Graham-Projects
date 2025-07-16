#%%
'''
Problem 1.
1. Generate a data set (spread) with size =5000 from a normal distribution with mean 200 and variance 900.
2. Generate a data set (center) with size =500 with value of 200.
3. Generate a data set (flier_high) with size =100 from a normal distribution with mean 300 and variance 900.
4. Generate a data set (flier_low) with size =100 from a normal distribution with mean 100 and variance 900.
5. Concatenate the four arrays (spread, center, flier_high, flier_high, flier_low) to a new data set called 'data'.
6. Draw the basic boxplot for 'data'.
7. Draw the histogram of the data.
'''
#1
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

spread = 30 * np.random.randn(5000) + 200
# print(spread)

#2
center = np.ones(500) * 200
# print(center)

#3
flier_high = 30 * np.random.randn(100) + 300
# print(flier_high)

#4
flier_low = 30 * np.random.randn(100) + 100
# print(flier_low)

#5
data = np.concatenate((spread, center, flier_high, flier_low), 0)
# print(data)

#6
plt.boxplot(data)
plt.show()

#7
plt.hist(data, bins=30)
plt.show()
#%%
'''
Problem 2.
1. Read data 'DC bike sharing.csv'
2. Draw the basic boxplot for the 'atemp'
3. Plot the histogram of 'registered' with bins=40
4. Plot the histogram of 'weathersit'
'''
#1
df = pd.read_csv('/Users/GrahamMacbookPro/Desktop/Week 9/DC bike sharing.csv')

#2
plt.boxplot(df['atemp'])
plt.show()

#3
plt.hist(df['registered'], bins=40)
plt.show()

#4
plt.hist(df['weathersit'], bins=6)
plt.show()