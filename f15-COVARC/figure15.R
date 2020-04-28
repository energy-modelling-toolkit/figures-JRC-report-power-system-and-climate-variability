# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(ggrepel)
library(gridExtra)

toplot <- read_csv("data_figure15.csv")

g1 <- ggplot(toplot, aes(x = Hydro, y = Wind)) +
  geom_point(aes(alpha = str_length(label) > 0)) +
  geom_text_repel(aes(label = label), size = 3) +
  theme_light() +
  scale_alpha_manual(values = c(0.3, 1)) +
  guides(alpha = FALSE) +
  labs(
    x = "Hydro-power generation (TWh)",
    y = "Wind power generation (TWh)"
  ) +
  theme(text = element_text(size = 8))

g2 <- ggplot(toplot, aes(x = Hydro, y = Solar)) +
  geom_point(aes(alpha = str_length(label) > 0)) +
  geom_text_repel(aes(label = label), size = 3) +
  theme_light() +
  scale_alpha_manual(values = c(0.3, 1)) +
  guides(alpha = FALSE) +
  labs(
    x = "Hydro-power generation (TWh)",
    y = "Solar power generation (TWh)"
  ) +
  theme(text = element_text(size = 8))

g3 <- ggplot(toplot, aes(x = Wind, y = Solar)) +
  geom_point(aes(alpha = str_length(label) > 0)) +
  geom_text_repel(aes(label = label), size = 3) +
  theme_light() +
  scale_alpha_manual(values = c(0.3, 1)) +
  guides(alpha = FALSE) +
  labs(
    x = "Wind power generation (TWh)",
    y = "Solar power generation (TWh)"
  ) +
  theme(text = element_text(size = 8))

gA <- ggplotGrob(g1)
gB <- ggplotGrob(g2)
gC <- ggplotGrob(g3)
maxWidth <- grid::unit.pmax(gA$widths[2:5], gB$widths[2:5], gC$widths[2:5])
gA$widths[2:5] <- as.list(maxWidth)
gB$widths[2:5] <- as.list(maxWidth)
gC$widths[2:5] <- as.list(maxWidth)

png(
  filename = "figure15.png",
  width = 1000,
  height = 400, res = 180
)
grid.arrange(gA, gB, gC, ncol = 3)
dev.off()
