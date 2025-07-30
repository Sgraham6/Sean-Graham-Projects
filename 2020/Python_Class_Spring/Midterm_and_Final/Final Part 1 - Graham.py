#%%

# Preliminary Code
import pandas as pd
import numpy as np

df = pd.read_csv('auto-mpg.csv')

df = df[['mpg','cylinders','displacement','weight','acceleration','model year']]
df
#%%

# Linear Regression
X = df.drop('mpg', axis=1) 
y = df['mpg'] 

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20, random_state=100)

from sklearn.linear_model import LinearRegression
regression_model = LinearRegression()
regression_model.fit(X_train, y_train)

for idx, col_name in enumerate(X_train.columns):
    print("The coefficient for {0:} is {1:.4f}".format(col_name, regression_model.coef_[idx]))
#%%

# R Squared, Adjusted R Squared, Root Mean Squared Error
r_squared=regression_model.score(X_test, y_test)
p=len(regression_model.coef_)
n=len(y_test)
adjusted_r_squared=r_squared-(1-r_squared)*p/(n-p-1)
print(adjusted_r_squared)

from sklearn.metrics import mean_squared_error
y_predict = regression_model.predict(X_test)
regression_model_mse = mean_squared_error(y_predict, y_test)

root_mean_square_error = np.sqrt(regression_model_mse)
print(root_mean_square_error)
#%%

# Scatter Plots
plot = df.plot.scatter(x='cylinders', y='mpg', c='r', marker='o', label='cylinders')
plot = df.plot.scatter(x='displacement', y='mpg', c='orange', marker='o', label='displacement')
plot = df.plot.scatter(x='weight', y='mpg', c='y', marker='o', label='weight')
plot = df.plot.scatter(x='acceleration', y='mpg', c='g', marker='o', label='acceleration')
plot = df.plot.scatter(x='model year', y='mpg', c='b', marker='o', label='model year')
#%%

# Correlation Matrix
df.corr() 
