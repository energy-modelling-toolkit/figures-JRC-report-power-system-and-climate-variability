# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot_filtered <- read_csv("data_figure36.csv")

g <- ggplot(toplot_filtered, aes(
  x = share,
  y = market_value
)) +
  geom_point(size = 2, alpha = 1, shape = 21, aes(fill = dev_water_share / 100)) +
  scale_fill_distiller(
    palette = "RdBu", direction = 1,
    labels = scales::percent_format(accuracy = 1),
    name = "Deviation of annual \nhydropower generation",
    limits = c(-0.7, 0.7)
  ) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(
    y = "Market value",
    x = "Wind share"
  ) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  stat_smooth(aes(group = season), method = "lm") +
  facet_wrap(~season, scales = "free_x")

ggsave(
  filename = "figure36.png",
  width = 7, height = 5
)
