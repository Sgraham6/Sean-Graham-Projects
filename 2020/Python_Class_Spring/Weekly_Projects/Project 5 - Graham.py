#%%
'''
Problem 1. Grade Calculation
1. Generate 600 random scores for attendance, project, midterm and final respectively.
2. Define a function named as 'lettergrade' to convert a numerical grade to a letter grade.
3. Use the map function to find the grades for the total scores.
4. Create a data frame called grade which has six columns: attendance, project, midterm, final, total_score and grade.
5. Plot the histogram of the grade and save the figure as ‘project 5_your group_grade #.png’. 
6. Save the data frame grade to ' project 5_your group #_grade.csv'.
'''
#1
import numpy as np
attendance = np.random.randint(0, 41, 600)
print(attendance)
project = np.random.randint(0, 201, 600)
print(project)
midterm = np.random.randint(0, 101, 600)
print(midterm)
final = np.random.randint(0, 201, 600)
print(final)

#2
def lettergrade(numericalgrade):
    if numericalgrade >= 90:
        grade = "A"
    elif numericalgrade >= 80:
        grade = "B"
    elif numericalgrade >= 70:
        grade = "C"
    elif numericalgrade >= 60:
        grade = "D"
    else:
        grade = "F"
    return grade

#3
score = (attendance + project + midterm + final)/5.4
grade = map(lettergrade, score)
print(list(grade))

#4
import pandas as pd
grade = map(lettergrade, score)
index = list(range(1, 601))
grade = pd.DataFrame({'attendance': attendance, 'project': project, 'midterm': midterm, 'final': final,\
                     'total_score': score, 'grade': grade}, index = index)
print(grade)
#print(grade.head())

#5
grade_hist = grade['grade'].value_counts().plot.bar()
print(grade_hist)
import matplotlib.pyplot as plt 
plt.savefig('Project5_Sean Graham_grade.png')

#6
grade.to_csv('Project5_Sean Graham_grade.csv') 
#%%
'''
Problem 2. Loops
1. Use While Loop to add third power of all the even numbers from 1 to 200.
2. Use For Loop to multiply all the even numbers from 1 to 50.
3. Design nested loops to multiply all the numbers 1*(1*2)*(1*2*3) *...* (1*2*..*30).
'''
#1
i = 2
sum = 0  
while i <= 200:
    sum = sum + i*i*i 
    i += 2
print(sum)
# Result: 204020000

#2
product = 1
for i in range (2, 52, 2):
    product = product * i
print(product)
# Result: 520469842636666622693081088000000

#3
product = 1
for i in range (1, 31):
    for j in range (1, i+1):
        product = product * j
print(product)
# Result: 571755698232823096732988919122641191801693387811183323217432917650763212540-
# 08144131396872292078960659959192198325482132911362592729947392123616011917207641789-
# 59379007338740053201829672281938698507634634093465979526859113904220996903489507321-
# 25043950467569305395462894650595613155829702577724817000254015466341008537985769810-
# 16576000000000000000000000000000000000000000000000000000000000000000000000000000000-
# 000000000
#%%
'''
Problem 3. Use Loops to Calculate Grades
1. Generate 600 random scores for attendance, project, midterm and final respectively.
2. Use loops to calculate the grades.
'''
#1
import numpy as np
attendance = np.random.randint(0, 41, 600)
print(attendance)
project = np.random.randint(0, 201, 600)
print(project)
midterm = np.random.randint(0, 101, 600)
print(midterm)
final = np.random.randint(0, 201, 600)
print(final)

#2
letter = list()
import numpy as np
score = (attendance + project + midterm + final)/5.4
for i in score:
    if i >= 90:
        grade = "A"
    elif i >= 80:
        grade = "B"
    elif i >= 70:
        grade = "C"
    elif i >= 60:
        grade = "D"
    else:
        grade = "F"
    letter.append(grade)
print(letter)
