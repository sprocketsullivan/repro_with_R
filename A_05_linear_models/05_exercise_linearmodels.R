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
m1 <- glm(DEAD_bin ~ SEX, family = binomial, data = my_data)
# get an overview of the model
summary(m1)

# summaries in R are pretty messy 
# we like tidy objects, so we create a tidy data frame with relevant info from the summary
m1_tidy <- tidy(m1)
m1_tidy
# glance(m1)
# augment(m1)

invlogit(m1_tidy$estimate[1])
invlogit(m1_tidy$estimate[1] + m1_tidy$estimate[2])
# invlogit(coef(m1)[1])
# invlogit(coef(m1)[1] + coef(m1)[2])

#calculate significance for SEX
#how is this different from the summary 
m1_anova <- anova(m1, test = "LRT")
m1_anova_tidy <- tidy(m1_anova)

# calculate odds ratio
exp(coef(m1))
exp(confint(m1))

# or again use the tidy() command with specifications
m1_tidy_OR <- tidy(m1, exponentiate = TRUE, conf.int = TRUE)
m1_tidy_OR

# create a new variable that is
my_data$treatment <- interaction(my_data$HEP, my_data$ASP)

# now calculate a model with treatment
m2 <- 
  summary(m2)
anova(m2, test = "LRT")

# create a tidy version of the summary
m2_tidy <- 
  # create a tidy version of the summary with odds ratios and confidence intervals
  m2_tidy_OR <- 
  
  # do the same as above only execute this command before:
  my_data$treatment <- relevel(my_data$treatment, ref = 4)

m2a <- 
  summary(m2a)
levels(my_data$treatment)
anova(m2a, test = "Chisq")

# create a tidy version of the summary
m2a_tidy <- 
  # create a tidy version of the summary with odds ratios and confidence intervals
  m2a_tidy_OR <- 
  
  # now add an interaction with gender use * to indicate a full interaction
  m3 <- 
  summary(m3)
anova(m3, test = "Chisq")

# calculate a model with treatment and gender but without interaction
m4 <- 
  summary(m4)
anova(m4, test = "Chisq")

# compare the AIC for the different models
AICtab(m1, m2, m3, m4)