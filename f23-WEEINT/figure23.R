# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

toplot <- read_csv("data_figure23.csv")

g <- ggplot(toplot, aes(x = w, y = net)) +
  geom_step(position = position_nudge(x = -0.5)) +
  geom_bar(
    stat = "identity",
    aes(
      fill = as.factor(sign(net)),
      alpha = cut(n,
        breaks = c(10, 16, 21, 25, 30),
        labels = c("<60%", "60%-80%", "80%-99%", "100%")
      )
    ),
    width = 1
  ) +
  geom_hline(yintercept = 0) +
  scale_x_continuous(breaks = seq(1, 54, 8)) +
  ylab("Weekly Net Flow (GWh)") +
  xlab("week") +
  facet_wrap(~zone, nrow = 2) +
  scale_fill_manual(
    values = c("#7b9522", "#034ea2"),
    labels = c("Import", "Export"),
    name = ""
  ) +
  scale_alpha_manual(values = c(0, 0.3, 0.7, 1), name = "agreement") +
  theme_light() +
  theme(legend.key = element_rect(colour = "black")) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    legend.position = "bottom"
  )

ggsave("figure23.png", width = 8, height = 5)
