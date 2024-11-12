#installng package
 install.packages("palmerpenguins")
library("palmerpenguins")
summary(penguins)
View(penguins)
install.packages("tidyverse")
library(tidyverse)
#creating vizualization
ggplot(data=penguins,aes(x=flipper_length_mm,y=body_mass_g))+geom_point(aes(colour = species))

