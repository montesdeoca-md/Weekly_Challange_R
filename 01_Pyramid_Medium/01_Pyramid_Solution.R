# Solución del ejercicio #1

rows <- 7


for (i in 1:rows) { 
  for (j in seq_len(rows - i)) { 
    cat(" ")
  }
  for (k in seq_len(i * 2 - 1)) { 
    cat("*") 
  }
  cat("\n")
}