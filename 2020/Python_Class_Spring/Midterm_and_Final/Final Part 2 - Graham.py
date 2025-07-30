'''
Final Project
1. Load the red wine quality data set (red wine quality.csv), name the data frame as ‘wine’.
2. Use the describe() method to show the summary statistics of the data frame wine.
3. Delete the rows with missing data in the data frame wine.
4. Plot a histogram for each numeric variable, and save the figure as ‘histogram.png’.
5. Create a scatter plot with volatile_acidity and alcohol and color the code from the biggest
   quality to the smallest quality. Save the figure as ‘scatter plot.png’.
6. Define a function called ‘quality_level’ to find the level of a wine quality: if quality= 3 
   or 4, quality_level=poor; if quality= 5 or 6, quality_level=fair; if quality=7 or 8, 
   quality_level=good.
7. Use the map function to find the corresponding quality_level for the variable quality, add
   the new column called ‘quality_level’ to the data frame wine.
8. Plot pie chart for 'quality_level' with figsize=(10, 10), autopct='%1.2f%%', legend=False. 
   Save the figure as ‘quality pie chart.png’.
9. Find the correlation matrix of the numeric variables in the data frame wine, use Pandas’ 
   scatter_matrix function to visualize the correlation between variables. Save the figure as 
   ‘correlation.png’.
10. Delete all the variables whose correlation absolute value with ‘quality’ variable is less 
    than 0.15.
11. Delete the variable ‘quality_level’ from the data frame.
12. Split the data frame wine. Let Y denote the label/target quality; X denote the features 
    (all the variables except quality).
13. Split the data into 75% of training set and 25% test set with random_state=2000. 
14. Find the linear regression model using training set.
15. Print out the coefficients and intercept.
16. Use the linear regression model that you got in part 14 to find the predictive values for 
    the test data set. Calculate the R^2 and the root_mean_square_error.
17. For the linear regression model that you got in part 14, predict the quality given values 
    for your features.
18. Create a data frame to save your linear regression model, the root_mean_square_error and 
    the predicted value from part 17. Save it as ‘predict value.csv’.
'''

#1
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

wine = pd.read_csv('red wine quality.csv')
#print(wine)

#2
wine.describe()

#3
wine = wine.dropna()
#print(wine)
#print(wine.head())

#4
wine.hist(bins=30)
#plt.show()
plt.savefig('histogram.png')

#5
wine.plot.scatter(x='volatile_acidity', y='alcohol', c='quality', cmap=plt.get_cmap("jet"), \
                  colorbar=True, sharex=False)
#plt.show()
plt.savefig('scatter plot.png')

#6
def quality_level(quality):
    if quality <= 4:
        quality_level = "poor"
    elif quality <= 6:
        quality_level = "fair"
    else:
        quality_level = "good"
    return quality_level

#7
wine['quality_level'] = list(map(quality_level, wine['quality']))
#print(wine)
#print(wine.head())

#8
sumpoor = 0
sumfair = 0
sumgood = 0
for i in range(len(wine)):
    if wine['quality'][i] <= 4:
        sumpoor += 1
    elif wine['quality'][i] <= 6:
        sumfair += 1
    else:
        sumgood += 1
        
quality_labels = ['poor', 'fair', 'good']
quality_level = pd.DataFrame({'counts':[sumpoor, sumfair, sumgood]}, index = quality_labels)

quality_level.plot.pie(y="counts", figsize=(10, 10), autopct='%1.2f%%', legend=False, \
                       subplots=True)
#plt.show()
plt.savefig('quality pie chart.png')

#9
print(wine.corr())
pd.plotting.scatter_matrix(wine)
plt.savefig('correlation.png')

#10
wine = wine.drop(['fixed_acidity','residual_sugar','chlorides','free_sulfur_dioxide','pH'], \
                 axis=1)
#print(wine)
#print(wine.head())

#11
wine = wine.drop(['quality_level'], axis=1)
#print(wine)
#print(wine.head())

#12
X = wine.drop('quality', axis=1) 
y = wine['quality'] 

#13
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=2000)

#14
from sklearn.linear_model import LinearRegression
regression_model = LinearRegression()
regression_model.fit(X_train, y_train)

#15
for idx, col_name in enumerate(X_train.columns):
    print("The coefficient for {0:} is {1:.4f}".format(col_name, regression_model.coef_[idx]))
print(regression_model.intercept_)

#16
y_predict=regression_model.predict(X_test)
print(y_predict)

r_squared=regression_model.score(X_test, y_test)
print(r_squared)

from sklearn.metrics import mean_squared_error
y_predict = regression_model.predict(X_test)
regression_model_mse = mean_squared_error(y_predict, y_test)

root_mean_square_error = np.sqrt(regression_model_mse)
print(root_mean_square_error)

#17
predicted_value = regression_model.predict([[0.500, 0.10, 50.0, 0.99500, 0.60, 10.0]])
print(predicted_value)

#18
values = pd.DataFrame({'R Squared':r_squared, 'root_mean_square_error':root_mean_square_error, \
                                                'predicted value':predicted_value})
#print(values)
values.to_csv('predict value.csv') 
