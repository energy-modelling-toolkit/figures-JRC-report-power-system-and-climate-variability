# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

hours_curtailed <- read_csv("data_figure24.csv") %>%
  mutate(
    class = as.factor(class) %>%
      fct_relevel(
        "0", "1-4", "5-9", "10-19", "20-39", "40-59", "60-99", ">100"
      ),
    region = as.factor(region),
    season = as.factor(season) %>%
      fct_relevel("Winter", "Spring", "Summer", "Autumn")
    #
  )

g <- ggplot(hours_curtailed, aes(x = id, y = region, fill = class)) +
  geom_tile() +
  facet_wrap(~season) +
  scale_fill_viridis_d(name = "Hours with curtailment") +
  theme_light() +
  coord_equal(ratio = 1.5) +
  scale_x_continuous(breaks = seq(1990, 2015, 5)) +
  scale_y_discrete(limits = rev(levels(hours_curtailed$region))) +
  theme(
    legend.position = "bottom"
  ) +
  labs(x = "Climate year")
ggsave("figure24.png", width = 6, height = 4.5)
