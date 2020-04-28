# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(patchwork)

toplot <- read_csv("data_figure33_01.csv")

bar_data <- read_csv("data_figure33_02.csv") %>%
  mutate(
    step = as.factor(step) %>%
      fct_relevel(
        "[1,4.4e+02]", "(4.4e+02,8.8e+02]", "(8.8e+02,1.3e+03]",
        "(1.3e+03,1.8e+03]", "(1.8e+03,2.2e+03]", "(2.2e+03,2.6e+03]",
        "(2.6e+03,3.1e+03]", "(3.1e+03,3.5e+03]", "(3.5e+03,4e+03]",
        "(4e+03,4.4e+03]", "(4.4e+03,4.8e+03]", "(4.8e+03,5.3e+03]",
        "(5.3e+03,5.7e+03]", "(5.7e+03,6.1e+03]",
        "(6.1e+03,6.6e+03]", "(6.6e+03,7e+03]", "(7e+03,7.5e+03]",
        "(7.5e+03,7.9e+03]", "(7.9e+03,8.3e+03]", "(8.3e+03,8.8e+03]"
      ) %>%
      fct_rev()
  )

g1 <- ggplot(toplot, aes(x = 1 - (rrl / 8760), y = rl, color = as.factor(id))) +
  geom_line(size = 1) +
  geom_vline(
    xintercept = 1 - c(
      440L, 879L, 1318L, 1757L, 2196L, 2636L, 3075L, 3514L, 3953L,
      4392L, 4831L, 5271L, 5710L, 6149L, 6588L, 7027L, 7466L, 7906L,
      8345L
    ) / 8760,
    linetype = "dashed", color = "grey50"
  ) +
  scale_x_continuous(labels = scales::percent) +
  xlab("Fraction of the year") +
  ylab("Residual load (MW)") +
  scale_color_brewer(palette = "Dark2", name = "year")

g2 <- ggplot(bar_data, aes(x = step, y = n, fill = as.factor(flow))) +
  geom_bar(stat = "identity", width = 1) +
  facet_wrap(~id, ncol = 2) +
  scale_fill_manual(
    values = c("#a52576", "grey80", "#00818d"),
    labels = c("Pumping", "", "Generating"),
    name = ""
  ) +
  geom_vline(
    xintercept = 0.5 + seq(1, 19),
    linetype = "dashed", color = "grey50"
  ) +
  # geom_label(
  #   data = label_data %>%
  #     filter(flow == -1),
  #   aes(label = sprintf("Pumped %0.0f GWh (%d hours)", x, n)),
  #   x = 15, y = 415, fill = "white", size = 3, alpha = 0.6
  # ) +
  # geom_label(
  #   data = label_data %>%
  #     filter(flow == 1),
  #   aes(label = sprintf("Turbined %0.0f GWh (%d hours)", x, n)),
  #   x = 6, y = 20, fill = "white", size = 3, alpha = 0.6
  # ) +
  labs(
    x = "Fraction of the year (%)",
    y = "Number of hours"
  ) +
  theme(axis.text.x = element_blank())

gout <- g1 / g2
ggsave("figure33.png", width = 9, height = 7)
