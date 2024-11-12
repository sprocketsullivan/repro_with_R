# We will create a simple analysis with a real data set.
# The data set contains 100 participants (50 female/50 male).
# For each participant, we measured head size and brain volume from structural MRI scans.

##############################
# Read in data from the comma-separated value file Brain_Size.csv.
# Use the read_csv function and assign the result to a new variable my_data.
# What class does this variable have? Use the class function.

# Look at the data with the View function (capital V).

# Make a new data frame my_data_filter where you remove all participants
# with head sizes below 50 and brain volume above 1400.
# Use the subset function for this.

# Use aggregate to calculate the mean Brain Volume size for each gender.
# Use the ~ operator and assign the result of the aggregate function to a new variable.

# Calculate a new variable/column in my_data (rel_BV) that gives the BRAIN_VOLUME 
# normalized for HEAD_SIZE.

# Create a boxplot of the comparison of BRAIN_VOLUME and SEX.
# Use the boxplot function and again use the ~ operator for the formula.

# Calculate a t-test comparing the Brain Volume between males and females.
# Assign the result to a separate variable and print the result.
# Again use the ~ operator to relate variables to each other.

# Calculate a linear regression with BRAIN_VOLUME as the dependent variable
# and HEAD_SIZE as the independent variable.
# Use the lm function for this, assign the results to a variable, and use the summary function.

# For the model check, we need an additional library.
# Install the package car with the install.packages function, then load the library into your workspace.

# Perform model check.
# Now we can perform a model check and see whether the residuals are normally distributed.
# Use the qqPlot function from the car package.

# We can also plot (plot function) the residuals (extracted from the model via the residuals function)
# against the fitted values (extracted via the fitted function).

# Now add an additional variable SEX to your linear model from above by extending the formula
# through the + operator. Assess the results with the summary function.
