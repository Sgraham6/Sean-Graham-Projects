#%%
'''
Problem 1
1. Define a function which has multiple parameters with one default parameter value and returns multiple values.
2. Call the function to calculate the return values for the given arguments
'''
def prob_one(x, y, z=2):
    return x+y-4, z*y-7
answer = prob_one(2, 4)
print(answer)
#output: (2, 1)
#%%
'''
Problem 2
1. Define a function with a function parameter
2. Call the function to calculate the return values for the given arguments
'''
def prob_two(x, func):
    return func(x)
def prob_two_func(x):
    return (2*x+6)
answer = prob_two(3, prob_two_func)
print(answer)
#output: 12
#%%
'''
Problem 3
1. Create a lambda function with multiple parameters.
2. Call the function to calculate the return values for the given arguments
'''
prob_three = lambda x, y, z : x / y + z
print(prob_three(8, 2, 3))
#output: 7.0
#%%
'''
Probelm 4
1. Create a function with a lambda function parameter
2. Call the function to calculate the return values for the given arguments
'''
def prob_four(x, func):
    return func(x)
prob_four_func = prob_four(5, lambda x: x * x / 4)
print(prob_four_func)
#output: 6.25