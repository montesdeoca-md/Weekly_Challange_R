library(tidyverse)
library(ggprism)

# Identifica los outliers con gráficos y con una tabla
# ¡Suerte!

data <- read_csv("04_Outliers_Medium/dataset.csv") %>% 
  na.omit()

cols <- c("calories", "carbohydrate", "sugar", "protein")
outlier_counts <- data.frame(Group = character(), negatives = integer(), positivos = integer())

for (col in cols) {
  x <- data[[col]]
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lim_inf <- q1 - 1.5 * iqr
  lim_sup <- q3 + 1.5 * iqr
  lower <- sum(x < lim_inf)
  higher <- sum(x > lim_sup)
  outlier_counts <- rbind(outlier_counts, data.frame(Group = str_to_title(col), lower, higher))
}

outlier_counts

data %>% 
  select(calories, carbohydrate, sugar, protein) %>% 
  pivot_longer(1:4, names_to = "Group", values_to = "Values") %>% 
  mutate(
    Group = str_to_title(Group)
  ) %>%
  group_by(Group) %>% 
  ggplot(aes(y = Values, fill = Group)) +
  geom_boxplot(show.legend = FALSE) +
  labs(
    title = "Outlier detection", 
    x = "Group", 
    y = "Values" 
  ) +
  theme_prism() +
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank()) +
  facet_wrap(~ Group, nrow = 1, scales = "free")
