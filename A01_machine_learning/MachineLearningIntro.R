library(tidyverse)
library(caret) #Machine learning in R
library(mlbench) #dataset
library(e1071)
#packages necessary for fitting RF & SVM
library(randomForest)
library(kernlab)

data(BreastCancer, package="mlbench")

#cleaning & preprocessing of the dataset
cancer_data <- as_tibble(BreastCancer) %>%
  select(-Id) %>%
  mutate_all(as.integer) %>%
  mutate(Class = as.factor(Class))


#------------------------------------------------------------------------------------------------------------------------
# exploring the dataset
#------------------------------------------------------------------------------------------------------------------------

#first try to understand the dataset and its variables:
#what variables are contained in the dataset? Can you identify what they mean?
#what types and value ranges have those variables?
#are there missing data?

#different ways of looking at the data possible
cancer_data
cancer_data %>% glimpse()
cancer_data %>% summary()
cancer_data$Class %>% table()

#are there missing values in the dataset?
missing_values <- map_int(cancer_data, function(x) sum(is.na(x)))

#remove all rows with missing values (there are other strategies to handle missing data but we use the simplest option here)
cancer_data <- cancer_data %>% drop_na()


#------------------------------------------------------------------------------------------------------------------------
# now vizualize the dataset to get understanding of the variables and their dependencies
#------------------------------------------------------------------------------------------------------------------------

#histograms of all variables
#are there interesting observations?
#are the classes (esp. our target class "Class") balanced?
cancer_data %>%
  gather() %>%
  ggplot(aes(value)) + #be sure to understand why the variable is called value
  facet_wrap(~ key, scales = "free") +
  geom_bar()

#now separate histogram for each class of "Class" to detect which variables differ between the classes
cancer_data %>%
  gather(key, value, -"Class") %>%
  ggplot(aes(value, fill=Class)) +
  facet_wrap(~ key, scales = "free") +
  geom_bar(alpha=.5, position="identity")

#Based on this. Which features (variables) will be most important for classification?
#------------------------------------------------------------------------------------------------------------------------
# split to test and training dataset
#------------------------------------------------------------------------------------------------------------------------

#create the partitioning indices with the caret function createDataPartition()
idx_train <- createDataPartition(
  y = cancer_data$Class,
  p = 0.8,
  list = FALSE
)

cancer_data_train <- cancer_data[idx_train,]
cancer_data_val <- cancer_data[-idx_train,]


#------------------------------------------------------------------------------------------------------------------------
# train logistic regression on the training dataset
#------------------------------------------------------------------------------------------------------------------------

log_reg_model <- train(Class ~ Cl.thickness + Cell.size + Cell.shape +
                         Marg.adhesion + Epith.c.size + Bare.nuclei +
                         Bl.cromatin + Normal.nucleoli + Mitoses,
                       data = cancer_data_train, method = "glm", family = "binomial")


#------------------------------------------------------------------------------------------------------------------------
# prediction of the outcome variable for the validation data and estimation of the algorithms performance
#------------------------------------------------------------------------------------------------------------------------

#predicting the classes and confusion matrix
pred_log_reg = predict(log_reg_model, newdata = cancer_data_val)
confusionMatrix(data=pred_log_reg, cancer_data_val$Class)

#which are the most important variables?
varImp(log_reg_model)


#------------------------------------------------------------------------------------------------------------------------
# use other algorithms
#------------------------------------------------------------------------------------------------------------------------

#support vector machine
svm_model <- train(Class ~ Cl.thickness + Cell.size + Cell.shape +
                     Marg.adhesion + Epith.c.size + Bare.nuclei +
                     Bl.cromatin + Normal.nucleoli + Mitoses,
                   data = cancer_data_train, method = "svmLinear")
pred_svm = predict(svm_model, newdata = cancer_data_val)
confusionMatrix(data=pred_svm, cancer_data_val$Class)

#random forest
rf_model <- train(Class ~ Cl.thickness + Cell.size + Cell.shape +
                     Marg.adhesion + Epith.c.size + Bare.nuclei +
                     Bl.cromatin + Normal.nucleoli + Mitoses,
                   data = cancer_data_train, method = "rf")
pred_rf = predict(rf_model, newdata = cancer_data_val)
confusionMatrix(data=pred_rf, cancer_data_val$Class)


#------------------------------------------------------------------------------------------------------------------------
# equalize number of examples per class - not really necessary for this dataset
#------------------------------------------------------------------------------------------------------------------------

up_train <- upSample(x = cancer_data_train %>% select(-Class),
                     y = cancer_data_train$Class,
                     yname = "Class") %>% as_tibble()

log_reg_model <- train(Class ~ Cl.thickness + Cell.size + Cell.shape +
                         Marg.adhesion + Epith.c.size + Bare.nuclei +
                         Bl.cromatin + Normal.nucleoli + Mitoses,
                       data = up_train, method = "glm", family = "binomial")
pred = predict(log_reg_model, newdata = cancer_data_val)
confusionMatrix(data=pred, cancer_data_val$Class)
