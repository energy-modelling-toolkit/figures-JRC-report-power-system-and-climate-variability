# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure19.csv") %>%
  mutate(
    Location = as.factor(Location)
  )

region_cmap <- c(
  Europe = "black", CWE = "#286FB7", CEE = "#B9C21F", British_Isles = "#A52576",
  `British Isles` = "#A52576", `UK & Ireland` = "#A52576", Northern = "#00AFAD",
  Iberia = "#7B9522", SEE = "#D93A43", Italy = "#FCAF17"
)

g <- ggplot(toplot, aes(y = as.numeric(Location))) +
  geom_rect(
    data = toplot %>%
      group_by(Location = as.factor(Location)) %>%
      summarise(
        qlow  = quantile(cost_per_mwh, 1 / 4),
        qhigh = quantile(cost_per_mwh, 3 / 4)
      ),
    aes(
      xmin = qlow,
      xmax = qhigh,
      ymin = as.numeric(Location) - 0.5,
      ymax = as.numeric(Location) + 0.5,
      fill = Location
    ),
    color = "black", alpha = 0.4,
  ) +
  geom_point(aes(x = cost_per_mwh, color = Location),
    position = position_jitter(seed = 12, height = 0.2),
    alpha = 0.6
  ) +
  theme_light() +
  scale_color_manual(values = region_cmap, guide = FALSE) +
  scale_fill_manual(values = region_cmap, guide = FALSE) +
  scale_x_continuous(breaks = seq(0, 30, 3)) +
  theme(strip.background = element_rect(fill = "grey30")) +
  xlab("Annual average fuel cost (EUR/MWh)") +
  ylab("") +
  scale_y_continuous(trans = "reverse", breaks = seq(1, 8), labels = levels(toplot$Location))

ggsave(filename = "figure19.png", width = 6, height = 3)
