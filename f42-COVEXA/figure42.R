# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)
library(patchwork)


x1_daily <- read_csv("data_figure42_01.csv")
x1_monthly <- read_csv("data_figure42_02.csv")
x2_daily <- read_csv("data_figure42_03.csv")
x2_monthly <- read_csv("data_figure42_04.csv")

g1 <- ggplot(x1_daily, aes(x = demand_anom, y = inflow_anom)) +
  geom_point(alpha = 0.5, color = "#00AFAD", size = 1) +
  labs(
    x = "Deviation from Winter daily demand (%)",
    y = "Deviation from Winter daily inflow (%)"
  )

g2 <- ggplot(x1_monthly, aes(x = demand_anom, y = inflow_anom)) +
  geom_point(alpha = 0.7, color = "#00AFAD", size = 3) +
  labs(
    x = "Deviation from Winter monthly demand (%)",
    y = "Deviation from Winter monthly inflow (%)"
  )

g3 <- ggplot(x2_daily, aes(x = demand_anom, y = wind_anom)) +
  geom_point(alpha = 0.5, color = "#A52576", size = 1) +
  labs(
    x = "Deviation from Winter daily demand (%)",
    y = "Deviation from Winter daily wind (%)"
  )

g4 <- ggplot(x2_monthly, aes(x = demand_anom, y = wind_anom)) +
  geom_point(alpha = 0.7, color = "#A52576", size = 3) +
  labs(
    x = "Deviation from Winter monthly demand (%)",
    y = "Deviation from Winter monthly wind (%)"
  )

g <- (g1 + g2) / (g3 + g4)

ggsave("figure42.png", width = 6.5, height = 6)
