# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

proj_agg <- read_csv("data_figure37.csv")
hist <- read_csv("data_figure37_hist.csv")
avgs <- read_csv("data_figure37_avgs.csv")
g <- ggplot(proj_agg, aes(x = year)) +
  geom_ribbon(aes(ymin = min_s, ymax = max_s, fill = scenario), alpha = 0.4) +
  geom_line(aes(y = avg, color = scenario), alpha = 0.7) +
  geom_line(data = hist, aes(y = tas), color = "black", alpha = 0.5) +
  facet_wrap(~region, ncol = 2, scales = "free_y") +
  scale_x_continuous(limits = c(1975, 2070)) +
  scale_color_brewer(palette = "Dark2") +
  scale_fill_brewer(palette = "Dark2") +
  labs(
    y = "Air temperature degrees"
  ) +
  geom_text(
    data = avgs %>% dplyr::filter(label == "proj_RCP45"),
    aes(
      label = sprintf("(RCP4.5) 2035-2065: +%0.1f°C", delta),
      x = 2005, y = Inf, vjust = 1.5
    ), size = 2.5
  ) +
  geom_text(
    data = avgs %>% dplyr::filter(label == "proj_RCP85"),
    aes(
      label = sprintf("(RCP8.5) 2035-2065: +%0.1f°C", delta),
      x = 2005, y = Inf, vjust = 3.25
    ), size = 2.5
  ) +
  theme_light() +
  theme(
    legend.position = "bottom"
  )

ggsave("figure37.png", width = 5, height = 5)
