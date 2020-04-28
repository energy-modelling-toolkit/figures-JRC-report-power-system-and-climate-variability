# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

sel <- read_csv("data_figure07.csv")

g <- ggplot(sel, aes(x = region, y = perc_dev, fill = label)) +
  geom_boxplot(fatten = NULL) +
  geom_hline(yintercept = 0, alpha = 0.5, linetype = "dashed") +
  scale_y_continuous(
    labels = scales::percent_format(accuracy = 1),
    breaks = seq(-0.1, 0.1, 0.02),
    limits = c(-0.08, 0.08)
  ) +
  labs(
    y = "Inter-annual deviation\n from average (%)"
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("#c4132a", "#9dad20"), name = "") +
  theme(
    legend.position = "bottom"
  ) 

ggsave("figure07.png", width = 4.7, height = 3.2)
