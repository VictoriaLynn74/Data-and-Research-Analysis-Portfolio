# installing package
install.packages("palmerpenguins")
library("palmerpenguins")
summary(penguins)
View(penguins)

# installing Tidyverse
install.packages("tidyverse")
library(tidyverse)

# creating vizualization
ggplot(data=penguins,aes(x=flipper_length_mm,y=body_mass_g))+geom_point(aes(colour = species))

# Creating a variable
var1 <- 1999

# creating a vector
vec1 <- c(13.5, 12.2, 54.7)

# creating a matrix
matrix(c(3:8), nrow = 2)
matrix(c(3:8), ncol = 2)

# creating data frames 
data.frame(x = c(1, 2, 3) , y = c(1.5, 5.5, 7.5))

# Performing Calculations
quarter_1_sales <- 35657.98
quarter_2_sales <- 43810.55
midyear_sales <- quarter_1_sales + quarter_2_sales

# Viewing Data - Diamonds Tidyverse
head(diamonds)

# summarizing data 
glimpse(diamonds)

# cleaning data
# 1.Renaming
rename(diamonds, carat_new = carat)
# Summary statistics
summarize(diamonds, mean_carat = mean(carat))

# Vizualization
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point()

# To seperate components in a visual 
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point() +
  facet_wrap(~cut)

# ToothGrowth dataset
data("ToothGrowth")
View(ToothGrowth)

# Installing dplyr package
install.packages("dplyr")
library(dplyr)

# Filtering the data
filtered_tg <- filter(ToothGrowth, dose == 0.5)
filtered_tg

#Sorting the Data
arrange(filtered_tg, len)

# Using Nested Functions
arrange(filter(ToothGrowth, dose == 0.5), len)

#Using Pipes
filtered_toothgrowth <- ToothGrowth %>% 
  filter(dose == 0.5) %>% 
  arrange(len)
filtered_toothgrowth

filtered_toothgrowth2 <- ToothGrowth %>% 
  filter(dose == 0.5) %>% 
  group_by(supp) %>% 
  summarise(mean_len = mean(len, na.rm = T), .group = "drop")
filtered_toothgrowth2







