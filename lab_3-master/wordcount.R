# install package
remotes::install_github("benmarwick/wordcountaddin")
# load 
library(wordcountaddin)

# This function reads a Rmd file and returns the word count 
# It uses the wordcountaddin and koRpus packages
text_stats_file <- function(rmdFile) {
  rmd <- file(rmdFile, "rt")
  text <- readLines(rmd)
  conText <- ""
  for (i in text) {
    conText <- paste(conText, i)
  }
  close(rmd)
  # count words - uses an internal function of the wordcountaddin package
  return(wordcountaddin:::text_stats_fn_(conText))
}

# This function renders a Rmd file and prints the word count
render_and_count <- function(rmdFile) {
  rmarkdown::render(rmdFile)
  n_words <- text_stats_file(rmdFile)$n_words_korp
  cat("\n\nword count: ", n_words, "\n\n")
}

# change name of file to run 
#text_stats_file("~/project_3/w203_project3/lab_3-master/lab_3_v3.Rmd")
# run this one: 
wordcountaddin::word_count("~/project_3/w203_project3/lab_3-master/lab_3_v7.Rmd")
