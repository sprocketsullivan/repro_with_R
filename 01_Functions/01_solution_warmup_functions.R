# We start by reading in a dataset into the R-environment 

df_hw <- read.csv("./01_Functions/df_hw")

df_hw <- 
  df_hw %>%
  select("id", "height", "weight")

# The dataset contains height and weight measures 
# of 25000 individuals 
dim(df_hw)
colnames(df_hw) 
head(df_hw)


# We liked to retrive a number of descriptive measures from the 
# dataset and therefore create the function descriptive_stats
# The function takes the input "data" (a dataframe) and prints 
# means and standard deviations for height and weight 
# Also, within the function we use the plot() function to create 
# a scatter plot showing the relation between height and weight 

# Start by writing the function 
descriptive_stats <- function(data) {
  print(mean(data$height)) 
  print(sd(data$height))
  print(mean(data$weight))
  print(sd(data$weight))
  plot(data$weight ~ data$height)
}

# Now apply the function on df_hw 
descriptive_stats(df_hw)

# We now create a function to calculate the BMI from the 
# height and weight values 

BMI_check <- function(data) {
  BMI <- (data$weight)/data$height^2
  for (k in 1:length(BMI)){
  if (BMI[k] > 25) {
    print(k)
  }
  }

}

BMI_check(df_hw)




