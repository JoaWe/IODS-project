# Joana 
# 04.12.2017
#Datawrangling Rstudio- tasks 4 & 5


#Libraries:
library(dplyr)
library(ggplot2)

#Reading Human development (hd) -data into R:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

#Reading Gender Inequality Index (gii) -data into R:
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Structures and dimensions:
str(hd)
dim(hd)
str(gii)
dim(gii)

#data-summaries:
summary(hd)
summary(gii)

#Taking a look at the column-names:
colnames(hd)
colnames(gii)

#Re-naming the column-names:
new_colnames_hd <- c("HDI_Rank", "Country", "HDI", "Life_Exp", "Exp_y_Edu", "MeanEdu", "GNIpCap", "GNIR_minus_HDIR")
new_colnames_gii <- c("GII_Rank", "Country", "GII", "MatMorRatio", "Adol_Birth_Rate", "ParlRepPercent", "Edu2.F", "Edu2.M", "LabF", "LabM")

colnames(hd) <- new_colnames_hd
colnames(gii) <- new_colnames_gii

colnames(hd)
colnames(gii)

#Mutating gii-data & creating new variables:
gii <- mutate(gii, Edu2.FM = (Edu2.F / Edu2.M))
gii <- mutate(gii, Lab.FM = (LabF / LabM))

#Joining datasets hd and gii:
human <- inner_join(hd, gii, by = c("Country"))
dim(human)

#creating new file:
write.csv(human, file = "C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\data\\human.csv",row.names = FALSE)
read.csv("C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\data\\human.csv")
