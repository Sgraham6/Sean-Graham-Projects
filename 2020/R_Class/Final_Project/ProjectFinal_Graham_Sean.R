library(readxl)
pmsm_temperature_data <- read_excel("pmsm_temperature_data.xlsx")
View(pmsm_temperature_data)

#2. Of the predictors Ambient, Coolant, u_d, u_q, motor_speed, Torque,
#   stator_yoke, and stator_winding, find the categorical variable and
#   convert it to a factor
pmsm_temperature_data$stator_yoke <- as.factor(pmsm_temperature_data$stator_yoke)
print(is.factor(pmsm_temperature_data$stator_yoke))

#3. Calcualte the maximum, minimum, mean, median, standard deviation, and
#   three quartiles of Pm
pmsm_temperature_data <- na.omit(pmsm_temperature_data)
min(pmsm_temperature_data$pm)
max(pmsm_temperature_data$pm)
mean(pmsm_temperature_data$pm)
median(pmsm_temperature_data$pm)
sd(pmsm_temperature_data$pm)
quantile(pmsm_temperature_data$pm, probs = c(0.25, 0.5, 0.75))

#4. Calcualte the maximum, minimum, mean, median, standard deviation, and
#   three quartiles of motor_speed
min(pmsm_temperature_data$motor_speed)
max(pmsm_temperature_data$motor_speed)
mean(pmsm_temperature_data$motor_speed)
median(pmsm_temperature_data$motor_speed)
sd(pmsm_temperature_data$motor_speed)
quantile(pmsm_temperature_data$motor_speed, probs = c(0.25, 0.5, 0.75))

#5. Calculate the correlation coefficient of motor_speed and Pm
cor(pmsm_temperature_data$motor_speed, pmsm_temperature_data$pm)

#6. Calculate the frequency table of stator_yoke and find the mode of
#   the stator yoke variable
levels(pmsm_temperature_data$stator_yoke)
names(sort(-table(pmsm_temperature_data$stator_yoke)))[1]

#7. Plot the histogram and density of Pm and add a vertical line denoting
#   the mean using ggplot2
library(ggplot2)
ggplot(data = pmsm_temperature_data, aes(x = pm)) +
  geom_histogram(aes(y = ..density..), color = "black", fill = "white") +
  geom_density(alpha = .2, color = "red", size = 1) +
  geom_vline(aes(xintercept = mean(pm)), color = "blue", size = 1)

#8. Maxe a scatter plot with Pm on the y axis and motor_speed on the x
#   axis and add a trendline with ggplot2
ggplot(data = pmsm_temperature_data, 
       aes(x = motor_speed, y = pm)) + geom_point() + geom_smooth()

#9. Make a boxplot with Pm on the y axis and stator_yoke on the x axis
#   and save in a file as pmyoke.jpg using ggplot2
ggplot(data = pmsm_temperature_data, aes(x = stator_yoke, y = pm)) +
       geom_boxplot(aes(col = stator_yoke), notch = TRUE)
ggsave("pmyoke.jpg",
       width = 16, height = 12, units = "cm")

#10a. Perform multiple linear regression with Pm as the resonse and
#     with Ambient, Coolant, motor_speed, and Torque as the predictors
lm.result <- lm(pm ~ ambient + coolant + motor_speed + torque,
                data = pmsm_temperature_data)
summary(lm.result)$coefficients
summary(lm.result)$adj.r.squared

#10b. Perform multiple linear regression with Pm as the resonse and
#     with Ambient, Coolant, u_d, motor_speed, Torque, and stator_winding
#     as the predictors 
lm.result2 <- lm(pm ~ ambient + coolant + u_d + motor_speed + torque
                 + stator_winding, data = pmsm_temperature_data)
summary(lm.result2)$coefficients
summary(lm.result2)$adj.r.squared

#10c. Perform multiple linear regression with Pm as the resonse and
#     with Ambient, Coolant, u_d, u_q, motor_speed, Torque, stator_yoke,
#     and stator_winding as the predictors 
lm.result3 <- lm(pm ~ ambient + coolant + u_d + u_q + motor_speed + 
                 torque + stator_yoke + stator_winding, 
                 data = pmsm_temperature_data)
summary(lm.result3)$coefficients
summary(lm.result3)$adj.r.squared

#11b. Forecast stator_yoke uning Pm, Ambient, and Coolant
library(class)
pmsm_temperature_data$stator_yoke <- as.factor(pmsm_temperature_data$stator_yoke)

# Establish predictors and target
predictors <- c("pm", "ambient", "coolant")
data.predictors <- pmsm_temperature_data[predictors]
data.target <- pmsm_temperature_data$stator_yoke
 
#a Split the data; 85% to training data and 15% to test data
sample.size <- floor(0.85*nrow(pmsm_temperature_data))
train <- data.predictors[1:sample.size, ]
test <- data.predictors[-c(1:sample.size), ]

# Select labels for train data
cl <- data.target[1:sample.size]

# Run KNN algorithm and create contingency table with k=100
knn.test.predict <- knn(train, test, cl, k=100)
test.label <- data.target[-c(1:sample.size)]
table(test.label, knn.test.predict)

#11c. Forecast stator_yoke uning Pm, Ambient, Coolant, and motor_speed
# Establish predictors and target
predictors <- c("pm", "ambient", "coolant", "motor_speed")
data.predictors <- pmsm_temperature_data[predictors]
data.target <- pmsm_temperature_data$stator_yoke

#a Split the data; 85% to training data and 15% to test data
sample.size <- floor(0.85*nrow(pmsm_temperature_data))
train <- data.predictors[1:sample.size, ]
test <- data.predictors[-c(1:sample.size), ]

# Select labels for train data
cl <- data.target[1:sample.size]

# Run KNN algorithm and create contingency table with k=100
knn.test.predict <- knn(train, test, cl, k=100)
test.label <- data.target[-c(1:sample.size)]
table(test.label, knn.test.predict)

#11d. Forecast stator_yoke uning Pm, Ambient, Coolant, u_d, u_q, motor_speed,
#     and Torque
# Establish predictors and target
predictors <- c("pm", "ambient", "coolant", "u_d", "u_q", "motor_speed", 
                "torque")
data.predictors <- pmsm_temperature_data[predictors]
data.target <- pmsm_temperature_data$stator_yoke
  
#a Split the data; 85% to training data and 15% to test data
sample.size <- floor(0.85*nrow(pmsm_temperature_data))
train <- data.predictors[1:sample.size, ]
test <- data.predictors[-c(1:sample.size), ]

# Select labels for train data
cl <- data.target[1:sample.size]

# Run KNN algorithm and create contingency table with k=100
knn.test.predict <- knn(train, test, cl, k=100)
test.label <- data.target[-c(1:sample.size)]
table(test.label, knn.test.predict)
