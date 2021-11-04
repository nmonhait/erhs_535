
#set package repo----
options(repos = c("https://packagemanager.rstudio.com/all/2020-10-01+Y3JhbiwyOjI4Nzs0QzY3NkFEQQ"))
#verify package source
options('repos')


#initialize renv
#renv::init() (only needed at the start of a project)

#libraries----
library(tidyverse)
library(lubridate)
library(leaflet)
library(DT)
library(plotly)

#snapshot
#renv::snapshot() (only needed periodically during work)

#read in data----
ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")

#exercise 1----
##data manipulation
ufo_sightings_us <- ufo_sightings %>% 
  filter(country == "us") %>% 
  mutate(date_time = mdy_hm(date_time),
         date_documented = mdy(date_documented))

##parameterized Rmd (see params.Rmd)

#exercise 2----
##leaflet for `encounter_length`
pal <- colorQuantile("YlOrRd", NULL, n = 8)

leaflet(ufo_sightings) %>% 
  addTiles() %>%
  addCircleMarkers(color = ~pal(encounter_length))

##plotly for `shape`

#filter to 3 shapes
ufo_sightings_shapes <- ufo_sightings %>% 
  filter(ufo_shape %in% c("circle", "fireball", "oval"))
#plot
p <- ggplot(data = ufo_sightings_shapes, aes(x = ufo_shape)) +
  geom_bar(position = "dodge")
ggplotly(p)

#DT
datatable(ufo_sightings_us, options = list(pageLength = 5))

#exercise 3----
##see ufo_dashboard.Rmd