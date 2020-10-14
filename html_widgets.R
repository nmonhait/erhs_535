library(leaflet)
library(ggplot2)
library(plotly)
library(DT)

#read in data
ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")

#leaflet for `encounter_length`
pal <- colorQuantile("YlOrRd", NULL, n = 8)
leaflet(ufo_sightings) %>% 
  addTiles() %>%
  addCircleMarkers(color = ~pal(encounter_length))

#plotly for `shape`

#filter to 3 shapes
ufo_sightings_shapes <- ufo_sightings %>% 
  filter(ufo_shape %in% c("circle", "fireball", "oval"))
#plot
p <- ggplot(data = ufo_sightings_shapes, aes(x = ufo_shape)) +
  geom_bar(position = "dodge")
ggplotly(p)

#DT
datatable(ufo_sightings, options = list(pageLength = 5))
