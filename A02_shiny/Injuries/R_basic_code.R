library(tidyverse)
library(vroom)
library(shiny)

if (!exists("injuries")) {
  injuries <- vroom::vroom("injuries.tsv.gz")
  products <- vroom::vroom("products.tsv")
  population <- vroom::vroom("population.tsv")
}
# Bad things can happen when interacting with our environment!
# The data set injuries contains 255k emergency room entries in the US
# with a diganosis (diag), the injured body part (body_part)
# and where it happened (location)
# For each injury there is also a product code in the products table. This has to be linked to the injuries table!
# For the app we want to create three tables
# 1. The diagnosis
# 2. The body part
# 3. And where it happened
# First define a function that will select the cases with a certain product code
# remember that this has to be a reactive function later in the app

select_cases <- function(product_code) {
  injuries %>%
    filter(prod_code == product_code)
}
# code 464 is knives
# to create a table in the app use the renderTable function
# The weight variable will scale the prediction up to total US population
selected <- select_cases(464)
selected %>% count(diag, wt = weight, sort = TRUE)
selected %>% count(body_part, wt = weight, sort = TRUE)
selected %>% count(location, wt = weight, sort = TRUE)

# underneath we want a plot for the development across age and for each sex
# first we create a summary data frame
# we correct this data frame by the total population at risk to get a risk estimate
summary <-
  selected %>%
  count(age, sex, wt = weight) %>%
  left_join(population, by = c("age", "sex")) %>%
  mutate(rate = n / population * 1e4)
# a simple line plot of the number of cases

summary %>%
  ggplot(aes(x = age, y = rate, colour = sex)) +
  geom_line() +
  labs(y = "Estimated number of injuries") +
  theme_grey(15)
