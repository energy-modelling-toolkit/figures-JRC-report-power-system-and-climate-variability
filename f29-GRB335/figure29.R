# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(lubridate)

toplot <- read_csv("data_figure29.csv")
cmap <- c(
  `Fossil fuels` = "#c781b2", Nuclear = "#466eb4ff", Other = "#d58a90",
  `Wind & Solar` = "#c9cf5c", Hydro = "#00a0e1ff", ROR = "#00a0e1ff",
  Reservoir = "#00a0e1ff", Pumping = "#00a0e1ff", `Net Export/Import` = "#f58220",
  ShedLoad = "#c4132a", Demand = "black", `Loss of Load` = "red"
)

g <- ggplot(toplot, aes(x = h, y = OutputPower)) +
  geom_bar(
    data = toplot %>% filter(!(fuel_class %in% c("Demand"))),
    stat = "identity",
    aes(fill = fuel_class),
    width = 3600
  ) +
  geom_step(
    data = toplot %>% filter(fuel_class == "Demand"),
    position = position_nudge(x = -24 * 70)
  ) +
  scale_fill_manual(values = cmap, name = "Fuel") +
  facet_wrap(~label, dir = "h", ncol = 2) +
  scale_x_datetime(
    date_breaks = "3 hours",
    date_labels = "%H"
  ) +
  labs(
    x = "Hour",
    y = "Power (MW)"
  ) +
  theme_light() +
  theme(legend.position = "bottom") +
  ggrepel::geom_text_repel(
    data = toplot %>%
      filter(id == 2012, hour(h) == 18, fuel_class == "Demand"),
    aes(x = h, y = OutputPower), label = "Loss of load: 1.1 GW",
    direction = "x",
    box.padding = 3,
    segment.colour = "black"
  )

ggsave("figure29.png", width = 6, height = 8)
