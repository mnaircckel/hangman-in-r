# This script will let the user play hangman
# Author: Marcel Champagne

player_has_won <- function(blank_phrase){
  is.na(match("_",blank_phrase))
}

create_blank_phrase <- function(phrase,ALPHABET) {
  blank_phrase <- rep("",nchar(phrase)) 
  # For loop to put underscores in blank_phrase
  for(i in 1:nchar(phrase)){
    
    if(!is.na(match(tolower(substr(phrase,i,i)),ALPHABET))){
      blank_phrase[i] <- "_"
    }
    else if(substr(phrase,i,i) != " "){
      blank_phrase[i] <- substr(phrase,i,i)
    }
    else{
      blank_phrase[i] <- "-"
    }
  }
  blank_phrase
}


update_blank_phrase <- function(phrase,blank_phrase,guess){
  # For loop to replace underscores with the letters that were guessed
  for(i in 1:nchar(phrase)){
    if(guess == tolower(substr(phrase,i,i)) ){
      blank_phrase[i] <- guess
    }
  }
  blank_phrase
}

phrase_contains_letter <- function(phrase,blank_phrase,guess){
  # For loop to check if phrase contains letter
  for(i in 1:nchar(phrase)){
    if(guess == tolower(substr(phrase,i,i)) ){
      return(TRUE)
    }
  }
  return(FALSE)
}

        
