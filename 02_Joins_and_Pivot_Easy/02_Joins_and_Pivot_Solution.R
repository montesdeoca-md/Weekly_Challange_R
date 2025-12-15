library(tidyverse)

# Cargar tablas 

table1 <- read_csv("02_Joins_and_Pivot_Easy/table1.csv")
table2 <- read_csv("02_Joins_and_Pivot_Easy/table2.csv")

# Solución_1: 

table1 %>% 
  pivot_longer(Column3:Column4, names_to = "Column", values_to = "Values") %>% 
  full_join(table2, by = c("ID", "Column", "Values")) %>% 
  arrange(ID, Column)

# Solución 2: 

table2 %>% 
  pivot_wider(id_cols = ID, names_from = Column, values_from = Values) %>% 
  full_join(table1, by = "ID")
