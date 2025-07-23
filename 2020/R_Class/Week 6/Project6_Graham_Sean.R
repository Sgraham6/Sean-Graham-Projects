library(readxl)
loan <- read_excel("loan.xlsx")
View(loan)

#2 Plot the histogram and density of loan_amnt and add mean line using ggplot2
library(ggplot2)
ggplot(data = loan, aes(x=loan_amnt))+
  geom_histogram(aes(y=..density..), color="black", fill="white")+
  geom_density(alpha=.2, color="red", size=1)+
  geom_vline(aes(xintercept=mean(loan_amnt)), color="blue", size=1)

#3 Make a scatterplot with loan_amnt on y axis and annual_inc on x axis and add
# trendline using ggplot2
ggplot(data = loan, aes(x=annual_inc, y=loan_amnt))+geom_point()+geom_smooth()

#4 Generate the barplot of both term and grade using ggplot2
ggplot(data = loan, aes(x=grade, y=..count..))+geom_bar(aes(fill = term))

#5 Generate the dotplot of loan_amnt against Grade using ggplot2
ggplot(data = loan, aes(x = grade, y = loan_amnt))+
  geom_dotplot(aes(fill=grade), binaxis = "y", binwidth = 1, stackdir = "center")

#6 Generate a boxplot of loan_amnt on y axis and term on x axis and save in a
# file "loanterm.jpg" using ggplot2
ggplot(data=loan, aes(x=term, y=loan_amnt))+
  geom_boxplot(aes(col=term), notch = TRUE)
ggsave("C:\\Users\\srgra\\OneDrive\\Documents\\loanterm.jpg",
       width = 16, height = 12, units = "cm")