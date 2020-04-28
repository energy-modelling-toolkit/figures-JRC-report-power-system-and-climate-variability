# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(ggrepel)

sel <- read_csv("data_figure17.csv") %>%
  mutate(
    Location = as.factor(Location)
  )

region_cmap <- c(
  Europe = "black", CWE = "#286FB7", CEE = "#B9C21F", British_Isles = "#A52576",
  `British Isles` = "#A52576", `UK & Ireland` = "#A52576", Northern = "#00AFAD",
  Iberia = "#7B9522", SEE = "#D93A43", Italy = "#FCAF17"
)
g <- ggplot(sel, aes(y = as.numeric(Location))) +
  geom_rect(
    data = sel %>%
      group_by(label_tech, Location = as.factor(Location)) %>%
      summarise(
        qlow  = quantile(OutputPower, 1 / 4),
        qhigh = quantile(OutputPower, 3 / 4)
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
  geom_point(aes(x = OutputPower, color = Location),
    position = position_jitter(seed = 42, height = 0.2),
    alpha = 0.6
  ) +
  facet_wrap(~label_tech, scales = "free", ncol = 2) +
  theme_light() +
  scale_color_manual(values = region_cmap, guide = FALSE) +
  scale_fill_manual(values = region_cmap, guide = FALSE) +
  # scale_x_continuous(breaks = seq(0, 1200, 100))+
  labs(
    x = "Generation (TWh)", y = ""
  ) +
  scale_y_continuous(trans = "reverse", breaks = seq(1, 7), labels = levels(sel$Location)) +
  geom_text(
    data = sel %>%
      dplyr::filter(
        id == 2000,
        !((Location == "CWE") & (label_tech == "Run-of-river")) &
          !((Location == "Northern") & (label_tech == "Storage and Pumping"))
      ),
    aes(label = label, x = OutputPower, y = as.numeric(Location)),
    hjust = -0.25, size = 2.5
  ) +
  geom_text(
    data = sel %>%
      dplyr::filter(
        id == 2000,
        ((Location == "CWE") & (label_tech == "Run-of-river")) |
          ((Location == "Northern") & (label_tech == "Storage and Pumping"))
      ),
    aes(label = label, x = OutputPower, y = as.numeric(Location)),
    hjust = c(+1.75, 2.1), size = 2.5
  )

ggsave("figure17.png", width = 7.5, height = 4)
