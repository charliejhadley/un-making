library(shiny)
library(shinygallery)
library(tidyverse)
library(tidyjson)
library(jsonlite)


tag_files <- fromJSON("https://api.figshare.com/v2/articles?institutions=lboro&tag=csc_power") %>% 
  as_tibble() %>%
  reframe(article_id = id) %>% 
  mutate(url_for_files = as.character(str_glue("https://api.figshare.com/v2/articles/{article_id}/files")))


files_info <- tag_files %>% 
  mutate(file_info = map(url_for_files,
                         ~fromJSON(.x))) %>% 
  unnest(file_info) %>% 
  rename()


files_info %>% 
  select(download_url, name) %>% 
  pmap(~download.file(
    .x,
    str_glue(.y)
  ))


c("id", "resourceid", "path", "title", 
  "subtitle")


get_uri <- function(file) {
  file_ext <- paste0("image/", tools::file_ext(file))
  base64enc::dataURI(file = file, mime = file_ext)
}

tib_images <- files_info %>% 
  reframe(path = map(name, ~get_uri(.)),
          title = name,
          subtitle = article_id)

# tib_images <- tibble(
#   path = "https://cdn-icons-png.flaticon.com/512/2103/2103694.png",
#   title = "R",
#   subtitle = "Is great"
# )


vec_image_paths <- files_info %>% 
  pull(name)





get_uri <- function(file) {
  file_ext <- paste0("image/", tools::file_ext(file))
  base64enc::dataURI(file = file, mime = file_ext)
}

file_path <- system.file("extdata", package = "shinygallery")

files <- list.files(file_path, full.names = TRUE)
values <- rep(sapply(files, get_uri), 10)




