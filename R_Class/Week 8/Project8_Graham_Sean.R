library(readxl)
breast_cancer_data <- read_excel("breast_cancer_data.xlsx")
View(breast_cancer_data)

#2 Define a user defined funciton with two arguments, a target and a
#  predictor, to plot the boxplot of the predictor based on the
#  categories of the target
BoxplotPredictorOnTarget <- function(target, predictor){
  Boxplot <- boxplot(predictor ~ target, data = breast_cancer_data, 
                     notch=TRUE)
  return(Boxplot)
}
#a Generate the boxplot of area_mean against diagnosis
BoxplotPredictorOnTarget(breast_cancer_data$diagnosis, 
                         breast_cancer_data$area_mean)
#b Generate the boxplot of area_se against diagnosis
BoxplotPredictorOnTarget(breast_cancer_data$diagnosis, 
                         breast_cancer_data$area_se)
#c Generate the boxplot of texture_mean against diagnosis
BoxplotPredictorOnTarget(breast_cancer_data$diagnosis, 
                         breast_cancer_data$texture_mean)

#3 Build knn models to forecast the diagnosis
#b Forecast diagnosis using area_mean
library(class)
breast_cancer_data$diagnosis <- as.factor(breast_cancer_data$diagnosis)

# Establish predictors and target
predictors <- c("area_mean")
data.predictors <- breast_cancer_data[predictors]
data.target <- breast_cancer_data$diagnosis

#a Split the data; 80% to training data and 20% to test data
sample.size <- floor(0.8*nrow(breast_cancer_data))
train <- data.predictors[1:sample.size, ]
test <- data.predictors[-c(1:sample.size), ]

# Select labels for train data and find the number of neighbors
cl <- data.target[1:sample.size]
num.neighbors <- floor(sqrt(nrow(breast_cancer_data)))

# Run KNN algorithm and create contingency table
knn.test.predict <- knn(train, test, cl, k=num.neighbors)
test.label <- data.target[-c(1:sample.size)]
table(test.label, knn.test.predict)

#c Forecast diagnosis using area_mean and area_se
# Establish predictors and target
predictors <- c("area_mean", "area_se")
data.predictors <- breast_cancer_data[predictors]
data.target <- breast_cancer_data$diagnosis

#a Split the data; 80% to training data and 20% to test data
sample.size <- floor(0.8*nrow(breast_cancer_data))
train <- data.predictors[1:sample.size, ]
test <- data.predictors[-c(1:sample.size), ]

# Select labels for train data and find the number of neighbors
cl <- data.target[1:sample.size]
num.neighbors <- floor(sqrt(nrow(breast_cancer_data)))

# Run KNN algorithm and create contingency table
knn.test.predict <- knn(train, test, cl, k=num.neighbors)
test.label <- data.target[-c(1:sample.size)]
table(test.label, knn.test.predict)

#d Forecast diagnosis using area_mean, area_se, and texture_mean
# Establish predictors and target
predictors <- c("area_mean", "area_se", "texture_mean")
data.predictors <- breast_cancer_data[predictors]
data.target <- breast_cancer_data$diagnosis

#a Split the data; 80% to training data and 20% to test data
sample.size <- floor(0.8*nrow(breast_cancer_data))
train <- data.predictors[1:sample.size, ]
test <- data.predictors[-c(1:sample.size), ]

# Select labels for train data and find the number of neighbors
cl <- data.target[1:sample.size]
num.neighbors <- floor(sqrt(nrow(breast_cancer_data)))

# Run KNN algorithm and create contingency table
knn.test.predict <- knn(train, test, cl, k=num.neighbors)
test.label <- data.target[-c(1:sample.size)]
table(test.label, knn.test.predict)
