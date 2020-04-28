# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure22.csv") %>%
  mutate(
    Location = as.factor(Location)
  )

region_cmap <- c(
  Europe = "black", CWE = "#286FB7", CEE = "#B9C21F", British_Isles = "#A52576",
  `British Isles` = "#A52576", `UK & Ireland` = "#A52576", Northern = "#00AFAD",
  Iberia = "#7B9522", SEE = "#D93A43", Italy = "#FCAF17"
)

g <- ggplot(toplot, aes(x = week, y = level)) +
  geom_area(aes(fill = Location)) +
  facet_wrap(~id, ncol = 3, dir = "v") +
  scale_fill_manual(values = region_cmap, name = "region") +
  labs(
    x = "week",
    y = "Stored Energy (TWh)"
  ) +
  theme_light() +
  theme(legend.position = "bottom")
ggsave(g, filename = "figure22.png", width = 6, height = 4)
