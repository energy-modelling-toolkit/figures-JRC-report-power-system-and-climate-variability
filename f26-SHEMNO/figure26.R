# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure26.csv")
g <- ggplot(toplot, aes(x = m, y = hours / 26, fill = id)) +
  geom_bar(stat = "identity", color = "grey66", size = 0.1) +
  labs(
    x = "Month",
    y = "Average number of hours of load shedding"
  ) +
  theme_light() +
  scale_fill_brewer(palette = "Set1", name = "Climate\nyear") +
  facet_wrap(~region) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

ggsave("figure26.png", width = 6, height = 4)
