
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Shiny Framework - Hangman in R"),
  
  sidebarLayout(
    sidebarPanel(
      h5("Try to guess the phrase!"),
      pre(textOutput("phrase")),
      pre(textOutput("hasWon"),
          textOutput("guessLetter")),
      span(textOutput("guessVerify"), style = "color:red"),
      textInput("letter","Enter a letter: "),
      actionButton("guess","Guess"), 
      actionButton("restart","Restart")
    ),

    mainPanel(
      imageOutput("stickFigure"),
      uiOutput("restart")
    )
    
  )
))
