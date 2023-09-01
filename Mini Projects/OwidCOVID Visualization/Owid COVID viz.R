library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggmap)
library(maps)
library(sf)

covid_data <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")
covid_data$location <- ifelse(covid_data$location == "United States","USA", covid_data$location)


vaccination_data <- covid_data %>%
  filter(year(date) == 2021) %>%
  group_by(location) %>%
  summarize(total_vaccinations = max(total_vaccinations, na.rm = TRUE),
            population = max(population, na.rm = TRUE)) %>%
  #mutate(vaccination_rate = 100 * total_vaccinations / population)%>%
  #mutate(vaccination_rate = ifelse(vaccination_rate > 100, 100, vaccination_rate))
  mutate(vaccination_rate = scales::rescale(100 * total_vaccinations / population, to = c(0, 100)))


world_map <- map_data("world")
vaccination_data <- vaccination_data%>% rename(region = location)
vaccination_map <- left_join(world_map, vaccination_data, by = "region")

ggplot(vaccination_map, aes(x = long, y = lat, group = group, fill = vaccination_rate)) +
  geom_polygon() +
  geom_path(data = vaccination_map, aes(x = long, y = lat, group = group), color = "gray50") +
  scale_fill_gradient(low = "white", high = "green", na.value = "gray90", limits = c(0, 100)) +
  labs(title = "COVID-19 Vaccination Rate by Country - 2021", fill = "Vaccination Rate (%)") +
  coord_fixed(1.3) +
  theme_void()