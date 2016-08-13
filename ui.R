#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

library(lubridate)
library(plotly)
library(tidyr)




# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploring DC Weather"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("inputYear",
                   "Year Range:",
                   min = 1980,
                   max = 2016,
                   value = c(1990,2005),
                   sep=""),
       selectInput("inputMonth",
                   "Select month of interest",
                   choices=month.name),
       selectInput("inputTemp",
                   "Examine max or min temperatures",
                   choices=c("Max","Min"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      h3("Instructions"),
      ("Use the inputs to the left to explore trends in maximum and minimum monthly temperatures in Washington,D.C."),
      plotlyOutput("tempPlot")
    )
  )
))
