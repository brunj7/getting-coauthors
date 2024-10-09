library(tidyverse)
library(rcrossref)


main_author <- "Brun, Julien"
# start_year <- "2022" 
# 
# doi_example <- "10.1038/s41893-023-01253-y"

# Manually adding my papers from 2022 and on
my_dois <- c("10.1038/s41893-023-01253-y", "10.1002/pan3.10524", "10.1111/gcb.16862",
             "10.1029/2022GB007580", "10.1088/1748-9326/acab19", "10.1371/journal.pcbi.1010567", "10.1002/ece3.9245")


# function to get the co-authors of a specific paper
get_paper_info <- function(doi_paper, main_author_l = main_author){

  # Get one paper
  full_info <- cr_cn(dois = doi_paper, "bibentry")
  
  # List the authors
  authors <- full_info$author
  
  # imtemzie authors 
  authors <- str_split_1(authors, " and ")
  
  # Remove main author
  co_authors_df <-  as.data.frame(authors) %>% 
    filter(authors != main_author_l)
}



# Get the data for the example

# intinalize df
all_co <- data.frame(
  authors=character(),
  stringsAsFactors=FALSE)

# Loop through the DOIs to get the co-authors
for (paper in my_dois) {
  my_co <- get_paper_info(paper)
  all_co <- bind_rows(all_co, my_co)
}

# Save result as a csv file
write_csv(all_co, "my_coauthors.csv")


