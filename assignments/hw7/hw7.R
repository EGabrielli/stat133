######################################################
##### Homework 7 due Friday April 10 by midnight
## Please read through the whole assignment before starting it.

## For the assingment you will work with the full text of the 
## State of the Union speeches from 1790 until 2012.
## The speeches are all in the file "stateoftheunion1790-2012.txt".

## You will first read the text into R and manipulate it in order to 
## create a dataframe with information about each speech 
## (President's name, year and month, length of the speech, #sentences, #words)
## You will also create a list that contains the full text of each speech,  
## which in turn is used to create a word vector of *all* words that appear
## in *any* if the speeches - and to count their occurrances in each speech.

## You will then be able to make some comparisons of the speeches/presidents.

library("SnowballC")

source("computeSJDistance.R")


speeches <- readLines(con=file("stateoftheunion1790-2012.txt"))

breaks <- grep("\\*\\*\\*", speeches)
breaks <- breaks[-length(breaks)]
n.speeches <- length(breaks)

presidents <- speeches[breaks+3]

tempDates <- speeches[breaks+4]

speechYr <- as.numeric(sapply(tempDates, function(x) substr(x, nchar(x)-3, nchar(x))))
names(speechYr) <- list()

Monthofyear <- strsplit(tempDates, split=" ")
speechMo <- sapply(Monthofyear, "[", 1)

speeches <- gsub("Mr.", "Mr", speeches)
speeches <- gsub("Mrs.", "Mrs", speeches)
speeches <- gsub("U.S.", "US", speeches)

speechesL <- NULL
breaks <- c(breaks, length(speeches)-1)
for(i in 1:n.speeches){
  str <- paste(speeches[(breaks[i]+6):(breaks[i+1]-1)], sep=" ", collapse=" ") 
  speechesL[[i]] <- unlist(strsplit(str, "[.?!]"))
}


speechToWords = function(sentences) {
  # sentences is character vector of sentences for each speech
  # Eliminate apostrophes and numbers, 
  # and turn characters to lower case.
  
  c1 = gsub("'", "", sentences)
  c2 = tolower(gsub("[0-9]+s*", "", c1))
  
  # Drop the phrase (Applause.)
  c3 = gsub("\\(applause.\\)", "", c2)
  
  # Split the text up by blanks and punctuation 
  c4 = unlist(strsplit(c3, "[[:punct:][:blank:]]+"))
  
  # Unlist the return value and assign it to tempW
  
  # Drop any empty words 
  c5 = c4[c4 != ""]
  
  # Use wordStem() to stem the words
  c6 = wordStem(c5)
  c7 = c6[c6 != ""]
  
  return(c7)
  # return a character vector of all words in the speech
}
speechWords <- sapply(speechesL, speechToWords)


none <- speechWords
uniqueWords <- sort(unique(unlist(none)))

no.uniqueWords <- length(uniqueWords)


# your code to create [wordMat] here:
emptyVec = rep(0, length(uniqueWords))
names(emptyVec) = uniqueWords

d.words = lapply(speechWords, function(x){
  numb = table(x)
  empty = emptyVec
  empty[names(numb)] = numb
  return(empty)
})


wordMat = matrix(unlist(d.words), ncol=length(d.words))

load("speeches_dataframe.Rda")
sumterms <- function(x){
  mySum <- sum(nchar(x))
  return(mySum)
}

words <- sapply(speechWords, length)
chars <- sapply(speechWords, sumterms)
sentences <- sapply(speechesL, length)

speechesDF <- data.frame(speechesDF, Years=speechYr, Months=speechMo, sentences, words, chars)






