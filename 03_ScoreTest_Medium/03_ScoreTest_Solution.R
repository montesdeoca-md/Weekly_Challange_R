library(tidyverse)
library(car)

data <- read_csv("03_ScoreTest_Medium/score.csv")

# El análisis si bien es sistemático, cada quién es libre de realizarlo de acuerdo a sus necesidades y objetivos. 

data %>% 
  group_by(Group) %>% 
  summarize(
    mean = mean(Score, na.rm = TRUE),
    sd = sd(Score, na.rm = TRUE),
    n = n()
  )

data %>% 
  group_by(Group) %>% 
  summarize(
    median = median(Score, na.rm = TRUE),
    IQR= IQR(Score, na.rm = TRUE),
    n = n()
  )

# Normality 

data %>% 
  group_by(Group) %>% 
  summarize(
    norm.test = shapiro.test(Score)$p.value
  )

data %>% 
  ggplot(aes(x = Score)) +
  geom_histogram() +
  facet_wrap(~Group)

data %>% 
  ggplot(aes(sample = Score)) +
  stat_qq() + 
  stat_qq_line() +
  facet_wrap(~Group)

# Varianze

leveneTest(Score~as.factor(Group), data = data)

# Hypothesis Testing

t.test(Score ~ Group, data = data, var.equal = FALSE)

# Results presentation

data %>% 
  ggplot(aes(x = as.factor(Group), y = Score)) + 
  geom_boxplot()





