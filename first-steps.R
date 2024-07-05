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



# Dragons -----------------------------------------------------------------




list(
  "LARA" = list("id" = "444", "title" = "Hello"),
  "CHARLIE" = list("id" = "555", "title" = "world")
) %>%
  pmap( ~ paste(.x, "is called", .y))

c(
  "LARA" = list("id" = "444", "title" = "Hello"),
  "CHARLIE" = list("id" = "555", "title" = "world")
) %>%
  pmap( ~ paste(.x, "is called", .y))


