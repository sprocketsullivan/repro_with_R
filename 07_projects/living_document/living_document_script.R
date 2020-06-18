library(tidyverse)
library(broom)

my_data <- PlantGrowth

summary_stats <-
  my_data %>% 
  group_by(group) %>% 
  summarize(group_mean = mean(weight))


ggplot(data = my_data, aes(x = group, y = weight, color = group)) +
  geom_boxplot() +
  theme_bw() +
  labs(y = "Weight", x = "Group", color = "Group")


m1 <- lm(weight ~ group, data = my_data)
summary(m1)
m1_test <- anova(m1)

m1_tidy <- tidy(m1, conf.int = TRUE)
anova_tidy <- tidy(m1_test)

