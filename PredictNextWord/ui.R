library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Coursera Data Science Specialisation Capstone Word Prediction Project"),
  
  # Sidebar with input
  sidebarLayout(
    sidebarPanel(
      textInput("txtInput", label = "Input", value = "Where are"),
      br(),
      submitButton("Predict Next Word")
    ),
    
    # Instructions and Prediction outcome
    mainPanel(
      h3("Instructions:"),
      p("Enter the input word(s) for the prediction. When ready, click the 'Predict Next Word' button or press the Enter key."),
      h3("Predicted Word:"),
      textOutput("txtOutput")
    )
  )
))
