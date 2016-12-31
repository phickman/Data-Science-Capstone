library(tm)
library(NLP)

predictNextWord <- function(input)
{
  search_phrase <- input
  search_phrase <- removePunctuation(search_phrase)
  search_phrase <- removeNumbers(search_phrase)
  
  search_phrase <- tolower(search_phrase)
  search_phrase <- stripWhitespace(search_phrase)
  search_phrase <- unlist(strsplit(search_phrase , " "))
  
  # only have quad ngrams, so need at most the last 3 words
  ngram_total <- min(length(search_phrase), 3)
  
  # search the dataframes for 4th, 3rd, 2nd and last word
  for(i in ngram_total:1)
  {
    match_index <- NA
    match_ngram <- NA 
    df <- NA
    
    # get the last 'i' words from the ngram datasets
    print(tail(search_phrase, i))
    search_ngram <- paste(tail(search_phrase, i), collapse = " ")
    print(paste("NGRAM1:", search_ngram, sep=" "))
    search_ngram <- paste0("^", search_ngram, " ")
    print(paste("NGRAM2:", search_ngram, sep=" "))
    
    # use the relevant ngram dataframe
    if(i == 3)
    {
      print("i == 3")
      if (!exists("quadword.freq_data")) load(file = "data/quadword.freq_data.RData")
      df <- quadword.freq_data
    }
    else if(i == 2)
    {
      print("i == 2")
      if (!exists("triword.freq_data")) load(file = "data/triword.freq_data.RData")
      df <- triword.freq_data
    }
    else if(i == 1)
    {
      print("i == 1")
      if (!exists("biword.freq_data")) load(file = "data/biword.freq_data.RData")
      df <- biword.freq_data
    }
    match_index <- grep(search_ngram, df$ngram)[1]
    match_ngram <- df[match_index, 1]
    
    if(!is.na(match_index))
    {
      print(match_index)
      print(match_ngram)

      # get the last word in the ngram as it is predicted to be next
      next_word <- gsub(search_ngram, "", match_ngram)
      return (next_word)
      break
    }
  }
  
  print("NOT FOUND!  RETURNING MOST FREQUENT WORD")
  if (!exists("uniword.freq_data")) load(file = "data/uniword.freq_data.RData")
  return(paste0(uniword.freq_data[1, 1]))
}
