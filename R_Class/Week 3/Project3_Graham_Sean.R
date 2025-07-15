library(readxl)
BlackFriday_xlsx <- read_excel("C:/Users/srgra/AppData/Local/Packages/Microsoft.MicrosoftEdge_8wekyb3d8bbwe/TempState/Downloads/BlackFriday (1).xlsx")
View(BlackFriday_xlsx)

#2 Find average purchase amount using for loop
sum <- 0
for (idx in c(1:nrow(BlackFriday_xlsx))){
  sum <- sum + BlackFriday_xlsx[idx, "Purchase"]
}
avg <- sum/nrow(BlackFriday_xlsx)
print(avg)

#3 Find average purchase amount using while loop
sum <- 0
idx <- 1
while (idx <= nrow(BlackFriday_xlsx)){
  sum <- sum + BlackFriday_xlsx[idx, "Purchase"]
  idx <- idx + 1
}
avg <- sum/nrow(BlackFriday_xlsx)
print(avg)

#4 Find average purchase amount using repeat loop
sum <- 0
idx <- 1
repeat{
  sum <- sum + BlackFriday_xlsx[idx, "Purchase"]
  idx <- idx + 1
  if (idx > nrow(BlackFriday_xlsx)){
    break
  }
}
avg <- sum/nrow(BlackFriday_xlsx)
print(avg)

#5 Find average purchase amount for female shoppers using for loop
sumF <- 0
countF <- 0
for (idx in c(1:nrow(BlackFriday_xlsx))){
  if (BlackFriday_xlsx[idx, "Gender"] == 'F'){
    sumF <- sumF + BlackFriday_xlsx[idx, "Purchase"]
    countF <- countF +1
  }
}
avg <- sumF/countF
print(avg)

#6 Find average purchase amount for female shoppers using while loop
sumF <- 0
countF <- 0
idx <- 1
while (idx <= nrow(BlackFriday_xlsx)){
  if (BlackFriday_xlsx[idx, "Gender"] == 'F'){
    sumF <- sumF + BlackFriday_xlsx[idx, "Purchase"]
    countF <- countF + 1
  }
  idx <- idx + 1
}
avg <- sumF/countF
print(avg)

#7 Find average purchase amount for female shoppers using repeat loop
sumF <- 0
countF <- 0
idx <- 1
repeat{
  if (idx > nrow(BlackFriday_xlsx)){
    break
  }
  if(BlackFriday_xlsx[idx, "Gender"] == 'F'){
    sumF <- sumF + BlackFriday_xlsx[idx, "Purchase"]
    countF <- countF + 1
  }
  idx <- idx + 1
}
avg <- sumF/countF
print(avg)

#8 Find the difference between average purchase amounts for males and females
sumF <- 0
countF <- 0
sumM <- 0
countM <- 0
for (idx in c(1:nrow(BlackFriday_xlsx))){
  if (BlackFriday_xlsx[idx, "Gender"] == 'M'){
    sumM <- sumM + BlackFriday_xlsx[idx, "Purchase"]
    countM <- countM +1
  } else{
    sumF <- sumF + BlackFriday_xlsx[idx, "Purchase"]
    countF <- countF + 1
  }
}
difference <- sumM/countM - sumF/countF
print(difference)