# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

region_cmap = c(
  'Europe' = 'black',
  'CWE' = "#286FB7",
  'CEE' =  "#B9C21F",
  'British_Isles' =  "#A52576" ,
  'British Isles' =  "#A52576" ,
  'UK & Ireland' =  "#A52576" ,
  'Northern' = "#00AFAD" ,
  'Iberia' = "#7B9522" ,
  'SEE' = "#D93A43" ,
  'Italy' = "#FCAF17"
)

coord_straightpolar <- function(theta = "x", start = 0, direction = 1, clip = "on") {
  theta <- match.arg(theta, c("x", "y"))
  r <- if (theta == "x") {
    "y"
  } else {
    "x"
  }
  ggproto(NULL, CoordPolar,
    theta = theta, r = r, start = start,
    direction = sign(direction), clip = clip,
    # This is the different bit
    is_linear = function() {
      TRUE
    }
  )
}


fix_merged <- read_csv("data_figure12_01.csv")
ntc_inter_regions <- read_csv("data_figure12_02.csv")
g <- ggplot(
  fix_merged %>%
    dplyr::filter(variable != "VRE"),
  aes(x = variable, y = factor, group = 1)
) +
  coord_straightpolar(theta = "x") +
  geom_line(
    data = fix_merged %>%
      spread(variable, factor) %>%
      gather(variable, factor, -region, -VRE) %>%
      mutate(variable = as.factor(variable) %>%
        fct_relevel("COMC", "HPHS", "HDAM", "ntc")) %>%
      mutate(factor = VRE),
    color = "red", alpha = 0.5
  ) +
  geom_area(aes(fill = region), alpha = 0.8) +
  geom_point(
    data = ntc_inter_regions %>%
      mutate(variable = "ntc"),
    shape = "+"
  ) +
  facet_wrap(~region, ncol = 3) +
  scale_x_discrete(
    expand = c(0, 0),
    breaks = c("COMC", "HPHS", "HDAM", "ntc"),
    labels = c("CCGT", "Pumped", "Reservoirs", "Interconnections")
  ) +
  theme(
    strip.text.x = element_text(size = rel(0.8)),
    axis.text.x = element_text(size = rel(0.8))
  ) +
  scale_y_continuous(
    labels = scales::percent_format(accuracy = 1),
    limits = c(0, 0.8)
  ) +
  scale_fill_manual(values = region_cmap, guide = FALSE) +
  geom_point(size = 0.1, alpha = 0.5) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 6, angle = c(0, 270, 0, 90)),
    axis.text.y = element_blank()
  ) +
  labs(
    x = "", y = ""
  ) +
  geom_text(
    data = tibble(variable = "COMC", factor = seq(0.2, 0.85, 0.2)),
    aes(label = sprintf("%0.0f%%", factor * 100)),
    color = "grey33", size = 1.5
  )

ggsave("figure12.png", width = 4, height = 5)
