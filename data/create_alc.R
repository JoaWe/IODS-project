#Joana
#20.11.2017
#working on combined datasets based on the datasets provided by the UCI Machine Learning Repository 
#Reference to original dataset: P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7. 


### Part 1: Data-wrangling:


## Reading dataset "student-mat" into R from project-folder:
math <- read.csv("C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\student-mat.csv",sep = ";",  header=TRUE)
str(math)
dim(math)
# According to the structure- and dimensions-function the dataset "math" contains 395 observations related to 33 variables.

#Quick look at the column-names:
colnames(math)


## Reading dataset "student-por" into R from project-folder:
por <- read.csv("C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\student-por.csv",sep = ";", header=TRUE)
str(por)
dim(por)
# According to the structure- and dimensions-functions the dataset "por" contains 649 observations related to 33 variables.

#Quick look at the column-names:
colnames(por)


## Joining common columns as (student) identifiers:

#Accessing dplyr- & ggplot-library:
library(dplyr)
library(ggplot2)

# common columns by which the datasets are to be joined:
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

#Joining he two datasets:
math_por <- inner_join(math, por, by = join_by, suffix = c (".math", ".por"))

# looking at the new dataset
colnames(math_por)
glimpse(math_por)
str(math_por)
dim(math_por)
# The contemporary dataset contains 382 observations and 53 variables. Technically it should now only contain those respondents/students that anwered both questionaires.

## Creating the new data frame with only the joined columns (as undertaken in the Datacamp-exercise)
alc <- select(math_por, one_of(join_by))
str(alc)
dim(alc)
#The newly created dataframe "alc" contains 13 variables and 382 observations.

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)
str(alc)
dim(alc)
colnames(alc)


## Defining the new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

## Defining a new column "high_use", which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise)
alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)
dim(alc)
# As demanded in task 1.7. of this R-exercise my new dataset "alc" now has 382 observations and 35 variables. So far, so good.


## Creating the csv-file:
write.csv(alc, file = "C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\data\\alc.csv",row.names = FALSE)
