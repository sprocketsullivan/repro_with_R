# this analysis is based on the paper
# Airway obstruction and bronchial reactivity from age 1 month until 13 years in children with asthma: A prospective birth cohort study
# by Hallas et al.  https://doi.org/10.1371/journal.pmed.1002722
# the main dataset is an excel file pmed.1002722.s002.xlsx
# load some libraries
library(arm)
library(tidyverse)
library(readxl)
library(car)
library(lmerTest)
# read in data pmed.1002722.s002.xlsx
my_data <-
  read_xlsx("./06_linear_mixed_models/pmed.1002722.s002.xlsx") %>%
  # remove non defined
  filter(Asthma_ever_0_to_13yrs != "Not defined") %>%
  # create numeric variables asthma and visit from Asthma_ever_0_to_13yrs and Visitage
  mutate(asthma = as.numeric(Asthma_ever_0_to_13yrs), visit = as.numeric(Visitage))
# make a simple dot plot of the variable FEV1z
p.1 <- ggplot(aes(y = FEV1z, x = visit, col = factor(asthma)), data = my_data) +
  geom_jitter()
plot(p.1)
# make a boxplot
p.2 <- ggplot(aes(x = factor(visit), y = FEV1z, col = factor(asthma)), data = my_data) +
  geom_boxplot()
plot(p.2)
# calculate a simple linear mixed model with Identifier as a random effect on the Intercept
m.1 <- lmer(FEV1z ~ factor(asthma) + (1 | Identifier), data = my_data)
display(m.1)
confint(m.1)
# a qqPlot of the random variables
randoms <- unlist(ranef(m.1, condVar = TRUE))
qqPlot(randoms)
# residuals against fitted values
plot(m.1)
# qqplot residuals
qqPlot(resid(m.1))
# qqplot of the random effects
source("./06_linear_mixed_models/caterpillar.R")
ggCaterpillar(ranef(m.1, condVar = TRUE), QQ = T, likeDotplot = FALSE)
# anova method
Anova(m.1)
m.2 <- lm(FEV1z ~ factor(asthma), data = my_data)
summary(m.2)
m.3 <- glmer(asthma ~ FEV1z + sRawz + PDz + (1 | Identifier), data = my_data, family = binomial)
display(m.3)
