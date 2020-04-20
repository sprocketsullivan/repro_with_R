# # load libraries
# # check.packages function: install and load multiple R packages.
# # Check to see if packages are installed. Install them if they are not, then load them into the R session.
# check.packages <- function(pkg) {
#   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
#   if (length(new.pkg)) {
#     install.packages(new.pkg, dependencies = TRUE)
#   }
#   sapply(pkg, require, character.only = TRUE)
# }
#
# # Usage example
# packages <- c("tidyverse", "arm", "bbmle")
# check.packages(packages)
library(tidyverse)
library(arm)
# read in data
# my_data <- read_csv("IST_corrected.csv")
# alternative directly from the web
my_data <- read_csv(url("https://datashare.is.ed.ac.uk/bitstream/handle/10283/128/IST_corrected.csv?sequence=5&isAllowed=y"))
# redo Table 1 from Lancet study
# first create a new variable DDEADC_verb
my_data$FDEAD_verb <- factor(my_data$FDEADC, labels = c("unknown", "Initial stroke", "Recurrent ischaemic stroke", "Haemorrhagic stroke", "Coronary heart disease", "Pulmonary embolism", "Extracranial haemorrhage", "Other vascular", "Non-vascular"))
my_data$DDEAD_verb <- factor(my_data$DDEADC, labels = c("unknown", "Initial stroke", "Recurrent ischaemic stroke", "Haemorrhagic stroke", "Coronary heart disease", "Pulmonary embolism", "Extracranial haemorrhage", "Other vascular", "Non-vascular"))
# Create Variable for Hep/Asp
my_data$HEP <- ifelse((my_data$RXHEP == "L" | my_data$RXHEP == "M"), "Heparin", "No_Heparin")
my_data$ASP <- ifelse(my_data$RXASP == "Y", "Asprin", "No Aspirin")
my_data$HEP <- ifelse((my_data$RXHEP == "L" | my_data$RXHEP == "M"), "Heparin", "No_Heparin")
my_data$ASP <- ifelse(my_data$RXASP == "Y", "Asprin", "No Aspirin")
table_dt <-
  my_data %>%
  group_by(HEP, DDEAD_verb) %>%
  filter(!is.na(DDEAD_verb)) %>%
  summarise(likely_cause = n()) %>%
  spread(HEP, likely_cause)
names(table_dt)[1] <- c("Deaths and likely causes")
my_data$DEAD_bin <- ifelse(my_data$DDEAD == "Y", 1, 0)

plot_data <-
  # based on my_data
  my_data %>%
  # create a new variable (T/F) whether a patient is dead from DDEAD variable
  # reason for this is: we cannot calculate means across "Y" and "N" values
  mutate(DEAD_binary = if_else(DDEAD == "Y", 1, 0)) %>%
  # group the analysis by the variables of interest (SEX, Heparin or Aspirin Treatment)
  group_by(SEX, HEP, ASP) %>%
  # Now summarise the percentage and SEM, calculate for the plot also mean plus/minus sem
  summarise(
    N = n(),
    perc_dead = mean(DEAD_binary, na.rm = T),
    sd_dead = mean(DEAD_binary, na.rm = T),
    sd_pos = perc_dead + sd_dead / sqrt(N),
    sd_neg = perc_dead - sd_dead / sqrt(N)
  )

# now create a barplot with error bars
# how can you create a combined factor from ASP HEP?
# also create two separate facets for male and female

p.1 <- ggplot(aes(y = perc_dead, x = factor(paste(HEP, ASP)), fill = factor(paste(HEP, ASP))), data = plot_data) +
  geom_bar(stat = "identity") +
  facet_wrap(~SEX) +
  theme_classic() +
  xlab("Treatment") +
  ylab("Percentage dead patients") +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("dark blue", "light blue", "blue", "light grey"))
