# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

sel <- read_csv("data_figure06.csv") %>%
  mutate(
    type_deviation = as.factor(type_deviation) %>%
      fct_expand("XLm") %>%
      fct_relevel(c("XLp", "Lp", "Mp", "Sp", "Sm", "Mm", "Lm", "XLm"))
  )

color_palette <- c(
  Europe = "black", CWE = "#286FB7", CEE = "#B9C21F", British_Isles = "#A52576",
  `British Isles` = "#A52576", `UK & Ireland` = "#A52576", Northern = "#00AFAD",
  Iberia = "#7B9522", SEE = "#D93A43", Italy = "#FCAF17"
)

g <- ggplot(sel, aes(
  x = year, y = region, fill = perc_deviation,
  alpha = type_deviation
)) +
  geom_point(aes(size = type_deviation, shape = type_deviation)) +
  scale_shape_manual(
    values = c(24, 24, 24, 24, 25, 25, 25, 25),
    guide = FALSE
  ) +
  scale_size_manual(
    values = c(
      "Sp" = 1, "Mp" = 2, "Lp" = 4, "XLp" = 8,
      "Sm" = 1, "Mm" = 2, "Lm" = 4, "XLm" = 8
    ),
    labels = c(
      ">9%", "6%", "3%", ">0",
      "<0", "-3%", "-6%", "<-9%"
    ),
    name = "", drop = FALSE
  ) +
  scale_alpha_manual(
    values = c(
      "Sm" = 0.2, "Mm" = 0.3, "Lm" = 0.7, "XLm" = 0.9,
      "Sp" = 0.2, "Mp" = 0.3, "Lp" = 0.7, "XLp" = 0.9
    ),
    guide = FALSE
  ) +
  scale_fill_distiller(palette = "PiYG") +
  theme_minimal() +
  guides(
    fill = FALSE,
    size = guide_legend(
      override.aes =
        list(
          shape = c(rep(24, 4), rep(25, 4)),
          fill = RColorBrewer::brewer.pal(8, "PiYG")
        )
    )
  ) +
  scale_x_continuous(breaks = seq(1990, 2015, 3)) +
  expand_limits(y = 0) +
  labs(
    x = "Climate year"
  )
ggsave("figure06.png", width = 7, height = 2.7)
