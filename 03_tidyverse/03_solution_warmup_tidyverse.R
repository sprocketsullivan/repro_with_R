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
# Also check how many rows and columns are included
class(airquality)
dim(airquality)
nrow(airquality)
ncol(airquality)

# Let's take a look at the variables names and classes in airquality using the command str()
str(airquality)

# How can we change the variable Month into a factor? 
# use as.factor() in the solution 
airquality$Month <- as.factor(airquality$Month)

# Which months are included in the dataset? 
# use levels() in the solution 
levels(airquality$Month)

# Now, let's rename the levels of the Month variable into 
# Mai, June, July, August, September 
# Check whether the renaming was successful with str()
levels(airquality$Month) <- c("May", "June", "July", "August", "September")
str(airquality)

# Let's look at missing values in the dataset!
# Check how many values in each variable are missing 
# by concatenating the summary() and is.na() command

summary(is.na(airquality))

# Next, check the number of rows with complete datapoints for all variables 
# by concatenating sum() and complete.cases() command
sum(complete.cases(airquality))

# The temperature values in the dataset are given in Fahrenheit. 
# Let's create a new variable Temp_Celsius to transform Fahrenheit to Celsius values 
# The formula to transform Fahrenheit to Celsius is 
# Celsius = (Fahrenheit-32) * (5/9). 
# Also round the new variable Temp_Celsius to 1 decimal. 
# Save the new dataframe as airquality 

airquality <- 
  airquality %>%
  mutate(Temp_Celsius = (Temp - 32)*(5/9),
         Temp_Celsius = round(Temp_Celsius,1))


# Now calculate the mean and maximum temperature (in °C) per month. 
# In order to do so, use the commands group_by() and summarize()

airquality %>%
  group_by(Month) %>%
  summarize(mean_Temp = mean(Temp_Celsius), 
            max_Temp = max(Temp_Celsius))


# Next, filter the dataset for Month == "September", and create new variable with 
# the values for the median Ozone, Temp_Celsius and Wind measurements for September using 
# the command summarize()
# How can you avoid, that NA values are returned? 
# Assign the new dataframe the name "September" 

 
September <- 
  airquality %>% 
  filter(Month == "September") %>%
  summarize(median_Temp = median(Temp_Celsius, na.rm =T), 
         median_Ozone = median(Ozone, na.rm = T), 
         median_Wind = median(Wind, na.rm = T))


# calculate the percentage of complete observations (complete rows) for September, 
# assigning the name perc_complete to it
perc_complete <- sum(complete.cases(airquality %>% filter(Month == "September")))/nrow(airquality %>% filter(Month == "September"))* 100


# add a new variable perc_complete and its value to the dataframe "September" 
September <- 
  September %>% 
  mutate(perc_complete = perc_complete)
