#%%
'''
Problem 1. Create a table to satisfy the following conditions:
1. shape (4, 5)
2. Column and Index Names
3. Save the table as ‘yourname.csv’
'''

import pandas as pd

data={'Store':['Target','WalMart','Dierbergs','Schnucks'],
      'Employees':['1000','2000','1500','1000'],
      'Customers':['20000','15000','10000','30000'],
      'Products':['50','70','40','60'],
      'Locations':['60','40','60','50']}
df = pd.DataFrame(data, columns = ['Store','Employees','Customers','Products','Locations'], index =['Store 1','Store 2','Store 3','Store 4'])
df.to_csv('Graham.csv')

print(df)
#%%
'''
Problem 2. Go to the Modules in Canvas to download the data either ‘mtcars.csv’ or ‘mtcars.xlsx’ and load the data to Spyder
1. Find the shape of the data frame.
2. Drop column 3.
3. Select the cell (row3, column5)
4. Sort the data frame by 'Brand' and 'cly'
5. Rank the 'hp'
6. Find the mean of mpg
7. Select the three columns 'Brand', ‘mpg’ and 'cly', and save your new data to an excel file named ‘mtcars_yournameinitials.xlsx’
8. Find the names of all columns
'''
cars = pd.read_excel('/Users/GrahamMacbookPro/Desktop/Week 1/mtcars.xlsx')
print(cars)
#   1
a = cars.shape
print(a)
#   2
cars = cars.drop(['disp'], axis = 1)
print(cars.head())
#   3
a = cars.iloc[[2],[4]]
print(a)
#   4
cars = cars.sort_values(by=['Brand','cyl'])
print(cars.head())
#   5
cars = cars.sort_values('hp', ascending=1)
print(cars.head())
#   6
my_mean = cars['mpg'].mean()
print(my_mean)
#   7
cars_columns=cars.loc[:, ['Brand', 'mpg','cyl']]
cars_columns.to_excel('mtcars_SG.xlsx')
print(cars_columns)
#   8
a = cars.columns
print(a)