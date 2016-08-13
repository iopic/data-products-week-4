#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

data<-read.csv("DC_weather.csv",stringsAsFactors = FALSE)

#Break out year, month and day columns from the date column
data<-data %>%
  mutate(year=as.numeric(substring(DATE,first=1,last=4)),
         month=as.numeric(substring(DATE,first=5,last=6)),
         Date=parse_date_time(DATE,"%Y%m%d"),
         str_month=month.name[month]) %>%
  gather(key=temp_type,value=temperature,EMXT:EMNT)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$tempPlot <- renderPlotly({
    
    #set range based on input
    year_range<-seq(input$inputYear[1],input$inputYear[2],1)
    
    #set temp type based on input
    tempType<-ifelse(input$inputTemp=="Max","EMXT","EMNT")
    
    plot<-data %>%
      filter(str_month==input$inputMonth,
             year %in% c(year_range),
             temp_type==tempType) %>%
      ggplot(aes(x=Date,y=temperature))+
      geom_line()+
      geom_smooth()+
      labs(y="Temperature",title=paste(input$inputTemp,"temps across time in DC for",input$inputMonth))+
      theme(
        panel.background=element_blank())
    ggplotly(plot)
  })
  
})
