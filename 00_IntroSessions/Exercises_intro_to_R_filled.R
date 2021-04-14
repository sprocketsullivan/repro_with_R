#we will create a simple analysis with a real data set
#the data set contains 
#100 participants (50 female/50 male)
#for each participant we measured head size and brain volume from 
#structural MRI scans
##############################
#Read in data from the comma separated value file Brain_size.csv
#use the read_csv function
#and assign the result to a new variable my_data
#what class does this variable have? use the class function
my_data <- read.csv("Brain_Size.csv")
#look at the data with the View function (capital V)
View(my_data)
#make a new data frame my_data_filter where you remove all particpants with head sizes below 50 and brain
#volume above 1400 use the subset function for this
my_data_filter <- subset(my_data,HEAD_SIZE>1400)
#use aggregate to calculate the mean Brain Volume size 
#for each gender
#use the ~ operator and assign the result of the aggregate function
#to a new variable
my_data_mean <- aggregate(BRAIN_VOLUME~SEX,data=my_data,FUN=mean)
#calculate a new variable/column in my_data (rel_BV) 
#that gives the  BRAIN_VOLUME normalised for HEAD_SIZE
my_data$rel_BV <- my_data$BRAIN_VOLUME/my_data$HEAD_SIZE
#create a boxplot of the comparison of BRAIN_VOLUME and SEX 
#use the boxplot function and again use the ~ operator for the formula
boxplot(BRAIN_VOLUME~SEX,data=my_data)
#calculate a t-test comparing the Brain Volume between males and females
#assign the result to a separate variable
#print the result. Again use the ~ operator to relate variable to each other
t_1 <- t.test(my_data$BRAIN_VOLUME~my_data$SEX)
print(t_1)
#calculate a linear regression with BRAIN_VOLUME as 
#dependent variable and HEAD_SIZE as independent variable
#use the lm function for this 
#assign the results to a variable and use 
#the summary function 
m_1 <- lm(BRAIN_VOLUME~HEAD_SIZE,data=my_data)
summary(m_1)
#for the model check we need an additional library
#install the package car with the install.packages function
#then load the variable into your workingspace 
#by using the library function
#install.packages("car")
library(car)
#perform model check
#now we can perfrom a model check and see whether the residuals 
#are normally distributed
#use the qqPlot function from the car package
qqPlot(m_1)
#we can also plot (plot function) 
#the residuals (extracted from the model via the residuals function)
#against the fitted values (extracted via the fitted function)
plot(residuals(m_1)~fitted(m_1))
#now add an additional variable SEX to your linear model from above by extending 
#the formula through the +  operator
#asses the results with the summary function
m_2 <- lm(BRAIN_VOLUME~SEX+HEAD_SIZE,data=my_data)
summary(m_2)










  



