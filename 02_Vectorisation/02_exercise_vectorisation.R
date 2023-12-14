########
# Vectorisation vs loops
# some additional thoughts on vectorisation:_
# http://www.noamross.net/blog/2014/4/16/vectorization-in-r--why.html
# read if finished with this exercise early
######

# consider the following example of a
# Loop
x <- 1:5
y <- 6:10
z <- NULL
for (i in c(1:5)) {
  z <- c(z, x[i] + y[i])
}

# VS a vectorized approach
x <- 1:5
y <- 6:10
z <- x + y

#####################
# The task is to
# create a vector check.vector which is True/False
# if an element in another vector (binary.vector) equals the previous element in binary.vector
# Example in a for loop
#####################
# create a vector with 100 values of either 0 or 1 (echa with 50% probability)
binary.vector <- rbinom(100, 1, 0.5)
# such a vector is equivalent to a vector holding TRUE/FALSE Values
# Variables that can be either true or false are called Boolean
# Remember that you can do operations (like +,-,*,/)
# on these variables as well
# Initialise the vector check.vector1
# The NULL statement is helpful if you do not know
# initially how many elements your vector should hold
check.vector1 <- NULL
# the first entry has no previous element
check.vector1[1] <- FALSE
# for loop to check previous variable (index starting at 2)
for (i in 2:length(binary.vector)) {
  if (binary.vector[i] == binary.vector[i - 1]) {
    check.vector1[i] <- TRUE
  } else {
    check.vector1[i] <- FALSE
  }
}
#############
# Write a vectorised version of this
# call the vector holding T/F values check.vector2
#############



# check whether both check vectors give the same result
# in a vectorised format (compare check.vector1 and check.vector2 without for loop)



###############################
# In a next step we look at the ifelse function
# It vectorises conditional statements
##############################
# in a first step create a data frame with a variable y that is uniformly distributed between 0 and 5
my_data <- data.frame(y = runif(100, 0, 5))
# in this data frame assign a variable check the value TRUE
# if y is larger than 2.5 or FALSE
# if it is smaller (or equal to 2.5)
# use ifelse as vectorised solution


###################################
# The next step aleady prepares our next session
# We will use a publication that can be found under
# https://doi.org/10.1038/s41598-018-27482-2
# Gan, H.-Y., Peng, T.-L., Huang, Y.-M., Su, K.-H., Zhao, L.-L., Yao, L.-Y., & Yang, R.-J. (2018).
# Efficacy of two different dosages of levofloxacin
# in curing Helicobacter pylori infection: A Prospective, Single-Center, randomized clinical trial.
# Scientific Reports, 8(1), 1–5. https://doi.org/10.1038/s41598-018-27482-2
# Please read this publication for next week
# In a first step we want to read it in
# read through the following code and try to understand it
#####
library(tidyverse)
library(readxl)
# download the publication data from Figshare
# to a temporary file (p1f)
url1 <- "https://ndownloader.figshare.com/files/11183900"
p1f <- tempfile()
download.file(url1, p1f, mode = "wb")
# read in data. Note that we need to define NA
my_data <- read_excel(path = p1f, sheet = 1, na = "NA")
# NA is a special variable in R for missing values
# read more on this at:
# https://stats.idre.ucla.edu/r/faq/how-does-r-handle-missing-values/
# Next time we will try to recreate Table 2 from the paper
# first we need to rename the column names in the data frame
# all variable names have spaces in variable names which is unfortunate so we create new (easier)
# variable names
# we simply overwrite the existing ones with fitting new ones
names(my_data) <- c("id", "baseline", "treatment", "outcome_treatment", "adverse_drug_reaction", "adverse_drug_reaction_content", "adverse_drug_reaction_classified", "study_completed", "reason_uncompleted", "per_protocol_analysis")
