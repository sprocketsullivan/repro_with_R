####
# In this exercise we will:
# 1. read in data from an online source
# 2. use the tidyverse to create a results table
# For this we will use the following publication: 
# https://doi.org/10.1038/s41598-018-27482-2
# Efficacy of two different dosages of levofloxacin in curing Helicobacter pylori infection:
# A Prospective, Single-Center, randomized clinical trial
#####
# first load necessary libraries
library(tidyverse)
library(readxl)
library(knitr)
library(kableExtra)
library(stringr)

# download the publication data from Figshare
# this will generate a temprary file
url1 <- "https://ndownloader.figshare.com/files/11183900"
p1f <- tempfile()
download.file(url1, p1f, mode = "wb")
# read in data. This is an Excel file so we need to use read.xls
# Note that we need to define the NA
# NA stands for not available and is a special place holder in R
my_data <- read_excel(path = p1f, sheet = 1, na = "NA")
# the first table cannot be recreated due to missing data
# the second table contains the main results of the paper
# Lets recreate this table and the stats...
# all variable names have spaces in variable names which is unfortunate so we create new (easier)
# variable names
names(my_data) <- c("id", "baseline", "treatment", "outcome_treatment", "adverse_drug_reaction", "adverse_drug_reaction_content", "adverse_drug_reaction_classified", "study_completed", "reason_uncompleted", "per_protocol_analysis")
#####
# we will now try to replciate the table
# this will look slightly different from the original
####
# remove the group statement before the treatment
my_data$treatment <-
  str_remove(my_data$treatment, pattern = "group ")
##########
# create a first table using the tidyverse
# you will need to start with the data set
# then group it by treatment
# and summarise how many outcomes are negative
# how many outcomes there are in total
# and the percentage of the two
##########################
table_data1 <-
  my_data %>%
  group_by(treatment) %>%
  summarise(
    n_outcome = sum(outcome_treatment == "Negative", na.rm = T),
    N_outcome = n(),
    Percentage = n_outcome / N_outcome
  )
# now for the second row create a similar table but only on those
# patients that finished the study
table_data2 <-
  my_data %>%
  group_by(treatment) %>%
  filter(per_protocol_analysis == "Yes") %>%
  summarise(
    n_outcome = sum(outcome_treatment == "Negative", na.rm = T),
    N_outcome = n(),
    Percentage = n_outcome / N_outcome
  )

# combine both in a table
# add a  column calles Analysis (ITT and PP as levels) and change it to the
# first column thorugh the select command
# make use of the cheat sheet!
table_data <-
  bind_rows(table_data1, table_data2) %>%
  mutate(Analysis = rep(c("ITT", "PP"), each = 2)) %>%
  select(Analysis, everything())

# now calculate whether there is a significant difference between the two groups
# this is done by comparing two proportions via prop.test
# read in the help funciton what input prop.test needs
p.1 <- prop.test(x = table_data$n_outcome[1:2], n = table_data$N_outcome[1:2])
p.2 <- prop.test(x = table_data$n_outcome[3:4], n = table_data$N_outcome[3:4])

prop.test(x = c(155,200), n = c(159,200))
fisher.test(x = matrix(c(155,159,200,200),nrow=2))
chisq.test(x = matrix(c(155,159,200-155,200-159),nrow=2))

table_data$p <- c(NA, p.1$p.value, NA, p.2$p.value)
options(knitr.kable.NA = "")
# then print it in a table using the kable command
kable(table_data,
  digits = 2,
  col.names = c("Analysis", "Treatment", "n", "N", "Percentage", "p-value")
) %>%
  kable_styling("striped") %>%
  footnote("ITT = intention-to-treat, PP = per protocol", general_title = "")
#####
# if you are finished early try understand the code below which
# replicates the table as in the publication
#######
########
# as in publication
# do not worry about warning
########
# first row
table_data1 <-
  my_data %>%
  group_by(treatment) %>%
  summarise(
    n_outcome = sum(outcome_treatment == "Negative", na.rm = T),
    N_outcome = n(),
    Percentage = n_outcome / N_outcome * 100
  ) %>%
  unite("Frequency", c(n_outcome, N_outcome), sep = "/") %>%
  nest(value_col = c(Frequency, Percentage)) %>%
  spread(key = treatment, value = value_col) %>%
  unnest(cols=c(A,B),names_repair="universal")
# second row
table_data2 <-
  my_data %>%
  group_by(treatment) %>%
  filter(per_protocol_analysis == "Yes") %>%
  summarise(
    n_outcome = sum(outcome_treatment == "Negative", na.rm = T),
    N_outcome = n()
  )%>%
  mutate(Percentage = n_outcome / N_outcome * 100) %>% 
  unite("Frequency", c(n_outcome, N_outcome), sep = "/") %>%
  nest(value_col = c(Frequency, Percentage)) %>%
  spread(key = treatment, value = value_col) %>%
  unnest(cols=c(A,B),names_repair="universal")
# put this together
table_data <-
  bind_rows(table_data1, table_data2) %>%
  mutate(Analysis = c("ITT", "PP")) %>%
  mutate(p = c(p.1$p.value, p.2$p.value)) %>%
  select(Analysis, everything())
# we will use the statistical test p.1 and p.2 from above
# so bes ure to program the first bit before trying this
# plot the table
options(knitr.kable.NA = "")
kable(table_data,
  col.names = c("Analysis", rep(c("Frequency (n/N)", "Eradication Rate (%)"), 2), "p-value"),
  digits = 2
) %>%
  kable_styling("striped") %>%
  add_header_above(c("", "Group A (N = 200)" = 2, "Group B (N = 200)" = 2, ""), align = "left") %>%
  footnote("ITT = intention-to-treat, PP = per protocol", general_title = "")

#####
# try to redo the third table in the paper
####
table_data3 <-
  my_data %>%
  filter(adverse_drug_reaction == "Yes") %>%
  group_by(adverse_drug_reaction_content, treatment) %>%
  summarise(number_obs = n()) %>%
  spread(key = treatment, value = number_obs) %>%
  arrange(adverse_drug_reaction_content)

table_data4 <-
  my_data %>%
  filter(adverse_drug_reaction == "Yes") %>%
  group_by(adverse_drug_reaction_classified, treatment) %>%
  summarise(number_obs = n()) %>%
  spread(key = treatment, value = number_obs) %>%
  arrange(adverse_drug_reaction_classified)
