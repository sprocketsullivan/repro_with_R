# We will create a simple analysis with a real data set.
# The data set contains 100 participants (50 female/50 male).
# For each participant, we measured head size and brain volume from structural MRI scans.

##############################
# Read in data from the comma-separated value file Brain_Size.csv.
# Use the read_csv function and assign the result to a new variable my_data.
# What class does this variable have? Use the class function.
my_data <- read.csv("Brain_Size.csv")

# Look at the data with the View function (capital V).
View(my_data)

# Make a new data frame my_data_filter where you remove all participants
# with head sizes below 50 and brain volume above 1400.
# Use the subset function for this.
my_data_filter <- subset(my_data, HEAD_SIZE > 50 & BRAIN_VOLUME < 1400)

# Use aggregate to calculate the mean Brain Volume size for each gender.
# Use the ~ operator and assign the result of the aggregate function to a new variable.
my_data_mean <- aggregate(BRAIN_VOLUME ~ SEX, data = my_data, FUN = mean)

# Calculate a new variable/column in my_data (rel_BV) that gives the BRAIN_VOLUME 
# normalized for HEAD_SIZE.
my_data$rel_BV <- my_data$BRAIN_VOLUME / my_data$HEAD_SIZE

# Create a boxplot of the comparison of BRAIN_VOLUME and SEX.
# Use the boxplot function and again use the ~ operator for the formula.
boxplot(BRAIN_VOLUME ~ SEX, data = my_data)

# Calculate a t-test comparing the Brain Volume between males and females.
# Assign the result to a separate variable and print the result.
# Again use the ~ operator to relate variables to each other.
t_1 <- t.test(BRAIN_VOLUME ~ SEX, data = my_data)
print(t_1)

# Calculate a linear regression with BRAIN_VOLUME as the dependent variable
# and HEAD_SIZE as the independent variable.
# Use the lm function for this, assign the results to a variable, and use the summary function.
m_1 <- lm(BRAIN_VOLUME ~ HEAD_SIZE, data = my_data)
summary(m_1)

# For the model check, we need an additional library.
# Install the package car with the install.packages function, then load the library into your workspace.
# install.packages("car")
library(car)

# Perform model check.
# Now we can perform a model check and see whether the residuals are normally distributed.
# Use the qqPlot function from the car package.
qqPlot(m_1)

# We can also plot (plot function) the residuals (extracted from the model via the residuals function)
# against the fitted values (extracted via the fitted function).
plot(residuals(m_1) ~ fitted(m_1))

# Now add an additional variable SEX to your linear model from above by extending the formula
# through the + operator. Assess the results with the summary function.
m_2 <- lm(BRAIN_VOLUME ~ SEX + HEAD_SIZE, data = my_data)
summary(m_2)
