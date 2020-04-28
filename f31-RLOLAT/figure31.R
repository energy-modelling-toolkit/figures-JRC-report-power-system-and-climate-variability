# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure31.csv")

g <- ggplot(toplot %>%
  filter(r < 0.1), aes(x = r, y = res_load / 1e3)) +
  geom_line(aes(group = id), alpha = 0.8) +
  geom_ribbon(aes(ymin = qlow / 1e3, ymax = qhigh / 1e3), fill = "lightblue", alpha = 0.8) +
  scale_x_continuous(labels = scales::percent) +
  xlab("Fraction of the year") +
  ylab("Residual load (GW)") +
  theme_light() +
  geom_point(data = toplot %>%
    filter(id_rank == 8346, id %in% c(1996, 2008))) +
  ggrepel::geom_text_repel(
    data = toplot %>%
      filter(id_rank == 8346, id %in% c(1996, 2008)),
    aes(label = sprintf("Climate year %d: %0.0f MW", id, res_load)),
    box.padding = 1.5
  )

ggsave("figure31.png", width = 6, height = 3)
