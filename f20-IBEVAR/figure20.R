# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(ggrepel)

toplot <- read_csv("data_figure20.csv")

g <- ggplot(toplot, aes(x = `Hydro-power`, y = `Solar & Wind`)) +
  geom_point(aes(fill = intensity, size = cost_per_mwh),
    pch = 21
  ) +
  geom_text_repel(
    aes(label = label),
    point.padding = unit(1, "lines"),
    box.padding = unit(0.3, "lines"),
    segment.size = 0.5,
    force = 1,
    segment.color = "grey50",
    nudge_y = ifelse(toplot$id == 1996, -3, 5),
    size = 2.5
  ) +
  theme_light() +
  scale_size_continuous(name = "EUR/MWh") +
  scale_fill_viridis_c(name = expression(gCO[2] / kWh))

ggsave(filename = "figure20.png", width = 6 * 1.3, height = 3.2 * 1.3)
