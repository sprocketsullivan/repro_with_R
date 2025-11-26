####
# We will use another published data set here to create an
# advanced visualisation.
# Does inhalation injury predict mortality in burns patients or require redefinition?
# see  https://doi.org/10.1371/journal.pone.0185195 for publication
#####
library(tidyverse)
library(readxl)
library(knitr)
library(kableExtra)
library(stringr)
# download the publication data from Figshare
url1 <- "https://ndownloader.figshare.com/files/9422038"
p1f <- tempfile()
download.file(url1, p1f, mode = "wb")
# read in data. Note that we need to define the NA
my_data <- read_excel(path = p1f, sheet = 1, na = "NA")
# the data set contains mortaility of patients after burns depending on
# whether and where they had inhalation burns
# first create a new variable that is a
# factor (0=normal, 1=subjective, 2=upper, and 3=lower)
my_data$INHdiv
my_data <-
  my_data %>% 
  mutate(INHdiv_fac = factor(INHdiv, labels = c("normal", "subjective", "upper", "lower")))

  #######
#Creating Tables with dplyr
#see also cheat sheet https://www.rstudio.com/resources/cheatsheets/
######

#Recreate Table 1 from the Publication (first 3 data rows are sufficient)
#For beginners create a Table of at least the first two columns, for more advanced do all columns
names_rows<-c("Mean age (years)","Sex (male:female)","Mean % TBSA burned")
names_columns<-c(paste("Total (n=",nrow(my_data),")",sep=""),paste("Survivors(n=",sum(my_data$mortaltiy==0),")"),paste("Non-survivors (n=",sum(my_data$mortaltiy==1),")"))

#create first column 
#create a dataframe
#summarise all variables (AGE: mean, sd, Sex male, Sex female), TBSA: mean, sd)
#round digits
#unite columns
#create long format
#add proper row names if not done previously
#hint the plus minus is "\u00b1"
#u will need the mutate, unite and pivot_longer functions
table_data<-
my_data %>% 
  

#use kable to create Table
#use proper colnames
table_data %>% 
  kbl(col.names = c("",names_columns[1])) %>% 
  kable_paper("hover", full_width = F)

#next two columns
table_data2<-
  my_data %>% 
  
  
#joint the two tables via left_join  
table_data3<-

#use kable to create Table
#use proper colnames
table_data3 %>% 
  kbl(col.names = c("",names_columns[1:3])) %>% 
  kable_paper("hover", full_width = F)

####################################
# create a data frame for a barplot
# group by the new inhalation severity variable and the PFdivide
# ("We also divided the patients into four groups depending on the PF ratio (>300, 200-300, 100-200, and <100)")
# you will need the mean of mortality (look out for spelling mistake) for each level of inhalation injury (INHdiv)
plot_data <-
  my_data %>%
  

# create a barplot from this with mean mortality on y axis and Pfdivide on x axis
# create a facet for each severity level
# add error bars
# make nice axis labels
p.1 <- 
  

# problem is we transformed a continuous variable to a factorial variable
# is there a way to plot a continuous variable
# if the dependent variable is 0 and 1?
# how about this
names(my_data)[8] <- c("PFratio")
ggplot(aes(y = mortaltiy, x = PFratio), data = my_data) +
  geom_point() +
  geom_smooth()
# this is not a nice representation!
# we need something better!
# see for example here:
# https://doi.org/10.1890/0012-9623(2004)85[100:ANMOPT]2.0.CO;2
# also as pdf on osf
# first summarise the data in a histogram format
# Summarise data to create histogram counts
# what is the min and max age?

hist_data <-
  my_data %>%
  # first add new variable breaks  that divides PFRatio in steps of 10
  # use the findInterval() function to assign the interval to each data point
  
  # then group by dead/alive and the breaks
  
  # count the total number in the groups
  
  # if patients are dead, we want them to show on top with histogram on top so you need to
  # calculate in this case the percentage as 1-percentage
  
  
######
# now we create a the plot
#####
ggplot() + # this just sets an empty frame to build upon
  # first add a histopgram with geom_segment use the help of geom_segment
  
  # then predict a logistic regression via stat_smooth and the glm method (we will cover the details in the next session)
  
  
######
# do the same thing for the four inhale burns groups separately
#####
hist_data <-
  my_data %>%
  # first add new variable that codes breaks
  
  # then group by dead/alive and the breaks
  
  # count
  
  # if patients are dead, we want them to show on top with histogram on top so you need to
  # calculate in this case the percentage as 1-percentage
  
######
# again create the plot
#####
ggplot() + # this just sets an empty frame to build upon
  # set the four panels
  
  # first add a histopgram with geom_segment use the help of geom_segment
  
  
  # then predict a logistic regression via stat_smooth and the glm method
  
  
  
########
# outlier detection for PF ratio
# check which data points are outliers in boxplot
########
# first create a function
is_outlier <- function(x) {
  return(x < quantile(x, 0.25) - 1.5 * IQR(x) | x > quantile(x, 0.75) + 1.5 * IQR(x))
}
# now print outlier labels (in this case the row number)
my_data %>%
  mutate(row_number = seq(1:nrow(my_data))) %>%
  mutate(outlier = ifelse(is_outlier(PFratio), row_number, as.numeric(NA))) %>%
  ggplot(., aes(x = INHdiv_fac, y = PFratio)) +
  geom_boxplot() +
  geom_text(aes(label = outlier), size = 2, position = position_stack(vjus = 0.1), na.rm = TRUE, hjust = -0.3)
# not ideal but a good starter
library(ggforce)
my_data %>%
  mutate(row_number = seq(1:nrow(my_data))) %>%
  mutate(outlier = ifelse(is_outlier(PFratio), row_number, as.numeric(NA))) %>%
  ggplot(., aes(x = INHdiv_fac, y = PFratio)) +
  geom_boxplot() +
  geom_sina(aes(x = INHdiv_fac, y = PFratio), method = "counts", scale = F) +
  geom_text(aes(label = outlier), size = 2, nudge_x = 0.15, na.rm = TRUE, hjust = -0.3)
