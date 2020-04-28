# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I.,
# Power system flexibility in a variable climate,
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence
# (https://creativecommons.org/licenses/by/4.0/).

library(tidyverse)

region_cmap <- c(
  "Europe" = "black",
  "CWE" = "#286FB7",
  "CEE" =  "#B9C21F",
  "British_Isles" =  "#A52576",
  "British Isles" =  "#A52576",
  "UK & Ireland" =  "#A52576",
  "Northern" = "#00AFAD",
  "Iberia" = "#7B9522",
  "SEE" = "#D93A43",
  "Italy" = "#FCAF17"
)

pp <- read_csv("data_figure11.csv")

g <- ggplot(
  pp %>%
    filter(Technology == "HPHS") %>%
    mutate(label = ifelse(storage > 400e3, sprintf("%0.1f\nGWh", storage / 1e3), "")),
  aes(
    x = Technology,
    label = label,
    y = storage / 1e3,
    fill = region
  )
) +
  geom_bar(stat = "identity") +
  scale_x_discrete(labels = "Pumping hydropower") +
  geom_text(
    position = position_stack(vjust = 0.5)
  ) +
  scale_fill_manual(values = region_cmap, name = "") +
  labs(y = "Maximum storage (GWh)", x = "") +
  coord_flip() +
  theme_minimal()
ggsave("figure11.png", width = 7, height = 2)
