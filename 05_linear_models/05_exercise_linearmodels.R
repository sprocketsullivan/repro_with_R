########
# stats Analysis of
# Lancet paper from
#########
source("./05_linear_models/read_in_before_exercise.R")
# igrnore warnings...
# This reads in and prepares a data set from a lancet paper
# The International Stroke Trial (IST): a randomised trial of
# aspirin, subcutaneous heparin, both, or neither among 19 435
# patients with acute ischaemic stroke
# full paper under: https://osf.io/wyk6n/
# Dependent variable: Mortality (Variable: DEAD_bin in my_data, coded as 0 and 1)
# independent variables are the treatment (HEP,ASP in my_data)
# excute next line to see a plot
p.1
# We want to know whether survival depends on factors treatment and gender
# We start with a very simple glm with only gender as a dependent variable
m.1 <- glm(DEAD_bin ~ SEX, family = binomial, data = my_data)
# get an overview of the model
summary(m.1)
# calculate significance for SEX
# how is this different from the summary function above?
anova(m.1, test = "LRT")
# calculate odds ratio
exp(coef(m.1))
library(MASS)
exp(confint(m.1))
invlogit(coef(m.1)[1])
invlogit(coef(m.1)[1] + coef(m.1)[2])
# create a new variable that is
my_data$treatment <- interaction(my_data$HEP, my_data$ASP)
# now calculate a model with treatment
m.2 <- 
summary(m.2)
anova(m.2, test = "LRT")
# do the same as above only execute this command before:
my_data$treatment <- relevel(my_data$treatment, ref = 4)
m.2a <- 
summary(m.2a)
levels(my_data$treatment)
anova(m.2a, test = "Chisq")
# now add an interaction with gender use * to indicate a full interaction
m.3 <- 
summary(m.3)
anova(m.3, test = "Chisq")
# calculate a model without interaction
m.4 <- 
summary(m.4)
anova(m.4, test = "Chisq")
library(bbmle)
AICtab(m.1, m.2, m.3, m.4)
