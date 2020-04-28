# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

merged <- read_csv("data_figure34.csv")

region_cmap <- c(
  Europe = "black", CWE = "#286FB7", CEE = "#B9C21F", British_Isles = "#A52576",
  `British Isles` = "#A52576", `UK & Ireland` = "#A52576", Northern = "#00AFAD",
  Iberia = "#7B9522", SEE = "#D93A43", Italy = "#FCAF17"
)

g <- ggplot(merged, aes(x = HPHS, y = WTON)) +
  geom_point(aes(color = region), size = 3) +
  scale_color_manual(values = region_cmap) +
  ggrepel::geom_text_repel(aes(label = n),
    segment.colour = "grey50",
    nudge_x = 0.025,
    nudge_y = 0.025
  ) +
  theme_light() +
  labs(
    x = "Pumped storage to peak load",
    y = "Onshore wind power to peak load"
  )
ggsave("figure34.png", width = 6, height = 3)
