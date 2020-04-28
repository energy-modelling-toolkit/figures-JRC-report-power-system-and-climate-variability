# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure35.csv")

g <- ggplot(toplot, aes(
  x = share,
  y = value
)) +
  geom_point(aes(color = Location), size = 2, alpha = 0.1) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(
    y = "Market value / Market value factor",
    x = "Wind share"
  ) +
  theme_light() +
  scale_color_brewer(palette = "Dark2", name = "Country") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  stat_smooth(aes(group = Location, color = Location), method = "lm") +
  facet_wrap(area ~ variable, scales = "free", ncol = 2)

ggsave("figure35.png", width = 5, height = 6)
