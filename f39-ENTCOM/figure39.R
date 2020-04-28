# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure39.csv")
fuel_cmap <- c(
  Fossil_fuels = "#c781b2", Solid_fuels = "#c781b2", `Solid fuels` = "#c781b2",
  `Fossil fuels` = "#c781b2", Nuclear = "#466eb4ff", Other = "#facdd0",
  Gas = "#d7642dff", Wind = "#c9cf5c", Hydro = "#00a0e1ff", Solar = "#e6a532",
  Biomass = "#7daf4bff"
)

g <- ggplot(toplot, aes(x = ENTSOE, y = OutputPower, label = label)) +
  geom_point(aes(fill = Fuel), size = 2.75, alpha = 0.8, pch = 21) +
  facet_wrap(~Location, scales = "free") +
  geom_abline(slope = 1) +
  labs(
    x = "ENTSO-E (TWh)",
    y = "Dispa-SET (TWh)"
  ) +
  scale_x_log10() +
  scale_y_log10() +
  scale_fill_manual(values = fuel_cmap) +
  theme_light() +
  theme(legend.position = "bottom")

ggsave("figure39.png", width = 5, height = 6)
