# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(patchwork)

mix <- read_csv("data_figure01_01.csv") %>%
  mutate(region = as.factor(region)) %>%
  mutate(region = fct_relevel(region, "Europe")) %>%
  mutate(fuel_class = as.factor(fuel_class)) %>%
  mutate(fuel_class = fct_relevel(
    fuel_class,
    c("Nuclear", "Fossil fuels & Other", "Hydro-power", "Solar & Wind")
  ))

mix_min_max <- read_csv("data_figure01_02.csv")

this_fuel_cmap <- c(
  "Fossil fuels & Other" = "#a52576",
  "Nuclear" = "#466eb4ff",
  "Solar & Wind" =  "#b9c21f",
  "Hydro-power" = "#00a0e1ff"
)

g1 <- ggplot(mix %>%
  dplyr::filter(region == "Europe"), aes(x = (r), y = fraction)) +
  geom_bar(
    stat = "identity", aes(fill = fuel_class),
    color = "grey33",
    width = 1,
    size = 0.25
  ) +
  # facet_wrap(~region, ncol = 4, scales = 'free_x') +
  scale_y_continuous(labels = scales::percent, breaks = seq(0, 1, 0.2)) +
  scale_x_continuous(breaks = seq(1, 26, 5)) +
  scale_fill_manual(values = this_fuel_cmap, name = "") +
  theme_light() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 6),
    legend.text = element_text(size = 6),
    plot.margin = unit(c(0.1, 0.1, 0.1, 0.1), "cm")
  ) +
  labs(
    x = "Climate years",
    y = "Share of annual generation (%)"
  ) +
  geom_hline(
    data = mix_min_max %>%
      dplyr::filter(region == "Europe"), aes(yintercept = max), color = "grey90",
    alpha = 0.8
  ) +
  geom_hline(data = mix_min_max %>%
    dplyr::filter(region == "Europe"), aes(yintercept = min), color = "grey90", alpha = 0.8) +
  geom_text(
    data = mix_min_max %>%
      dplyr::filter(region == "Europe"), x = 13,
    aes(
      # y = min+0.04,
      label = sprintf("%0.1f%% - %0.1f%%", max * 100, min * 100)
    ),
    color = "white", size = 4,
    y = 0.5
  ) +
  coord_flip()

###
toplot <- mix_min_max %>%
  mutate(region = as.factor(region) %>%
    fct_reorder(max))

singles <- mix %>%
  filter(fuel_class %in% c("Hydro-power", "Solar & Wind")) %>%
  group_by(region, id) %>%
  summarise(share = sum(fraction)) %>%
  ungroup() %>%
  left_join(toplot) %>%
  mutate(region = fct_reorder(region, max))

g2 <- ggplot(toplot, aes(y = region)) +
  geom_point(aes(x = min), size = 2) +
  geom_point(aes(x = max), size = 2) +
  geom_point(
    data = singles,
    aes(x = share, y = region), alpha = 0.3, shape = 3
  ) +
  geom_segment(aes(x = min, xend = max, yend = region), size = 2, alpha = 0.3) +
  scale_x_continuous(labels = scales::percent_format()) +
  geom_text(aes(
    x = min + c(rep(0.06, 6), -0.25, 0.06),
    label = sprintf("%0.0f%%-%0.0f%%", max * 100, min * 100)
  ),
  size = 2
  ) +
  theme_light() +
  theme(
    axis.text.y = element_text(size = 8, face = c(rep("plain", 4), "bold", rep("plain", 3))),
    axis.text = element_text(size = 6),
    plot.margin = unit(c(0.1, 0.1, 0.1, 0.1), "cm")
  ) +
  labs(
    x = "Share of renewable generation (%)",
    y = ""
  )

gout <- g1 + g2
COEFF <- 1.2
ggsave("figure01.png", width = 6 * COEFF, height = 3 * COEFF)
