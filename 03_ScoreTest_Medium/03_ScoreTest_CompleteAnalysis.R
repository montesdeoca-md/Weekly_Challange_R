library(tidyverse)
library(patchwork)
library(car)
library(ggprism)
library(ggpubr)

data <- read_csv("03_ScoreTest_Medium/score.csv")

# El análisis si bien es sistemático, cada quién es libre de realizarlo de acuerdo a sus necesidades y objetivos. 

data %>% summary()
data %>% glimpse()
data %>% str()

data_clear <- data %>% 
  mutate(Group = as.factor(Group),
         Group = dplyr::recode(Group, 
                               "1" = "A", 
                               "2" = "B")) %>% 
  filter(!is.na(Score))

data_clear %>% 
  group_by(Group) %>% 
  summarize(
    Media = mean(Score, na.rm = TRUE),
    SD = sd(Score, na.rm = TRUE),
    Mediana = median(Score, na.rm = TRUE),
    IQR= IQR(Score, na.rm = TRUE),
    n = n(),
    Varianza = var(Score)
  )

# Normality 

data_clear %>% 
  group_by(Group) %>% 
  summarize(
    norm.test = shapiro.test(Score)$p.value
  )

histogramas <- data_clear %>% 
  ggplot(aes(x = Score)) +
  geom_histogram(aes(fill = Group), show.legend = FALSE) +
  labs(
    title = "Histograma de calificaciones", 
    x = "Calificación", 
    y = "Frecuencia"
  ) +
  theme_prism() +
  facet_wrap(~Group)

qqplots <- data_clear %>% 
  ggplot(aes(sample = Score)) +
  stat_qq(aes(color = Group), show.legend = FALSE) + 
  stat_qq_line(aes(color = Group), show.legend = FALSE) +
  labs(
    title = "Gráfico Q-Q de las calificaciones", 
    x = NULL, 
    y = NULL
  ) +
  theme_prism() + 
  facet_wrap(~Group)

histogramas / qqplots 

# Varianze

leveneTest(Score~as.factor(Group), data = data)

# Hypothesis Testing

test <- t.test(Score ~ Group, data = data_clear, var.equal = FALSE)$p.value

# Results presentation
 
data_clear %>% 
  ggplot(aes(x = Group, y = Score, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.15, alpha = 0.5) +
  scale_color_manual(values = c("#4876FF", "#EE0000")) +
  geom_bracket(
    inherit.aes = FALSE, 
    xmin = 1, 
    xmax = 2, 
    y.position = max(data_clear$Score) + 0.3, 
    label = ifelse(test < 0.001, "< 0.001", test)
  ) +
  labs(
    title = "Boxplot", 
    x = "Group", 
    y = "Score"
  ) +
  theme_prism() +
  theme(legend.position = "none")