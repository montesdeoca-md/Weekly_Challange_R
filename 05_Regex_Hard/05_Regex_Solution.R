library(tidyverse)

data <- read.csv("05_Regex_Hard/data.csv")

data_regex <- data %>% 
  filter(leukocytes != "" & neutrophils != "") %>% 
  mutate(
    leukocytes = str_replace(leukocytes, "/.", "/ "),
    leukocytes = as.numeric(str_remove_all(leukocytes, "[^0-9.]")),
    neutrophils = as.numeric(str_remove_all(neutrophils, "[^0-9.]"))
    ) %>% 
  mutate(
    leukocytes = ifelse(leukocytes <= 100, leukocytes * 1000, leukocytes),
    neutrophils = ifelse(neutrophils <= 100, neutrophils * leukocytes /100, neutrophils)
  ) %>% 
  na.omit()


