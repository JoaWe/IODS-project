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
write.csv(human, file = "C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\human.csv",row.names = FALSE)
read.csv("C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\human.csv")

#Accessing stringr-library:
library(stringr)

#Changing GNIpCap to numeric:
str(human$GNIpCap)
str_replace(human$GNIpCap, pattern = ",", replace = "") %>% as.numeric

#keeping 9 columns: Country, Life_Exp, Exp_y_Edu, GNIpCap MatMorRatio, Adol_Birth_Rate, ParlRepPercent, Edu2.FM, and Lab.FM:
keep <- c("Country", "Life_Exp", "Exp_y_Edu", "GNIpCap", "MatMorRatio", "Adol_Birth_Rate", "ParlRepPercent", "Edu2.FM", "Lab.FM")

#selecting keep-columns:
human <- select(human, one_of(keep))

#dimensions-check to make sure, I have the 9 columns:
dim(human)

#printing completeness-indicator:
complete.cases(human)

#printing the data with completteness-indicator as last column:
data.frame(human[-1], comp = complete.cases(human))

#filtering out all rows with NA-values
human_ <- filter(human, complete.cases(human))

#looking at observations for countries:
human_$Country

# using tail function to look at last 10 observations:
tail(human_$Country, 10)
#Identified as Regions: World,Sub-Saharan Africa, South Asia, Latin America and the Caribbean, Europe and Central Asia, East Asia and the Pacific, and Arab States
#These are to be removed from the new dataset!

#creating object "last":
last <- nrow(human_) - 7

#Choosing everything until the "last"-data:
human <- human_[1:last,]

#Defining rownames:
rownames(human) <- human$Country

#removing column Country:
human$Country <- NULL
#Well, seems like, I have now 155 observations and 8 variables...

#saving the data in my data-folder:
write.csv(human, file = "C:\\Users\\Ani\\Documents\\GitHub\\IODS-project\\data\\human.csv",row.names = TRUE)
