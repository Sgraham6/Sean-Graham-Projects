library(readxl)
SP500 <- read_excel("SP500 (1).xls", sheet = "Data")
View(SP500)
#2  # of rows and columns
nrow(SP500)
ncol(SP500)
#3  Select columns SP500, CPI, and Rate
SP500[,c("SP500","CPI","Rate")]
#4  Select rows 10, 100, 500, 1500
SP500[c(10, 100, 500, 1500),]
#5  Select observations SP500 > 2000 or CPI < 100
step5 <- SP500[(SP500$SP500 > 2000) | (SP500$CPI < 100),]
print(step5)
#6  Select data Earnings > 50 and Rate < 3, show columns SP500 and Dividend
step6 <- subset(SP500, (Earnings > 50) & (Rate < 3), select = c(SP500, Dividend))
print(step6)
#7  Remove column Rate
SP500$Rate <- NULL
print(SP500)
#8  Add RealPrice column based on SP500*CPI/CPI(2018.09)
LatestCPI <- SP500[nrow(SP500), c("CPI")]
SP500$RealPrice <- (SP500$SP500)*(SP500$CPI)/(LatestCPI$CPI)
print(SP500)
#9  Add RealEarnings column based on Earnings*CPI/CPI(2018.09)
SP500$RealEarnings <- (SP500$Earnings)*(SP500$CPI)/(LatestCPI$CPI)
print(SP500)
#10 Add PERatio column based on RealPrice/RealEarnings
SP500$PERatio <- (SP500$RealPrice)/(SP500$RealEarnings)
print(SP500)