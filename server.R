
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

library(shiny)
source("helpers.R")

# Global constants used for hangman
con <- file("phrases.txt","r")
WORD_BANK <- readLines(con, warn = FALSE)
close(con)
ALPHABET <- list('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')

shinyServer(function(input, output) {
  
  values <- reactiveValues()
  
  # Get a phrase from the world bank
  phrase <- sample(WORD_BANK,1)
  values$phrase <- phrase
  
  # Create values to manage Hangman game logic
  values$blank_phrase <- create_blank_phrase(phrase,ALPHABET)
  values$guesses <- 6
  
  output$guessLetter <- eventReactive(input$guess, {
    if(values$guesses > 0){
      if(verify() == " "){
        values$blank_phrase <- update_blank_phrase(values$phrase, values$blank_phrase, input$letter)
        if(!phrase_contains_letter(values$phrase, values$blank_phrase, input$letter)){
          values$guesses = values$guesses-1
          paste0("You guessed \"", input$letter, "\", which is not contained in the phrase. Try again.")
        }
        else{
          paste0("Your guess of \"", input$letter, "\" was correct!")
        }
      }
      else{
        paste("")
      }
    }
    else{
      paste("")
    }
  })
  
  
  output$restart <- eventReactive(input$restart, {
    values$phrase <- sample(WORD_BANK,1)
    values$blank_phrase <- create_blank_phrase(values$phrase,ALPHABET)
    values$guesses <- 6
  })
  
  
  output$phrase <- eventReactive(input$guess, {
    paste(values$blank_phrase, collapse = " ")
  })
  
  output$phrase <- renderText({
    paste(values$blank_phrase, collapse = " ")
  })
  
  
  
  verify <- renderText({
    if(input$letter == ''){
      paste("  ")
    }
    else if(is.na(match(tolower(input$letter),list('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')))){
      paste0("Invalid input \"", input$letter, "\", you must enter a letter.")
    }
    else{
      paste(" ")
    }
  })
  
  output$guessVerify <- renderText({
    verify()
  })
  
  output$hasWon <- renderText({
    if(player_has_won(values$blank_phrase)){
      paste("You have correctly guessed the phrase!")
    }
    else if(values$guesses < 1){
      paste0("Oh no, you have been hung! The phrase was \"", values$phrase,"\"")
    }
    else if(values$guesses == 1){
      paste("You only have", values$guesses, "strike left!")
    }
    else{
      paste("You have", values$guesses, "strikes left..")
    }
  })
  
  output$stickFigure <- renderImage({
    if(values$guesses < 1){ 
      return(list(
        src = "images/Hangman.jpg",
        contentType = "image/jpeg",
        alt = "Hangman"
      ))
    }
    else if(values$guesses == 1){ 
      return(list(
        src = "images/Hangman1.png",
        contentType = "image/png",
        alt = "Hangman"
      ))
    }
    else if(values$guesses == 2){ 
      return(list(
        src = "images/Hangman2.png",
        contentType = "image/png",
        alt = "Hangman"
      ))
    }
    else if(values$guesses == 3){ 
      return(list(
        src = "images/Hangman3.png",
        contentType = "image/png",
        alt = "Hangman"
      ))
    }
    else if(values$guesses == 4){ 
      return(list(
        src = "images/Hangman4.png",
        contentType = "image/png",
        alt = "Hangman"
      ))
    }
    else if(values$guesses == 5){ 
      return(list(
        src = "images/Hangman5.png",
        contentType = "image/png",
        alt = "Hangman"
      ))
    }
    else if(values$guesses == 6){ 
      return(list(
        src = "images/Hangman6.png",
        contentType = "image/png",
        alt = "Hangman"
      ))
    }
  }, deleteFile = FALSE)
  

})
