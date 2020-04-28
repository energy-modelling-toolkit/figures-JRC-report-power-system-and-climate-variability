# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure38.csv")

g <- ggplot(toplot, aes(x = model, y = share, fill = source_label)) +
  geom_bar(
    stat = "identity", position = "stack",
    color = "grey33", width = 0.8, size = 0.25
  ) +
  facet_wrap(~region, nrow = 1) +
  scale_fill_manual(
    values = c(
      "Wind power" = "#c9cf5c",
      "Hydro-power" = "#00a0e1ff",
      "Solar power" = "#e6a532"
    ),
    name = ""
  ) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  facet_wrap(~region, nrow = 2) +
  theme_light() +
  theme(
    legend.position = "bottom",
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(x = "")

ggsave("figure38.png", width = 5, height = 3)
