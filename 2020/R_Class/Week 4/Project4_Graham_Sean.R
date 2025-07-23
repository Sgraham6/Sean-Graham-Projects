library(readxl)
loan <- read_excel("loan.xlsx")
View(loan)

#2 Determine which columns are numerical values and which are factors
is.numeric(loan$id)
is.numeric(loan$loan_amnt)
is.numeric(loan$int_rate)
is.numeric(loan$installment)
is.numeric(loan$annual_inc)

loan$term <- as.factor(loan$term)
loan$grade <- as.factor(loan$grade)
loan$emp_length <- as.factor(loan$emp_length)
loan$home_ownership <- as.factor(loan$home_ownership)
loan$verification_status <- as.factor(loan$verification_status)
loan$loan_status <- as.factor(loan$loan_status)

is.factor(loan$term)
is.factor(loan$grade)
is.factor(loan$emp_length)
is.factor(loan$home_ownership)
is.factor(loan$verification_status)
is.factor(loan$loan_status)

#3 Calculate min, max, mean, median, sd, and three quantiles of loan_amnt
min(loan$loan_amnt)
max(loan$loan_amnt)
mean(loan$loan_amnt)
median(loan$loan_amnt)
sd(loan$loan_amnt)
quantile(loan$loan_amnt, probs = c(0.25, 0.5, 0.75))

#4 Calculate min, max, mean, median, sd, and three quantiles of loan_amnt
min(loan$int_rate)
max(loan$int_rate)
mean(loan$int_rate)
median(loan$int_rate)
sd(loan$int_rate)
quantile(loan$int_rate, probs = c(0.25, 0.5, 0.75))

#5 Calculate correlation coefficient of int_rate and installment
cor(loan$int_rate, loan$installment)

#6 Calculate frequency table and mode of term
table(loan$term)
names(sort(-table(loan$term)))[1]

#7 Calculate proportion table and mode of loan_status
prop.table(table(loan$loan_status))
names(sort(-prop.table(table(loan$loan_status))))[1]

#8 Calculate cross table of term and loan_status, produce propotions by row and column
xtabs(~ term + loan_status, data = loan)
xtab.term.loan_status <- xtabs(~ term + loan_status, data = loan)
prop.table(xtab.term.loan_status, margin = 1)
prop.table(xtab.term.loan_status, margin = 2)

#9 Summarize all variables in one command
summary(loan)