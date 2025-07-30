library(readxl)
kc_house_data <- read_excel("kc_house_data.xlsx")
View(kc_house_data)

#2 Build a linear model to forecast price using bedrooms, bathrooms, and sqft_living
lm.result <- lm(price ~ bedrooms + bathrooms + sqft_living, data = kc_house_data)
summary(lm.result)$coefficients
summary(lm.result)$r.squared
summary(lm.result)$adj.r.squared

#3 Build a linear model to forecast price using bedrooms, bathrooms, and sqft_living
#  and all the cross effects between them
lm.result2 <- lm(price ~ bedrooms * bathrooms * sqft_living, data = kc_house_data)
summary(lm.result2)$coefficients
summary(lm.result2)$r.squared
summary(lm.result2)$adj.r.squared

#4 Build a linear model to forecast price using bedrooms, bathrooms, and sqft_living,
#  waterfront, and grade
lm.result3 <- lm(price ~ bedrooms + bathrooms + I(sqft_living + waterfront + grade),
                 data = kc_house_data)
summary(lm.result3)$coefficients
summary(lm.result3)$r.squared
summary(lm.result3)$adj.r.squared

#5 Build a linear model to forecast price using all other columns and no y intercept
str(kc_house_data)
lm.result4 <- lm(price ~ -1 + bedrooms + bathrooms + sqft_living + sqft_lot + floors 
                 + waterfront + view + condition + grade + sqft_above + sqft_basement
                 + yr_built + yr_renovated + sqft_living15 + sqft_lot1+-5,
                 data = kc_house_data)
summary(lm.result4)$coefficients
summary(lm.result4)$r.squared
summary(lm.result4)$adj.r.squared

#6 Build a linear model to forecast price using bedrooms, bathrooms, sqft_living,
#  sqft_lot, floors, waterfront, view, condition, and grade. Enter the new info:
#  bedrooms = 4, bathrooms = 2, sqft_living = 2560, sqft_lot = 7650, floors = 1.5, 
#  waterfront = 1, view = 3, condition = 5, and grade = 10. Then find the average
#  sales price and 95% predicted interval
lm.result5 <- lm(price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors 
    + waterfront + view + condition + grade, data = kc_house_data)
new.house <- data.frame(bedrooms = 4, bathrooms = 2, sqft_living = 2560, 
    sqft_lot=7650, floors = 1.5, waterfront = 1, view = 3, condition = 5, grade = 10)
predict(lm.result5, newdata = new.house, interval = "predict")