

# 401 Final Project Data --------------------------------------------------


# * load packages ---------------------------------------------------------

pacman::p_load(tidyverse, stringr, skimr, DataExplorer)

# * read in the data ------------------------------------------------------

movies <- read.csv("turn in data\\tmdb_5000_movies.csv")[,-1]
credits <- read.csv("turn in data\\tmdb_5000_credits.csv")[,-1]
bechdel <- read.csv("turn in data\\bechdel_data.csv")


# * merge the data --------------------------------------------------------

full_data <- movies %>%
  inner_join(credits) %>%
  inner_join(bechdel)


# * extract genre ---------------------------------------------------------

genres <- as.list(full_data$genres)

output <- as.data.frame(sapply(genres, function(x) str_extract(x, "(').+?(')")))

output <- as.data.frame(gsub("'", "", output$`sapply(genres, function(x) str_extract(x, "(').+?(')"))`))
names(output)[1] <- "Main_Genre"

full_data <- cbind(full_data, output)


# * explore the data ------------------------------------------------------

skim(full_data)
# no missing data and all the values make sense

plot_histogram(full_data)
plot_bar(full_data)

options(scipen = 999)

summary(full_data$vote_average)
summary(full_data$revenue)


# * write csv with final data ---------------------------------------------

write.csv(full_data, "turn in data\\final_merged_data.csv")





























