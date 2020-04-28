# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(ggrepel)

toplot <- read_csv("data_figure21.csv")

level_stats <- toplot %>%
  group_by(id) %>%
  summarise(avg = mean(level)) %>%
  mutate(r = rank(avg)) %>%
  dplyr::filter(r %in% c(1, 2, 13, 14, 25, 26)) %>%
  arrange(r)

g <- ggplot(toplot, aes(x = week, y = level, group = id)) +
  geom_line(
    data = toplot %>% dplyr::filter(!(id %in% level_stats$id)),
    alpha = 0.5
  ) +
  geom_line(
    data = toplot %>% dplyr::filter(id %in% level_stats$id),
    alpha = 0.8, size = 1, aes(color = as.factor(id))
  ) +
  geom_label_repel(
    data = toplot %>%
      dplyr::filter(week == 35, id %in% level_stats$id),
    aes(label = id),
    hjust = 0,
    segment.size = 0.5,
    size = 3
  ) +
  theme_light() +
  labs(x = "week", y = "Stored Energy (TWh)") +
  scale_color_manual(
    values = c("#00989a", "#286fb7", "#9dad20", "#b6317d", "#c4132a", "#f99d1c"),
    guide = FALSE
  )

ggsave("figure21.png", width = 6, height = 3)
