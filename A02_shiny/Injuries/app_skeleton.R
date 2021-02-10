library(tidyverse)
library(vroom)
library(shiny)

if (!exists("injuries")) {
  injuries <- vroom::vroom("injuries.tsv.gz")
  products <- vroom::vroom("products.tsv")
  population <- vroom::vroom("population.tsv")
}

#<< ui
ui <- fluidPage(
  fluidRow(
    #this will create a drop down box with the product titles 
    #the setNames function will link the code to the title
    #i.e. you will see the name in the box but the input will be the actual product code
    column(6,
           selectInput("code", "Product", setNames(products$prod_code, products$title))
    )
  ),
  fluidRow(
    # here you will need to print three tables 
    # one in each column
    # the name of each table has to identical to the name defined for the output in the server part
    
  ),
  fluidRow(
    #underneath plot the rate of occurance per age group
  )
)
#>>

#<< server
server <- function(input, output, session) {
  # first create a subset of the original data using the code from the input
  # remember that this needs to react to changes made to the input window
  selected <-
  # define the three output variables with the renderTable function 
  
  
  # now summarise the count per age group and sex from your selected variable
  # use again a reactive statement
  # bonus if you correct this for the total number of people in this age group
  # this information is in the population file
  summary <- 
    
  
  # now take this summary and plot it using the renderPlot function
  # assign this to the appropriate output variable that you refer to in the UI section of your app  
  output$age_sex <- 
    
}


shinyApp(ui, server)