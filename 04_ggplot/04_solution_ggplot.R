####
# We will use another published data set here to create an
# advanced visualisation.
# Does inhalation injury predict mortality in burns patients or require redefinition?
# see  https://doi.org/10.1371/journal.pone.0185195 for publication
#####
library(tidyverse)
library(readxl)
library(knitr)
library(kableExtra)
library(stringr)

###############################
#
#    importing dataset to R
#
###############################

# manual solutions --> Environment --> Import Dataset 

# solution 1) 
# check working directory with 
getwd()
# read in the dataset from your directory
my_data2 <- read_excel(path = "./04_ggplot/my_data.xlsx", sheet = 1, na = "NA")
# you can write a function to read in several numbered files or files that include certain key words 

# solution 2) 
# download the publication data from Figshare
url1 <- "https://ndownloader.figshare.com/files/9422038"
p1f <- tempfile()
download.file(url1, p1f, mode = "wb")
# read in data. Note that we need to define the NA
my_data <- read_excel(path = p1f, sheet = 1, na = "NA")



############################
#
# working with the dataset
#
############################


# the data set contains mortaility of patients after burns depending on
# whether and where they had inhalation burns (INHdiv)
# first create a new variable named - INHdiv_fac -  from INHdiv that is a
# factor with the levels of INHdiv assigned to new labels such that
# 0 = normal, 1=subjective, 2=upper, and 3=lower

# check which variable type is assigned to INHdiv by R 
class(my_data$INHdiv) # INHdiv is understood as a numeric variable by R 
# which levels does INHdiv take if converted to a factor? 
as.factor(my_data$INHdiv) # levels are 0,1,2,3 

my_data <-
  my_data %>%
  mutate(INHdiv_fac = factor(INHdiv, labels = c("normal", "subjective", "upper", "lower"), 
                             levels = c(0,1,2,3))) 


# first, erase the spelling mistake by renaming the 11th column mortaltiy to mortality 
which(colnames(my_data) == "mortaltiy")
colnames(my_data)[11] <- "mortality"

# create a data frame for a barplot
# group by the new inhalation severity variable and the Pfdivide
# ("We also divided the patients into four groups depending on the PF ratio (>300, 200-300, 100-200, and <100)")
# Be aware! The smaller the lower the PFratio the higher the Pfdivide factor!
# you will need the mean of mortality  for each level of inhalation injury (INHdiv)

plot_data <-
  my_data %>%
  group_by(INHdiv_fac, Pfdivide) %>%
  summarise(
    mean_mort = mean(mortality),
  )

# create a barplot from this with mean mortality on y axis and Pfdivide on x axis
# create a facet for each severity level
# make nice axis labels
p.1 <- ggplot(aes(y = mean_mort, x = Pfdivide), data = plot_data) +
  geom_bar(stat = "identity") + #alternative => geom_col 
  facet_wrap(~INHdiv_fac) +
  theme_classic() +
  ylab("Mean mortality") +
  xlab("Pfdivide")
p.1

p.1a <- ggplot(aes(y = mean_mort, x = Pfdivide), data = plot_data) +
  geom_col() + #alternative => geom_col 
  facet_wrap(~INHdiv_fac) +
  theme_classic() +
  ylab("Mean mortality") +
  xlab("Pfdivide")
p.1a
# problem is we transformed a continuous variable (PF Ratio) to a factorial variable
# is there a way to plot a continuous variable
# if the dependent variable is 0 and 1?
# how about this

#rename the column "PF ratio" to PFratio
names(my_data)[8] <- c("PFratio")
ggplot(aes(y = mortality, x = PFratio), data = my_data) +
  geom_point() +
  geom_smooth()
# this is not a nice representation!
# we need something better!
# see for example here:
# https://doi.org/10.1890/0012-9623(2004)85[100:ANMOPT]2.0.CO;2
# also as pdf on osf
# first summarise the data in a histogram format
# Summarise data to create histogram counts
# what is the min and max age?
min(my_data$PFratio)
max(my_data$PFratio)
findInterval(my_data$PFratio, seq(20, 935, 10))

