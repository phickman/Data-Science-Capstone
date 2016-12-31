library(shiny)
source("predictNextWord.R")

shinyServer(function(input, output) {
  output$txtOutput <- renderText({
    predictNextWord(input$txtInput)
  })
})