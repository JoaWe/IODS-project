# Joana 
# 14.11.2017
# This file is intended to work on my first attempts with the data-wrangling exercise.

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# The data given provide (according to my RStudio) 183 observations for a total of 60 variables.
# Except for the variables of "Age", "Attitude", "Points", and "gender" the data are operationalzed on a scale from 1 - 5.
# The variable "gender" does not include numeric values as they are they are of a qualitative nature, but they are operationalized in the form of text in a binary fashion of "M" or "F". 
# The variable "Age" - according to the info-page - is based on counting the number of years since the birthdate provided by the respondent.

#the data dimension:
dim(lrn14)
#the data-set's structure:
str(lrn14)


# Data-wrangling attempts:

# printing and summarizing "gender"
lrn14$gender
summary(lrn14$gender)
# The printing of these data confirmed the binary character of the data. The summary supplied the information that the 183 observations are thus divided in 122 female and 61 male respondents.

# printing and summarizing "Age"
lrn14$Age
summary(lrn14$Age)
# The summary provided me with the age-range of the respondents from 17 to 55 years. The average-age of the respondents is 25,58 years. The median-age is 22.

#printing and summarizing "Points"
lrn14$Points
summary(lrn14$Points)
# The points reach from 0 to a maximum of 33. The average exam-points are 20,61. The Median-value of the Variable points is 22.00.

#Scaling down "Attitude" to attitude
lrn14$attitude <- lrn14$Attitude / 10
lrn14$attitude
summary(lrn14$attitude)
#At least that looks like it works...

install.packages("tidyverse")
install.packages("dplyr")
library(dplyr)
#Let's try the combination of variables to "deep_questions" again:
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
summarise(deep_questions)
deep_questions
#creating the basic column:
deep_columns <- select(lrn14, one_of(deep_questions))
deep_columns

#applying means to "deep_columns":
lrn14$deep <- rowMeans(deep_columns)

# combining variables to "surface question"
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_questions
summarise(surface_questions)

#creating "surface_columns"
surface_columns <- select(lrn14, one_of(surface_questions))
surface_columns

#applying means to "surface_columns"
lrn14$surf <- rowMeans(surface_columns)
lrn14$surf
summarise(lrn14$surf)

#creating variable "surface_questions"
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_questions
summarise(strategic_questions)

#creating "strategic_columns"
strategic_columns <- select(lrn14, one_of (strategic_questions))
strategic_columns

#applying means to "strategic_columns"
lrn14$stra <- rowMeans(strategic_columns)
lrn14$stra
