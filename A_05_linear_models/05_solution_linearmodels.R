########
# stats analysis of 
# Lancet paper from the International Stroke Trial Collaborative Group (1997)
# full paper under: https://osf.io/wyk6n/
#########
# check your working directory first!

library(broom)
library(MASS)
library(bbmle)

# the next line will also install packages!
source("./read_in_before_exercise.R")
# igrnore warnings...
# This reads in and prepares a data set from a lancet paper
# The International Stroke Trial (IST): a randomised trial of
# aspirin, subcutaneous heparin, both, or neither among 19 435
# patients with acute ischaemic stroke
# Dependent variable: Mortality (Variable: DEAD_bin in my_data, coded as 0 and 1)
# independent variables are the treatment (HEP,ASP in my_data)
# excute next line to see a plot
p.1

# We want to know whether survival depends on factors treatment and gender
# We start with a very simple glm with only gender as a dependent variable
# In this simple model, our predictor has only two categories (F, M), 
# so we are basically comparing two means. 
m1 <- glm(DEAD_bin ~ SEX, family = binomial, data = my_data)
# get an overview of the model
# In the summary, we see two coefficients: intercept and SEXM
# Remember that we have two categories of our predictor SEX: F and M
# One of those is what we call the reference category. This is the intercept.
# This is chosen by R alphabetically, so F (female patients) is the refrence
# to which we compare the other category (male patients)
# The intercept is the mean of the female patients.
# The SEXM coefficient is the difference between the male and female patients.
# The p-value indicates whether the intercept and the difference 
# between male and female patients is different from 0.
summary(m1)

# summaries in R are pretty messy 
# we like tidy objects, so we create a tidy data frame with relevant info from the summary
m1_tidy <- tidy(m1)
m1_tidy
# glance(m1)
# augment(m1)

# We need to retransform our estimates from the output
# because we used the link function in the glm() command.
# We can do this with the inverse logit function invlogit().
# Note that in order to calculte the estimate for male patients,
# we have to add the intercept (mean of the females) and the coefficient for the males.
invlogit(m1_tidy$estimate[1])
invlogit(m1_tidy$estimate[1] + m1_tidy$estimate[2])

# If you like to know what the difference between the generalized linear model 
# and a linear model is fit a linear model using the lm() function.
# This does not need a link function. 
linear_model <- lm(DEAD_bin ~ SEX, data = my_data)

# In the summary you see that the estimates are very similar to our estimates from the GLM.
# The difference is in the standard error.
# Our dependent variable is binomial (only 0 and 1) and 
# residuals are not normally distributed (as is assumed by lm()).
# The glm() accounts for this different error structure.
# We specify how it does that by the "family" argument. 
summary(linear_model)

# calculate significance for SEX
# How is this different from the summary?
m1_anova <- anova(m1, test = "LRT")
m1_anova_tidy <- tidy(m1_anova)

# With the anova() command we compare our model (that includes SEX as predictor) to 
# a model that includes only the intercept (indicated by the 1).
null_model <- glm(DEAD_bin ~ 1, family = binomial, data = my_data)
summary(null_model)

# calculate odds ratio and the CI around it for our m1 (that includes SEX as predictor)
exp(coef(m1))
exp(confint(m1))

# or again use the tidy() command
m1_tidy_OR <- tidy(m1, exponentiate = TRUE, conf.int = TRUE)
m1_tidy_OR

# create a new variable that is
my_data$treatment <- interaction(my_data$HEP, my_data$ASP)

# now calculate a model with treatment
# This model only differs from m1 in that the predictor has four categories.
# One is again the reference (intercept) and the other three are compared to that refrence.
# Be careful: The reference is chosen alphabetically, so it might not be the reference that
# you intended to use or that is the most reasonable one.
# We change the order for model m2a using the relevel() command.
m2 <- glm(DEAD_bin ~ treatment, family = binomial, data = my_data)
summary(m2)
anova(m2, test = "LRT")

# create a tidy version of the summary
m2_tidy <- tidy(m2)
# create a tidy version of the summary with odds ratios and confidence intervals
m2_tidy_OR <- tidy(m2, exponentiate = TRUE, conf.int = TRUE)

# do the same as above only execute this command before:
# This changes the order of the categories such that we 
# have the "No_Heparin No_Aspirin" (i.e. the control) as reference (intercept)
my_data$treatment <- relevel(my_data$treatment, ref = 4)

m2a <- glm(DEAD_bin ~ treatment, family = binomial, data = my_data)
summary(m2a)
levels(my_data$treatment) # this is to check whether the releveling worked
anova(m2a, test = "Chisq")

# create a tidy version of the summary
m2a_tidy <- tidy(m2a)
# create a tidy version of the summary with odds ratios and confidence intervals
m2a_tidy_OR <- tidy(m2a, exponentiate = TRUE, conf.int = TRUE)

# now add an interaction with gender use * to indicate a full interaction
# With the interaction, the reference (intercept) is the mean of the female patients who
# did not receive Heparin nor Aspirin
m3 <- glm(DEAD_bin ~ treatment * SEX, family = binomial, data = my_data)
summary(m3)
anova(m3, test = "Chisq")

# create a tidy version of the summary
m3_tidy <- tidy(m3)
# create a tidy version of the summary with odds ratios and confidence intervals
m3_tidy_OR <- tidy(m3, exponentiate = TRUE, conf.int = TRUE)

# calculate a model with treatment and gender but without interaction
m4 <- glm(DEAD_bin ~ treatment + SEX, family = binomial, data = my_data)
summary(m4)
anova(m4, test = "Chisq")

# compare the AIC for the different models
AICtab(m1, m2, m3, m4)
