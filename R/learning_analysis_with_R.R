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

# Adding new Column to Data frame
data("diamonds")
head(diamonds)
colnames(diamonds)
mutate(diamonds, carat_2=carat*100)

#Creating a data frame using vectors
names <- c("Joy", "Victoria", "Lincoln", "Patience")
age <- c(29,24 ,22 ,16 )
people <- data.frame(names, age)
mutate(people, age_in_20 = age + 20)

# Data Cleaning
install.packages("here")
library("here")
install.packages("skimr")
library("skimr")
install.packages("janitor")
library("janitor")
install.packages("dplyr")
library("dplyr")
install.packages("palmerpenguins")
library("palmerpenguins")
library("tidyr")


skim_without_charts(penguins)
glimpse(penguins)

# Selecting one column
penguins %>% 
  select(species)

# Excluding one column
penguins %>% 
  select(-species)

# Clean names with janitor package
clean_names(penguins)

# Sorting Data
penguins %>% arrange(bill_length_mm)

# Descending order
penguins %>% arrange(-bill_length_mm)
penguins_2<-penguins %>% arrange(-bill_length_mm)
View(penguins_2)

# Group By
penguins %>% group_by(island) %>% drop_na() %>% summarise(mean_bill_length_mm = mean(bill_length_mm))
penguins %>% group_by(island) %>% drop_na() %>% summarise(max_bill_length_mm = max(bill_length_mm))
penguins %>% group_by(island,species) %>% drop_na() %>% summarise(mean_bl = mean(bill_length_mm), max_bl = max(bill_length_mm))

# Filtering Data
penguins %>% filter(species=="Adelie")

# Combining two columns
example_df <- bookings_df %>%
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_month_year, c("arrival_date_month", "arrival_date_year"), sep = " ")

example_df <- bookings_df %>%
  mutate(guests = adults + children + babies )
head(example_df)

# Transforming Data
id<- c(1:10)
name <- c("John Mendes", "Rob Stewart", "Rachel Abrahamson", "Christy Hickman", "Johnson Harper", "Candace Miller", "Carlson Landy", "Pansy Jordan", "Darius Berry", "Claudia Garcia")


job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")


employee <- data.frame(id, name, job_title)
print(employee)

# Splitting Columns
separate(employee, name,into=c('first_name', 'last_name'), sep= ' ')

first_name <- c("John", "Rob", "Rachel", "Christy", "Johnson", "Candace", "Carlson", "Pansy", "Darius", "Claudia")

last_name <- c("Mendes", "Stewart", "Abrahamson", "Hickman", "Harper", "Miller", "Landy", "Jordan", "Berry", "Garcia")

job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")

employee <- data.frame(id, first_name, last_name, job_title)

print(employee)

# Combining two columns
unite(employee, 'name', first_name,last_name,sep = ' ')

# Adding New Columns
View(penguins)
penguins %>% 
  mutate(body_mass_kg=body_mass_g/1000, flipper_length_m=flipper_length_mm/1000)
# Anscombe's Quartet
install.packages("Tmisc")
library(Tmisc)
data(quartet)
View(quartet)
quartet %>% 
  group_by(set) %>% 
  summarise(mean(x),sd(x),mean(y),sd(y),cor(x,y))

# Plotting the data
ggplot(quartet,aes(x,y))+geom_point()+geom_smooth(method=lm,se=FALSE)+facet_wrap(-set)

install.packages('datasauRus')

library('datasauRus')

ggplot(datasaurus_dozen,aes(x=x,y=y,colour=dataset))+geom_point()+theme_void()+theme(legend.position = "none")+facet_wrap(~dataset,ncol=3

# ggplot2
library("ggplot2")
library("palmerpenguins")\
ggplot(data=penguins) + geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g))
ggplot(data=penguins) + geom_point(mapping = aes(x=bill_length_mm, y= bill_depth_mm))

# Adding color to plots
ggplot(data=penguins) + geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g, colour = species))
ggplot(data=penguins) + geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g,alpha = species))

# Changing color of all points
ggplot(data=penguins) + geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g),colour = "pink")

# Adding shapes and size to points
ggplot(data=penguins) + geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g,color=species,size=species, shape = species))
                                                                                                                          
# Working with geoms
ggplot(data = penguins)+ geom_smooth(mapping = aes(x=flipper_length_mm,y=body_mass_g))
ggplot(data = penguins)+ geom_smooth(mapping = aes(x=flipper_length_mm,y=body_mass_g,linetype = species))

# Two geoms in one plot
ggplot(data = penguins)+ geom_smooth(mapping = aes(x=flipper_length_mm,y=body_mass_g)) + geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g))
                                                                                                                    
# ggplot bar charts
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill = clarity))
                                                                                                                          
# Adding labels and annotations
ggplot(data=penguins)+
  geom_point(mapping = aes(x=flipper_length_mm, y= body_mass_g, colour=species))+
  labs(title="Palmer Penguins Body Size vs Flipper Length", subtitle = "Sample of Three Penguins",
       caption = "Data collected by Dr.Kristen Gorman")+
  annotate("text", x=220, y=3500, label = "The Gentoos are the Largest", colour = "blue", fontface= "italic")
                                                                                                                          
# Saving plots
ggsave("Palmer Penguins.png")
                                                                                                                          
                                                                                                                          
 # Factor Analysis - KMO and Bartlett's Test
                                                                                                                          
install.packages("haven")
install.packages("psych")
library(psych)
                                                                                                                          
attach(updated_organizational_data)
                                                                                                                          
coord_model= data.frame(Operationcord, Collaborates, Efectivchange, Strategicpart, Reviewbuss, Effectivecod, Leadership )
KMO(coord_model)
bartlett.test(coord_model)
                                                                                                                          
leadership_model = data.frame(Settinggoals, Tolerance, Continousplng, Communicatn, Inyouropinion, Decisionmakn, Stronglearning)
KMO(leadership_model)
bartlett.test(leadership_model)
                                                                                                                          
orgperfom_model = data.frame(Deliveryontime, Image, Newproducts, Processes, Newcustomer, Retention, Swiftresponse, Clearlydefined)
KMO(orgperfom_model)
bartlett.test(orgperfom_model)                                                                                                                          
                                                                                                                          
                                                                                                                          




