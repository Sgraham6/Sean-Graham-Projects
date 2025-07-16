'''
1. Load the DC Bike Sharing data (DC bike sharing new.csv).
2. Select the columns season, holiday, atemp, windspeed, casual, cnt. Name this new data frame 
   as Bike.
3. Delete the rows with missing data in the data frame Bike.
4. Convert holiday and seasons to dummy variables.
5. Split the data Bike. Let Y denote the label/target cnt; X denote the features/predictors 
   holiday dummy variable, season dummy variable, atemp, windspeed, casual
6. Split the data into 75% of training set and 25% test set with random_state=2000. 
7. Find the linear regression model using training set
8. Print out the coefficients and intercept.
9. Use the describe() method to show the summary statistics of the numeric variables of the data
   frame Bike.
10. Plot a histogram for each numeric variable, and save the figure as ‘histogram.png’
11. Create a scatter plot with atemp and windspeed and color the code from the biggest cnt to 
    the smallest cnt. Save the figure as ‘scatter plot.png’
12. Find the correlation matrix of the numeric variables in the data frame Bike, use Pandas’ 
    scatter_matrix function to visualize the correlation between variables. Save the figure as 
    ‘correlation.png’.
13. Use the linear regression model that you got in part 7 to find the predictive values for the
    test data set. Calculate the R^2 and the adjusted R^2.
14. Find the mean square error and root_mean_square_error
15. For the linear regression model that you got in part 7, predict the cnt given (atemp =0.2, 
    windspeed=0.1, casual=25, holiday=1, season=3) and (atemp =0.3, windspeed=0.2, casual=10, 
    holiday=0, season=1).
'''

#1
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv('/Users/GrahamMacbookPro/Desktop/Second Half/Week 13/DC bike sharing new.csv')

#2
Bike = df[['season','holiday','atemp','windspeed','casual','cnt']]
# print(Bike)
# print(Bike.head())

#3
Bike = Bike.dropna()
# print(Bike)
# print(Bike.head())

#4
Bike = pd.get_dummies(Bike, columns=['holiday','season'])
# print(Bike)
# print(Bike.head())

#5
X = Bike.drop('cnt', axis=1) 
y = Bike['cnt'] 

#6
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=2000)

#7
from sklearn.linear_model import LinearRegression
regression_model = LinearRegression()
regression_model.fit(X_train, y_train)

#8
for idx, col_name in enumerate(X_train.columns):
    print("The coefficient for {0:} is {1:.4f}".format(col_name, regression_model.coef_[idx]))
print(regression_model.intercept_)

#9
Bike.describe()

#10
Bike.hist(bins=30)
plt.show()
plt.savefig('/Users/GrahamMacbookPro/Desktop/Second Half/Week 13/histogram.png')

#11
Bike.plot.scatter(x='atemp', y='windspeed', c='cnt', cmap=plt.get_cmap("jet"), \
                  colorbar=True, sharex=False)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Second Half/Week 13/scatter plot.png')

#12  
pd.plotting.scatter_matrix(Bike)
plt.savefig('/Users/GrahamMacbookPro/Desktop/Second Half/Week 13/correlation.png')

#13
y_predict=regression_model.predict(X_test)
print(y_predict)

r_squared=regression_model.score(X_test, y_test)
print(r_squared)

p=len(regression_model.coef_)
n=len(y_test)
adjusted_r_squared=r_squared-(1-r_squared)*p/(n-p-1)
print(adjusted_r_squared)

#14 
from sklearn.metrics import mean_squared_error
y_predict = regression_model.predict(X_test)
regression_model_mse = mean_squared_error(y_predict, y_test)
print(regression_model_mse)

root_mean_square_error=np.sqrt(regression_model_mse)
print(root_mean_square_error)

#15
print(regression_model.predict([[0.2, 0.1, 25, 0, 1, 0, 0, 1, 0]]))
print(regression_model.predict([[0.3, 0.2, 10, 1, 0, 1, 0, 0, 0]]))


# R Squared: 0.5133
# Adjusted R Squared: 0.5122
# Mean Square Error: 15674.2228
# Root Mean Square Error: 125.1967