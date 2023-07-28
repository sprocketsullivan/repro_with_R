library(tidyverse)

# R provides built-in datasets which can be loaded and used to practice
# You can take a look at all available datasets with this command: 

help(package="datasets")

# Let's load the dataset "airquality" for our tidyverse warm-up exercise
# The "airquality" dataset provides New York Air quality measurements from May - September 
# for a specific year. 

data("airquality")

# Notice that "airquality" is immediately available in the environment 
# You should not use an assignment operator to load the built-in dataset into the environment. 

# Now check whether the airquality was imported as a dataframe by using the command class()
# Familiarize yourself with the dataset: check how many rows and columns are included, try different commands like glimpse(), dim() 
# or other commands you remember from the DataCamp courses 
class()
dim()
glimpse()
nrow()
ncol()

# Let's take a look at the variables names and classes in airquality using the command str()
str()

# How can we change the variable Month into a factor? 
# use as.factor() in the solution 
 <- as.factor()

# Which months are included in the dataset? 
# use levels() in the solution 
levels()

# Now, let's rename the levels of the Month variable into 
# Mai, June, July, August, September 
# Check whether the renaming was successful with str()
levels() <- c()
str()

# Let's look at missing values in the dataset!
# Check how many values in each variable are missing 
# by concatenating the summary() and is.na() command

summary()

# Next, check the number of rows with complete datapoints for all variables 
# by concatenating sum() and complete.cases() command

sum()

# The temperature values in the dataset are given in Fahrenheit. 
# Let's create a new variable Temp_Celsius to transform Fahrenheit to Celsius values 
# The formula to transform Fahrenheit to Celsius is 
# Celsius = (Fahrenheit-32) * (5/9). 
# Also round the new variable Temp_Celsius to 1 decimal. 
# Save the new dataframe as airquality 

 <- 
  airquality %>%
  mutate()


# Now calculate the mean and maximum temperature (in °C) per month. 
# In order to do so, use the commands group_by() and summarize()

airquality %>%
  group_by() %>%
  summarize()


# Next, filter the dataset for Month == "September", and create new variable with 
# the values for the median Ozone, Temp_Celsius and Wind measurements for September using 
# the command summarize()
# How can you avoid, that NA values are returned? 
# Assign the new dataframe the name "September" 


 <- 
  airquality %>% 
  filter() %>%
  summarize()


# calculate the percentage of complete observations (complete rows) for September, 
# assigning the name perc_complete to it
perc_complete <- sum(complete.cases()))/nrow()


# add a new variable perc_complete and its value to the dataframe "September" with mutate()

