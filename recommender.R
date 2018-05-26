library(dplyr)

source("jaccard.R")

movies <- read.csv("ml-20m/movies.csv", stringsAsFactors = FALSE)
tags   <- read.csv("ml-20m/tags.csv", stringsAsFactors = FALSE)
movies_tags <- inner_join(movies, tags, by = "movieId")

id <- 1
movie <- filter(movies_tags, movieId == id)
title <- unique(movie$title)
message("Quem viu ", title, "...")
scores <- numeric()
for (candidate in unique(movies_tags$movieId)){
  candidateTags <- movies_tags %>%
    filter(movieId == candidate)
  scores[as.character(candidate)] <- jaccard(movie$tag, candidateTags$tag)
}
message("também viu:")
recommendations <- movies_tags %>%
  filter(movieId %in% names(tail(sort(scores), 5))) %>%
  select(title) %>%
  unique() %>%
  print()

