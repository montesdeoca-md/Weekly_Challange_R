table1 <- data.frame(
  ID = seq(1, 10), 
  Column3 = seq(3.1, 4, by = 0.1), 
  Column4 = seq(4.1, 5, by = 0.1)
  )

col1 <- data.frame(ID = 1:10, Column = "Column1", Values = seq(1.1, 2.0, by = 0.1))
col2 <- data.frame(ID = 1:10, Column = "Column2", Values = seq(2.1, 3.0, by = 0.1))

table2 <- rbind(col1, col2)
table2 <- table2[order(table2$ID), ]  # ordenar por ID

write.csv(table1, "02_Joins_and_Pivot_Easy/table1.csv", row.names = FALSE)
write.csv(table2, "02_Joins_and_Pivot_Easy/table2.csv", row.names = FALSE)
