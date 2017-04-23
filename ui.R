#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(leaflet)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hypothetical EcoSystem"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
    
      selectInput("typefish",
                  "Fish:",
                  choices = c('salmon'='salmon', 'cod' = 'cod', 'markel' = 'makrel') ),
      
       sliderInput("bins",
                   "Weight, kg:",
                   min = 0,
                   max = 10,
                   value = 1),
      textInput("len",
                  "Length, cm:",
                  value = 20),
      selectInput("loc",
                  "Location:",
                  choices = c('A'='A', 'B' = 'B', 'C' = 'C', 'D'='D', 'E' = 'E') )
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Map", br(), h4("Select the type of fish (",
                                          span("salmon, cod or makrel", style = "color:blue"),
                                          ") and enter its weight (kg) and length (cm)."),
                           br(),h4("Choose the location where you caught the fish: ",
                                   span("A, B, C, D or E", style = "color:blue"),
                                   "and check estimated size of the same type of fish at locations F, G, H, I and J on tab",
                                   span("Estimation.", style = "color:blue")),
                           br(), leafletOutput("mapPlot")),
                  tabPanel("Estimation", br(),  column(12, tableOutput('table1')
                  ))    
      )
    )
  )
))