hist_data <-
  my_data %>%
  # first add new variable bin_number  that divides PFRatio in steps of 10
  # use the findInterval() function to assign the interval to each data point
  mutate(bin_number = findInterval(PFratio, seq(20, 935, 10))) %>%
  # then group by dead/alive and the bin_number
  group_by(mortality, bin_number) %>%
  # count the total number in the groups
  summarise(n = n()) %>%
  # if patients are dead, we want them to show on top with histogram on top so you need to
  # calculate in this case the percentage as 1-percentage
  mutate(
    pct = ifelse(mortality == 0, n / sum(n), 1 - n / sum(n)),
    bin = seq(20, 935, 10)[bin_number]
  )
######
# now we create a the plot
#####
ggplot() + # this just sets an empty frame to build upon
  # first add a histopgram with geom_segment use the help of geom_segment
  geom_segment(
    data = hist_data, linewidth = 2, show.legend = FALSE,
    aes(x = bin, xend = bin, y = mortality, yend = pct, colour = factor(mortality))
  ) +
  # then predict a logistic regression via stat_smooth and the glm method (we will cover the details in the next session)
  stat_smooth(data = my_data, aes(y = mortality, x = PFratio), 
              method = "glm", method.args = list(family = "binomial")) +
  # some cosmetics
  scale_y_continuous(limits = c(-0.02, 1.02)) +
  scale_x_continuous(limits = c(10, 950)) +
  theme_bw(base_size = 12) +
  ylab("Patient Alive=0/Dead=1") +
  xlab(expression("PaO"[2] * "/FiO"[2] * " (PF) ratio"))
######
# do the same thing for the four inhale burns groups separately
#####
hist_data <-
  my_data %>%
  # first add new variable that codes breaks
  mutate(bin_number = findInterval(PFratio, seq(20, 935, 10))) %>%
  # then group by dead/alive and the breaks
  group_by(INHdiv_fac, mortality, bin_number) %>%
  # count
  summarise(n = n()) %>%
  # if patients are dead, we want them to show on top with histogram on top so you need to
  # calculate in this case the percentage as 1-percentage
  mutate(pct = ifelse(mortality == 0, n / sum(n), 1 - n / sum(n)), bin = seq(20, 935, 10)[bin_number])
######
# again create the plot
#####
ggplot() + # this just sets an empty frame to build upon
  # set the four panels
  facet_wrap(~INHdiv_fac) +
  # first add a histopgram with geom_segment use the help of geom_segment
  geom_segment(
    data = hist_data, size = 2, show.legend = FALSE,
    aes(x = bin, xend = bin, y = mortality, yend = pct, colour = factor(mortality))
  ) +
  # then predict a logistic regression via stat_smooth and the glm method
  # (we will cover the details in the next session)
  stat_smooth(data = my_data, aes(y = mortality, x = PFratio), method = "glm", method.args = list(family = "binomial")) +
  # some cosmetics
  scale_y_continuous(limits = c(-0.02, 1.02)) +
  scale_x_continuous(limits = c(10, 950)) +
  theme_bw(base_size = 12) +
  ylab("Patient Alive=0/Dead=1") +
  xlab(expression("PaO"[2] * "/FiO"[2] * " (PF) ratio"))



################################
#
#   Additional Exercise
#
################################




########
# outlier detection for PF ratio
# check which data points are outliers in boxplot
########
# first create a function
is_outlier <- function(x) {
  return(x < quantile(x, 0.25) - 1.5 * IQR(x) | x > quantile(x, 0.75) + 1.5 * IQR(x))
}

# now print outlier labels (in this case the row number)
my_data %>%
  mutate(row_number = seq(1:nrow(my_data))) %>%
  mutate(outlier = ifelse(is_outlier(PFratio), row_number, as.numeric(NA))) %>%
  ggplot(., aes(x = INHdiv_fac, y = PFratio)) +
  geom_boxplot() +
  geom_text(aes(label = outlier), size = 2, position = position_stack(vjus = 0.1), na.rm = TRUE, hjust = -0.3)
# not ideal but a good starter
library(ggforce)
my_data %>%
  mutate(row_number = seq(1:nrow(my_data))) %>%
  mutate(outlier = ifelse(is_outlier(PFratio), row_number, as.numeric(NA))) %>%
  ggplot(., aes(x = INHdiv_fac, y = PFratio)) +
  geom_boxplot() +
  geom_sina(aes(x = INHdiv_fac, y = PFratio), method = "counts", scale = F) +
  geom_text(aes(label = outlier), size = 2, nudge_x = 0.15, na.rm = TRUE, hjust = -0.3)
