#%%
'''
Problem 1. 
1.  Use the random number generator seed 2345 to generate a data set with 
    size = (500,2) from a normal distribution with mean 8 and variance 9.
2.	Use ttest_1samp to test whether the means of the two data sets are 8 
    and 4 respectively. What are the statistic values? What are the p-values? 
    What are your conclusions?
'''
#1
import  numpy as np
import pandas as pd
from scipy import stats

np.random.seed(2345)
data = 3 * np.random.randn(500, 2) + 8
# print(data)

#2
stats.ttest_1samp(data,[8.0,4.0])
# The first null hypothesis is that the mean of the first column is 8. The 
# statistic value is 0.91 and the p-value is 0.36. The p-value is greater than 
# 0.05, so we fail to reject the null hypothesis; the mean is 8. The second 
# null hypothesis is that the mean of the second column is 4. The statistic 
# value is 32.51 and the p-value is 2.57e-125. The p-value is less than 0.05, 
# so we reject the null hypothesis; the mean is not 4.
#%%
'''
Problem 2. 
1.  Use the random number generator seed 789 to generate two random variables 
    (called a and b) with size =100 from a normal distribution with mean 4 and 
    variance 4.
2.	Do test_ind to test whether the population means of a and b are different 
    assuming the two variances equal. What is the statistic value? What is 
    the p-value? What is your conclusion?
3.  Do test_ind to test whether the means of a and b are different assuming 
    the two variances are not equal. What is the statistic value? What is the 
    p-value? What is your conclusion?
4.  Use the random number generator seed 5678 to generate a random variable 
    (called c) with size =160 from a normal distribution with mean 2 and 
    variance 4.
5.  Do test_ind to test whether the means of a and c are different assuming 
    the two variances equal. What is the statistic value? What is the p-value? 
    What is your conclusion?
'''
#1
np.random.seed(789)
a = 2 * np.random.randn(100) + 4
b = 2 * np.random.randn(100) + 4
# print(a)
# print(b)

#2
stats.ttest_ind(a, b)
# The null hypothesis is that the means are equal. The statistic value is 0.41 
# and the p-value is 0.68. The p-value is greater than 0.05, so we fail to 
# reject the null hypothesis; the means are equal.

#3
stats.ttest_ind(a, b, equal_var = False)
# The null hypothesis is that the means are equal. The statistic value is 0.41 
# and the p-value is 0.68. The p-value is greater than 0.05, so we fail to 
# reject the null hypothesis; the means are equal.

#4
np.random.seed(5678)
c = 2 * np.random.randn(160) + 2
# print(c)

#5
stats.ttest_ind(a, c)
# The null hypothesis is that the means are equal. The statistic value is 8.60 
# and the p-value is 7.76e-16. The p-value is less than 0.05, so we reject the
# null hypothesis; the means are not equal.
#%%
'''
Problem 3. 
The extend to which an infant’s health is affected by parental smoking is an 
important public health concern. The following data are the urinary 
concentrations of cotinine (a metabolite of nicotine); measurements were taken
both from a sample of infants who had been exposed to household smoke and 
from a sample of unexposed infants.
 
Unexposed: 	8  	11 	12	14  20	
Exposed:    	35 	56	83 	92  40

Use ttest_ind to test H0: μ_1=μ_2 against H1: μ_1!=μ_2 at α=0.05 without the 
assumption of equal variances. 
1)	What is the statistic value? 
2)	What is the p-value? 
3)	What is your conclusion?
'''
#Problem 3
data = pd.DataFrame({'Unexposed':[8, 11, 12, 14, 20], \
                     'Exposed':[35, 56, 83, 92, 40]})
stats.ttest_ind(data['Unexposed'], data['Exposed'], equal_var = False)
# 1. The statistic value is -4.17
# 2. The p-value is 0.01
# 3. The null hypothesis is that the means are equal, and the alternate 
#    hypothesis is that they are not. The p-value is less than 0.05, so we 
#    reject the null hypothesis and fail to reject the alternate hypothesis;
#    the means are not equal.
#%%
'''
Problem 4.  
Use ttest_rel to test whether the scores on two quizzes different at the 
significance level α = .05.

Quiz 1: 	98  100 95  90  90	92  80	78  88
Quiz 2: 94  98  98  88  89  91  84  80  88

1)	What is the statistic value? 
2)	What is the p-value? 
3)	What is your conclusion?
'''
data = pd.DataFrame({'Quiz 1':[98, 100, 95, 90, 90, 92, 80, 78, 88], \
                     'Quiz 2':[94, 98, 98, 88, 89, 91, 84, 80, 88]})
stats.ttest_rel(data['Quiz 1'], data['Quiz 2'])
# 1. The statistic value is 0.13
# 2. The p-value is 0.90
# 3. The null hypothesis is that the means are equal. The p-value is greater 
#    than 0.05, so we fail to reject the null hypothesis; the means are equal.