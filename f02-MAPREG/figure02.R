# This code has been used to generate the figures in the following report:
# De Felice, M., Busch, S., Kanellopoulos, K., Kavvadias, K. and Hidalgo Gonzalez, I., 
# Power system flexibility in a variable climate, 
# ISBN 978-92-76-18183-5 (online), doi:10.2760/75312 (online)
# This code is released under Creative Commons Attribution 4.0 International (CC BY 4.0) licence 
# (https://creativecommons.org/licenses/by/4.0/). 

library(tidyverse)
library(sf)

region_cmap <- c(
  "Europe" = "black",
  "CWE" = "#286FB7",
  "CEE" =  "#B9C21F",
  "UK & Ireland" =  "#A52576",
  "Northern" = "#00AFAD",
  "Iberia" = "#7B9522",
  "SEE" = "#D93A43",
  "Italy" = "#FCAF17"
)

toplot <- read_rds("toplot.rds")

g <- ggplot(toplot) +
  geom_sf(aes(fill = region_name), size = 0.1, color = "lightgrey") +
  coord_sf(xlim = c(-12, 35), ylim = c(32, 70)) +
  scale_fill_manual(values = region_cmap, na.value = "grey80", name = "") +
  theme_light()

ggsave("figure02.png", width = 6, height = 5)
