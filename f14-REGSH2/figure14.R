# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

mix <- read_csv("data_figure14.csv")
minmax <- read_csv("data_figure14_minmax.csv")

this_fuel_cmap <- c(
  "Fossil fuels & Other" = "#a52576",
  "Nuclear" = "#466eb4ff",
  "Solar & Wind" =  "#b9c21f",
  "Hydro-power" = "#00a0e1ff"
)


g <- ggplot(mix, aes(y = fraction)) +
  geom_bar(
    data = mix %>%
      filter(r == 1),
    stat = "identity", aes(x = season * 3, fill = fuel_class),
    color = "grey33", width = 0.8, size = 0.25
  ) +
  geom_bar(
    data = mix %>%
      filter(r == 14),
    stat = "identity", aes(x = 3 * season + 0.8 + 0.1, fill = fuel_class),
    color = "grey33", width = 0.8, size = 0.25
  ) +
  geom_bar(
    data = mix %>%
      filter(r == 26),
    stat = "identity", aes(x = 3 * season + 1.6 + 0.2, fill = fuel_class),
    color = "grey33", width = 0.8, size = 0.25
  ) +
  facet_wrap(~region, ncol = 4, scales = "free") +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), breaks = seq(0, 1, 0.1)) +
  scale_x_continuous(
    breaks = c(4, 7, 10, 13),
    labels = c("Win", "Spr", "Sum", "Aut")
  ) +
  scale_fill_manual(values = this_fuel_cmap, name = "") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  labs(
    x = "Season",
    y = "Share of annual generation (%)"
  ) +
  geom_hline(data = minmax, aes(yintercept = max), color = "grey10", alpha = 0.8) +
  geom_hline(data = minmax, aes(yintercept = min), color = "grey10", alpha = 0.8)

ggsave("figure14.png", width = 7, height = 4)
