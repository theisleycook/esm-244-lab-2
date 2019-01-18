# WE ARE NOT IN R MARKDOWN SO WE MUST WRITE NOTES WITH #

library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

# Now get data

marvel <- read_csv('marvel-wikia-data.csv')
# there are NAs in the sex column, so let's replace with 'not specified'

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified"

# create UI

ui <- fluidPage(
  
  theme = shinytheme('slate'),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side",
                   "Choose a side",
                   c("Good Characters",
                     "Bad Characters",
                     "Neutral Characters"))
    ),
    
    mainPanel(
      plotOutput(outputId = "marvelplot")
      
    )
  )
  
  
)

# THE BRAINS

server <- function(input,output) {
  
  output$marvelplot <- renderPlot({
    
    ggplot(filter(marvel, ALIGN == input$side), aes(x=Year)) +
      geom_bar(aes(fill = SEX), position = "fill") +
      theme_dark()

    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

