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