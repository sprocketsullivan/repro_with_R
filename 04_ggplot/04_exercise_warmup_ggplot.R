library(tidyverse)
library(ggpubr)
#install.packages("ggpubr")

# Today we use the R-package viridis with provides colorblind-friendly 
# color scale. Please load it into the environment. (If needed, install first)
#install.packages("viridis")
library(viridis)

# R provides built-in datasets which can be loaded and used to practice
# You can take a look at all available datasets with this command: 

help(package="datasets")

# Let's load the dataset "airquality" for our tidyverse warm-up exercise
# The "airquality" dataset provides New York Air quality measurements from May - September 
# for a specific year. 

data("airquality")

# Notice that "airquality" is immediately available in the environment 
# You should not use an assignment operator to load the built-in dataset into the environment. 

airquality$Month <- as.factor(airquality$Month)
levels(airquality$Month) <- c("May", "June", "July", "August", "September")


# Create a figure displaying the distribution of temperature measures
# for each month in a violin plot. Add axis labels and a title as well
# by using the labs command. Save the plot as fig1 

fig1 <- 
  ggplot(data = ) + 
  geom_violin(aes(x = , y = , fill = ))+
  labs()+ 
  scale_fill_viridis(discrete = TRUE)+ # we use the color-scale provided in viridis package
  theme_classic()+
  theme(legend.position = "none") # removes the legend for fill 

plot(fig1)


# Now we would like to explore the relationship between temperature 
# and ozone measures. Create a scatter plot using geom_point() and 
# add a smoother with stat_smooth, add axis-labels and title
# Save the figure as fig2 

fig2 <- 
  ggplot() + 
  geom_point(, 
             alpha = 0.5)+ # adjust opacity with alpha to improve visibility
  stat_smooth(aes(x = , y = ), method = "loess")+ 
  labs()+
  theme_classic()

plot(fig2)


# As a last warm-up exercise we want to look 
# at the relationship between Temperature and Ozone 
# stratified by Wind measure. To accomplish this
# we use the command findInterval, and apply 
# it over a sequence of values from the minimal to maximal temperature 
# measures 

min(airquality$Wind)
max(airquality$Wind)
findInterval(airquality$Wind, seq(1.7, 20.7, 4))
# bins 1 - 5 were created for the values of Wind 

# We add the binned Wind measures to the dataframe 
airquality$Wind_bin <- 


# Now create a scatter plot stratified by the binned values of Wind 
# with the help of facet_wrap(), add axis-labels and a title 
# Save as fig3.  
fig3 <- 
  ggplot() + 
  facet_wrap(, 
             scales = "free_x")+ # has to be added so that all x-axis values are displayed
  geom_point(, 
             alpha = 0.5)+
  labs()

plot(fig3)


# You can then choose to combine figure with 
# ggarrange() from ggpubr package 
ggpubr::ggarrange(fig1, fig2, 
                  nrow = 1, 
                  labels = c("a)", "b)")) 

