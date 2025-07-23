library(readxl)
loan <- read_excel("loan (2).xlsx")
View(loan)

#2 Plot the histogram and density of loan_amnt
hist(loan$loan_amnt,
     main = "Histogram and Density Plots of Loan Amounts",
     prob = TRUE, xlab = "Loan Amounts", ylab = "Probability")
lines(density(loan$loan_amnt),
      lwd = 1, col = "red")

#3 Make scatter plot of loan_amnt on y axis and annual_inc on x axis, add trendline
plot(loan$annual_inc, loan$loan_amnt,
     main = "Scatter Plot of Annual Income and Loan Amount",
     xlab = "Annual Income", ylab = "Loan Amount")
abline(lm(loan_amnt~annual_inc, data = loan),
       lwd = 1, col = "red")

#4 Make the barplot of term and grade on the same barplot
tbl.term <- xtabs(~ term + grade, data = loan)
barplot(tbl.term, main = "Barplot of Term and Grade", 
        col=c("green","blue"),
        legend = rownames(tbl.term), beside = TRUE)

#5 Plot loan_amnt on the y axis agianst term on the x axis using a dotchart
terms <- as.factor(loan$term)
my.cols <- c("green","blue")  
dotchart(loan$loan_amnt,
         groups = terms, gcolor = my.cols, color = my.cols[terms], 
         cex = 0.1, pch = 19, xlab = "Loan Amount")

#6 Make a boxplot with loan_amnt on the y axis, term on the x axis, and save the
# grpah in a file as loanterm.jpg
jpeg("C:\\Users\\srgra\\OneDrive\\Documents\\loanterm.jpg")
boxplot(loan_amnt ~ term, data = loan, notch = TRUE, col=c("green"),
   main="Loan Amounts by Term", xlab = "Term", ylab = "Loan Amount")
dev.off()
