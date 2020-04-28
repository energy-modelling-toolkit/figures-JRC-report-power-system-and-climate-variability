# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(ggrepel)
library(gridExtra)

toplot_01 <- read_csv("data_figure16_01.csv")
qq_01     <- read_csv("data_figure16_qq_01.csv")
toplot_02 <- read_csv("data_figure16_02.csv")
qq_02     <- read_csv("data_figure16_qq_02.csv")

g1 = ggplot(toplot_01, aes(x = e_Northern, y = e_Iberia)) +
  geom_point(aes(alpha = str_length(label) > 0)) +
  ggrepel::geom_text_repel(aes(label = label), size = 3) +
  scale_alpha_manual(values = c(0.3, 1)) +
  guides(alpha = FALSE) +
  geom_hline(data = qq_01, aes(yintercept = Iberia), linetype = 'dotted') +
  geom_vline(data = qq_01, aes(xintercept = Northern), linetype = 'dotted') +
  labs(
    x = 'Northern hydropower generation (TWh)',
    y = 'Iberia hydropower generation (TWh)'
  ) + 
  theme_minimal() +
  theme(text = element_text(size = 8)) 

g2 <- ggplot(toplot_02, aes(x = e_British_Isles, y = e_Iberia)) +
  geom_point(aes(alpha = str_length(label) > 0)) +
  ggrepel::geom_text_repel(aes(label = label), size = 3) +
  scale_alpha_manual(values = c(0.3, 1)) +
  guides(alpha = FALSE) +
  geom_hline(data = qq_02, aes(yintercept = Iberia), linetype = "dotted") +
  geom_vline(data = qq_02, aes(xintercept = UK), linetype = "dotted") +
  labs(
    x = "UK & Ireland wind power generation (TWh)",
    y = "Iberia wind power generation (TWh)"
  ) +
  theme_minimal() +
  theme(text = element_text(size = 8))

gA <- ggplotGrob(g1)
gB <- ggplotGrob(g2)
maxWidth <- grid::unit.pmax(gA$widths[2:5], gB$widths[2:5])
gA$widths[2:5] <- as.list(maxWidth)
gB$widths[2:5] <- as.list(maxWidth)

png(
  filename = "figure16.png",
  width = 1000,
  height = 400, res = 180
)
gridExtra::grid.arrange(gA, gB, ncol = 2)
dev.off()
