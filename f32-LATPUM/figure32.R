# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure32.csv")

g <- ggplot(toplot, aes(x = xid, y = rl)) +
  geom_segment(
    aes(x = xid, xend = xid, y = rl, yend = rl - pump_net, color = as.factor(sign(pump_net))),
    alpha = 0.5, size = 0.05
  ) +
  geom_point(
    aes(x = xid, y = rl - pump_net, color = as.factor(sign(pump_net))),
    size = 0.1, alpha = 0.5
  ) +
  geom_line() +
  geom_line(
    data = toplot %>%
      group_by(id) %>% arrange(-rrl) %>%
      mutate(out = zoo::rollmean(rl - pump_net, k = 200, fill = NA)),
    aes(x = xid, y = out), color = "grey10"
  ) +
  facet_wrap(~id) +
  scale_color_manual(
    values = c("#a52576", "grey80", "#00818d"),
    labels = c("Pumping", "", "Generating"),
    name = ""
  ) +
  scale_x_continuous(labels = scales::percent) +
  xlab("Fraction of the year") +
  ylab("Residual load (MW)") +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(override.aes = list(size = 1, alpha = 1))) +
  geom_rug(
    data = toplot %>% filter(pump_net != 0),
    aes(color = as.factor(sign(pump_net))), sides = "b", size = 0.1
  )

ggsave("figure32.png", width = 6, height = 2.5)
