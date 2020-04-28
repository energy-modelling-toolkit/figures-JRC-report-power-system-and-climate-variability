# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

mix <- read_csv("data_figure13.csv")

this_fuel_cmap <- c(
  "Fossil fuels & Other" = "#a52576",
  "Nuclear" = "#466eb4ff",
  "Solar & Wind" =  "#b9c21f",
  "Hydro-power" = "#00a0e1ff"
)

mix_min_max <- read_csv("data_figure13_minmax.csv")

g <- ggplot(mix, aes(x = (r), y = fraction)) +
  geom_bar(
    stat = "identity", aes(fill = fuel_class),
    color = "grey33",
    width = 1,
    size = 0.25
  ) +
  facet_wrap(~region, ncol = 4, scales = "free_x") +
  scale_y_continuous(labels = scales::percent, breaks = seq(0, 1, 0.2)) +
  scale_x_continuous(breaks = seq(1, 26, 5)) +
  scale_fill_manual(values = this_fuel_cmap, name = "") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 6)
  ) +
  labs(
    x = "Rank (climate years sorted by renewable energy generation)",
    y = "Share of annual generation (%)"
  ) +
  geom_hline(
    data = mix_min_max, aes(yintercept = max), color = "grey90",
    alpha = 0.8
  ) +
  geom_hline(data = mix_min_max, aes(yintercept = min), color = "grey90", alpha = 0.8) +
  geom_text(
    data = mix_min_max, x = 13,
    aes(
      # y = min+0.04,
      label = sprintf("%0.1f%% - %0.1f%%", max * 100, min * 100)
    ),
    color = "white", size = 4,
    y = 0.5
  ) +
  coord_flip()

ggsave("figure13.png", width = 8, height = 5)
