# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

# IMP/EXP
jj <- read_csv("data_figure30.csv")

g <- ggplot(
  jj %>%
    filter(id %in% c(2000, 2010, 2012)),
  aes(x = ws / (14.2 * 24 * 1000), y = demand / 1e3)
) +
  geom_point(aes(
    fill = cut(net,
      breaks = c(-Inf, -56924, -22006, 5220, 24534, Inf),
      labels = c(
        "<20th perc.", "20th-40th perc.", "40th-60th perc.",
        "60th-80th perc.", ">80th perc."
      )
    )
  ),
  pch = 21,
  alpha = 1
  ) +
  facet_grid(season ~ id) +
  scale_fill_brewer(palette = "RdBu", name = "Export - Import") +
  geom_point(
    data = jj %>% filter(yday == 335, id %in% c(2000, 2010, 2012)),
    pch = 21,
    size = 6,
    stroke = 2,
    color = "black"
  ) +
  geom_hline(yintercept = 0, alpha = 0.9) +
  scale_x_continuous(labels = scales::percent_format()) +
  labs(
    x = "Wind Power Capacity Factor (%)",
    y = "Deviation of Daily Demand (GW)"
  )
ggsave("figure30.png", width = 6, height = 5)
