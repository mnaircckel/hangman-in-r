
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Hangman in R"),
  
  sidebarLayout(
    sidebarPanel(
      h5("Try to guess the phrase!"),
      pre(textOutput("phrase")),
      h4(textOutput("hasWon")),
      textInput("letter","Guess a letter: "),
      actionButton("guess","Guess!"),
      fluidRow(
        column(width = 10,
               textOutput("guessVerify"),
               textOutput("guessLetter")
        ))
    ),

    mainPanel(
      imageOutput("stickFigure")
    )
    
  )
))
