#%%%
'''
Problem 1. Washington D.C. Bike Sharing Dataset
1. For the column ‘cnt’, find the mean, median, mode, var, std and quantile(0.7), and the sum
2. Find the covariance between ‘cnt’ and ‘temp’
3. Find the correlation between ‘cnt’ and ‘windspeed’
4. Find the correlation between ‘cnt’ and ‘registered’
'''
#1
import pandas as pd
df = pd.read_csv('/Users/GrahamMacbookPro/Desktop/Week 8/DC bike sharing.csv')

df['cnt'].mean()
df['cnt'].median()
df['cnt'].mode()
df['cnt'].var()
df['cnt'].std()
df['cnt'].quantile(0.7)
df['cnt'].sum()
# print(df['cnt'].mean())
# print(df['cnt'].median())
# print(df['cnt'].mode())
# print(df['cnt'].var())
# print(df['cnt'].std())
# print(df['cnt'].quantile(0.7))
# print(df['cnt'].sum())

#2
df.cnt.cov(df.temp)
# print(df.cnt.cov(df.temp))

#3
df.cnt.corr(df.windspeed)
# print(df.cnt.corr(df.windspeed))

#4
df.cnt.corr(df.registered)
# print(df.cnt.corr(df.registered))