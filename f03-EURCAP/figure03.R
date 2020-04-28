library(tidyverse)

data_toplot <- read_csv("data_figure03.csv")
g <- ggplot(data_toplot, aes(x = as.numeric(year), y = fraction, fill = type_label)) +
  geom_area() +
  theme_light() +
  scale_fill_manual(
    values = c(
      "Wind power" = "#c9cf5c",
      "Hydro-power" = "#00a0e1ff",
      "Solar power" = "#e6a532"
    ),
    name = ""
  ) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_x_continuous(breaks = seq(1990, 2017, 3)) +
  labs(x = "year", y = "Fraction of the total capacity") +
  theme_minimal() 

ggsave("figure03.png", width = 6, height = 3)
