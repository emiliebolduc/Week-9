install.packages("jsonlite")
install.packages("DT")
install.packages("tidyr")
install.packages("dplyr")

# Libraries
library(jsonlite)
library(DT)
library(tidyr)
library(dplyr)

# Get API key from NY Times 
key <- "&api-key=2989168319214883a9a2a5e3d5713d88"


# NY Times API used: /lists/best-sellers/history.json
url <- "https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json?age-group=4"

# What do I want to query - Best seller books for 4-year-olds 
AgeGroup <- "?age-group=4"

# use jsonlite [fromJSON] function to get the API data with API key and query by AgeGroup from NY Times
rawdata <- fromJSON(paste0(url, key))
# Reference: https://cran.r-project.org/web/packages/jsonlite/vignettes/json-apis.html

head(rawdata)
# class
class(rawdata) 

# how many elements
length(rawdata)

# names
names(rawdata)

# class of each element
lapply(rawdata, class)

# how many elements in each list component
lapply(rawdata, length)

# remove the first 3 lists ("status", "copyright", "num_results")
results <- rawdata[-c(1:3)]
names(results)
length(results)
class(results)

# Turn into a dataframe 
results_df <- results[["results"]]
class(results_df)


# Tidy data with [dpylr] and [tidyr] packages
colnames(results_df)

kidsbooks <- tbl_df(results_df) %>% 
  select(kidsbooks, one_of(c("title", "description", "author", "price", "age_group"))) %>% 
  rename(kidsbooks, Title = 'title', Description = 'description', Author = 'author', Price = 'price', Ages = 'age_group')
kidsbooks

# Make a Pretty Table
datatable(kidsbooks)




