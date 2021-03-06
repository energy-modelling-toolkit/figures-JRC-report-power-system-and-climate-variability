# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure41.csv") %>%
  mutate(
    size_class = cut(abs(corr), breaks = c(0, 0.6, 0.75, Inf), labels = c("<0.6", " ", ">0.75")),
    sign_class = as.character(sign_class),
    season_label = as.factor(season_label) %>%
      fct_relevel(c("Winter", "Spring", "Summer"))
  )

g <- ggplot(toplot, aes(
  x = from_region, y = to_region,
  size = size_class,
  shape = as.factor(sign_class),
  fill = from_variable
)) +
  facet_wrap(~season_label) +
  geom_point(
    data = toplot %>%
      filter(from_variable == "demand_anom"),
    position = position_nudge(x = -0.25, y = -0.25)
  ) +
  geom_point(
    data = toplot %>%
      filter(from_variable == "wind_anom"),
    position = position_nudge(x = +0.25, y = -0.25)
  ) +
  geom_point(
    data = toplot %>%
      filter(from_variable == "solar_anom"),
    position = position_nudge(x = 0.25, y = 0.25)
  ) +
  geom_point(
    data = toplot %>%
      filter(from_variable == "inflow_anom"),
    position = position_nudge(x = -0.25, y = 0.25)
  ) +
  geom_vline(xintercept = seq(0.5, 8.5, 1), colour = "black", alpha = 0.6) +
  geom_hline(yintercept = seq(0.5, 8.5, 1), colour = "black", alpha = 0.6) +
  coord_equal() +
  labs(x = "", y = "") +
  scale_shape_manual(
    values = c("1" = 24, "-1" = 25), name = "",
    labels = c(
      "1" = "Positive correlation",
      "-1" = "Negative correlation"
    )
  ) +
  scale_size_manual(
    values = c("<0.6" = 1.2, " " = 2.5, ">0.75" = 4),
    limits = c("<0.6", " ", ">0.75"),
    name = "Spearman correlation"
  ) +
  scale_fill_manual(
    values = c(
      "wind_anom" = "#c9cf5c",
      "inflow_anom" = "#00a0e1ff",
      "solar_anom" = "#e6a532",
      "demand_anom" = "#c4132a"
    ),
    limits = c("demand_anom", "wind_anom", "inflow_anom", "solar_anom"),
    labels = c(
      "demand_anom" = "Deviation of electricity demand",
      "inflow_anom" = "Deviation of inflow",
      "solar_anom" = "Deviation of solar resources",
      "wind_anom" = "Deviation of wind resources"
    ),
    name = "Variable",
    drop = FALSE
  ) +
  guides(fill = guide_legend(override.aes = list(size = 4, shape = 21))) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("figure41.png", width = 6, height = 4.5)
