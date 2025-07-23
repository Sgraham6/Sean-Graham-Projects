#%%
'''
Problem 1. Let home_town=’my hometown is’+ ‘ my_home_town_name’
1. Find the length of the string home_town
2. Generate the uppercase of the string hometown and rename it as HOME_TOWN
3. Is home_town equal to HOME_TOWN?
4. Replace ‘MY’ in HOMETOWN by ‘your name’
5. Split HOMETOWN by space ‘ ‘
'''

home_town = 'my hometown is' + ' my_home_town_name'
print(home_town)
# 1
a = len(home_town)
print(a)
# 2
HOME_TOWN = home_town.upper()
print(HOME_TOWN)
# 3
"home_town" == "HOME_TOWN"
# 4
HOME_TOWN = HOME_TOWN.replace("MY", "Sean")
print(HOME_TOWN)
# 5
HOME_TOWN.split(" ")
#%%
'''
Problem 2. Go to the website
https://realestate.usnews.com/real-estate/slideshows/25-best-places-to- live-in-the-us?slide=22
1. let top15=['Austin', 'Colorado Springs', 'Denver', 'Des Moines', 'Fayetteville']
2. Find the other 10 cities for the website above and put them in a list called 'top6_15'
3. Extend the list top15 to have 15 cities
3. Remove the 12th city from the top15
4. Insert "your home town" as the 10th city
6. Reverse the list top15
7. Sort the list top15
8. Find the length of the list top15
'''
# 1
top15 = ['Austin','Colorado Springs','Denver','Des Moines','Fayetteville']
print(top15)
# 2
top6_15 = ['Minneapolis-St. Paul','San Francisco','Portland','Seattle','Raleigh and Durham','Huntsville', \
           'Madison','Grand Rapids','San Jose','Nashville']
print(top6_15)
# 3
top15.extend(top6_15)
print(top15)
# 4
del top15[11]
print(top15)
# 5
top15.insert(9, "St. Charles")
print(top15)
# 6
top15.reverse()
print(top15)
# 7
top15.sort()
print(top15)
# 8
len(top15)
print(len(top15))