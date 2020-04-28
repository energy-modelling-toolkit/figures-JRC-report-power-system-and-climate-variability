# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(patchwork)

toplot <- read_csv("data_figure08.csv")
toplot_ranges <- read_csv("data_figure08_ranges.csv")

g_europe <- ggplot(toplot %>%
  dplyr::filter(n == "Europe"), aes(x = r)) +
  geom_line(aes(group = id, y = Demand / 1e3), alpha = 0.6) +
  geom_vline(xintercept = c(0, 0.1), linetype = "dashed") +
  scale_x_continuous(labels = scales::percent) +
  theme_minimal() +
  labs(
    x = "Fraction of the year",
    y = "Hourly load (GW)"
  ) +
  theme(strip.background = element_rect(fill = "grey30"))

g_all <- ggplot(toplot %>%
  dplyr::filter(r <= 0.1), aes(x = r)) +
  geom_line(aes(group = id, y = Demand / 1e3), alpha = 0.8) +
  geom_ribbon(data = toplot_ranges %>%
    dplyr::filter(r <= 0.1), aes(ymin = qlow / 1e3, ymax = qhigh / 1e3), fill = "lightblue", alpha = 0.8) +
  facet_wrap(~n, scales = "free_y") +
  theme_minimal() +
  labs(
    x = "Fraction of the year",
    y = "Hourly load (GW)"
  ) +
  theme(axis.text.y = element_text(size = 6),
        axis.text.x = element_text(size = 6))

g <- g_europe / g_all + plot_layout(heights = c(1, 2))
ggsave("figure08.png", width = 5, height = 4, dpi = 300)
