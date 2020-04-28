# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

res_var <- read_csv("data_figure28.csv")
g <- ggplot(res_var, aes(x = h)) +
  geom_line(aes(y = cvres), color = "grey50") +
  geom_line(aes(y = smoothed_cv), color = "black") +
  labs(
    x = "", y = "Rel. Standard Deviation\nResidual Load (%)"
  ) +
  theme_light() +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_x_datetime(date_labels = "%b", date_breaks = "1 month")

ggsave("figure28.png", width = 6, height = 2.5)
