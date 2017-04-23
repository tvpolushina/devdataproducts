#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$mapPlot <- renderLeaflet({
   
    df = data.frame(lat=c(60.587133,60.496755,60.208184,60.185662,60.000338,59.982827,              60.118833,60.371789,60.480914,60.086942), 
                    lng = c(4.853944, 4.932222, 5.070581, 5.487375,5.382361, 6.001715, 6.268992, 6.148006, 6.821605, 6.531497))
    
    
    
    fishicon = makeIcon(
      iconUrl = "https://raw.githubusercontent.com/tvpolushina/devdataproducts/master/logofish.png",
      iconWidth = 215/4, iconHeight = 65/4,
      iconAnchorX = 215/16, iconAnchorY = 65/16
    )
    
    label_a = c("A", "B","C","D","E","F","G","H","I","J")
    df %>% 
      leaflet() %>%
      addTiles() %>%
      addMarkers(icon=fishicon, popup =label_a)
    
  })
  
  output$table1 <- renderTable({
    loccoef<-data.frame("loc"=c("A","B","C","D","E", "F","G","H","I","J"), "salmon"=c(1.23, 1.25, 1.13, 1.14, 0.99, 0.98, 1.03, 0.97, 0.95, 0.93), "cod"=c(1.34, 1.38, 1.23, 0.95, 1.13, 0.89, 0.98, 1.03, 1.04, 0.98),"makrel"=c(0.99, 0.98, 1.03, 1.09, 1.05, 0.87, 0.98, 1.03, 1.12, 1.14))
    indloc<-which(loccoef$loc==input$loc)
    if (input$typefish=="salmon"){
      newsize1<- input$bins/loccoef[indloc,2]*loccoef[6:10,2]
      newsize2<- as.numeric(input$len)/loccoef[indloc,2]*loccoef[6:10,2] 
    }
    if (input$typefish=="cod"){
      newsize1<- input$bins/loccoef[indloc,3]*loccoef[6:10,3]
      newsize2<- as.numeric(input$len)/loccoef[indloc,3]*loccoef[6:10,3] 
    }
    if (input$typefish=="makrel"){
      newsize1<- input$bins/loccoef[indloc,4]*loccoef[6:10,4]
      newsize2<- as.numeric(input$len)/loccoef[indloc,4]*loccoef[6:10,4] 
    }
    
    estsize<-data.frame("Location"=c("F","G","H","I","J"), "EstWeight"= newsize1, "EstLength"=newsize2, "Type"=rep(input$typefish, 5))
       
  })
  
})
