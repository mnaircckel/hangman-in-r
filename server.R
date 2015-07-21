
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

library(shiny)
source("helpers.R")

# Global constants used for hangman
WORD_BANK <- list("Best of both worlds")
ALPHABET <- list('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')

shinyServer(function(input, output) {
  
  # Get a phrase from the world bank
  phrase <- sample(WORD_BANK,1)
  
  # Create values to manage Hangman game logic
  values <- reactiveValues()
  values$blank_phrase <- create_blank_phrase(phrase,ALPHABET)
  values$guesses <- 4
  
  output$guessLetter <- eventReactive(input$guess, {
    if(values$guesses > 0){
      if(verify() == " "){
        values$blank_phrase <- update_blank_phrase(phrase, values$blank_phrase, input$letter)
        if(!phrase_contains_letter(phrase, values$blank_phrase, input$letter)){
          values$guesses = values$guesses-1
          paste0("You guessed \"", input$letter, "\", which is not contained in the phrase. Try again.")
        }
        else{
          paste0("Your guess of \"", input$letter, "\" was correct!")
        }
      }
      else{
        paste0("")
      }
    }
    else{
      paste0("")
    }
  })
  
  
  output$phrase <- eventReactive(input$guess, {
    paste(values$blank_phrase, collapse = " ")
  })
  
  output$phrase <- renderText({
    paste(values$blank_phrase, collapse = " ")
  })
  
  
  verify <- renderText({
    if(input$letter == ''){
      paste("")
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
      paste0("You are all out of guesses! The phrase was \"", phrase,"\"")
    }
    else{
      paste("You have", values$guesses, "incorrect guess(es) left.")
    }
  })
  
  output$stickFigure <- renderImage({
      return(list(
        src = "images/Hangman.jpg",
        contentType = "image/jpeg",
        alt = "Hangman"
      ))

  }, deleteFile = FALSE)
  

})
