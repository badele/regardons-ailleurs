source("lib/R/file.R")
source("lib/R/image.R")

suppressPackageStartupMessages({
  library(sf)
  library(here)
  library(units)
  library(magick)
library(R.cache)
  library(osmdata)
  library(ggplot2)
  library(tidyverse) 
  library(paletteer)
  library(lubridate)
  library(kableExtra)
  library(MASS)
})

#library(ggmap)
library(ggspatial)

options(error=traceback) 

# Function
get_density <- function(x, y, ...) {
  dens <- MASS::kde2d(x, y, ...)
  ix <- findInterval(x, dens$x)
  iy <- findInterval(y, dens$y)
  ii <- cbind(ix, iy)
  return(dens$z[ii])
}

# Variables
scriptdir <- here()
sourcedata <- "vigilo"
pagename <- "exercice-etude-incivilite-urbaine"
imagedir <- paste0(scriptdir,"/static")
logopath <- paste0(scriptdir,"/sources/logo-2.png")

instances <- evalWithMemoization({
  read_fwf("..//world-datas-analysis/dataset/vigilo/instances.txt")
})

categories <- evalWithMemoization({
  read_fwf("..//world-datas-analysis/dataset/vigilo/categories.txt")
})

obs <- evalWithMemoization({
  read_fwf("..//world-datas-analysis/dataset/vigilo/observations.txt")
})


noland <- c("Orvault")
nowater <- c("Saint-Herblain")
nopark <- c("Saint-Herblain")
nobuilding <- c("Bordeaux","Marseille")
nodistrict <- c("Castelnau-Le-Lez")

citiesconverter <-list(
  "Castelnau-Le-Lez"="Castelnau-le-Lez"
)

# Filtre les observations
filteredobs <- evalWithMemoization({
  obs %>%
  inner_join(categories) %>%
  mutate(
    year = lubridate::year(datetime), 
    month = lubridate::month(datetime), 
    day = lubridate::day(datetime)
  ) %>%
  filter(year>=2020, catname == 'Véhicule ou objet gênant', approved == 1) %>%
  mutate(
    across(c(scope, cityname, catname),as.factor),
    datetime = as_date(datetime)
  ) 
})


topcities <- filteredobs %>%
  inner_join(instances) %>%
  group_by(cityname,country) %>%
  summarise(
    minlat = min(coordinates_lat),
    maxlat = max(coordinates_lat),
    minlon = min(coordinates_lon),
    maxlon = max(coordinates_lon),
    nb = n()
  ) %>%
  arrange(desc(nb)) %>%
  head(15)

MINOBS = 30
set_overpass_url("https://maps.mail.ru/osm/tools/overpass/api/interpreter")
for (idx in seq_len(nrow(topcities))) {
  if (topcities$nb[idx]<MINOBS) {
    print(paste0(topcities$cityname[idx]," ",topcities$nb[idx]))
    next
  }

  # City name must be convert ?
  vigilocity <- topcities$cityname[idx]
  currentosmcity <- vigilocity
  if (currentosmcity %in% names(citiesconverter)) {
    currentosmcity <- citiesconverter[[paste(currentosmcity)]]
  }

  imagename <- paste0("/tmp/osm_",sprintf("%04d", idx),currentosmcity,".png")
  print(paste0("=== check",imagename))
  if (file.exists(imagename)) {
    next
  }

  selectedobs <- filteredobs %>%
    filter(
      cityname==vigilocity
    ) %>%
    st_as_sf(
      coords = c("coordinates_lon", "coordinates_lat"), 
      crs = 4326
      ) 

  selectedobs <- st_transform(selectedobs,2154)

  selectedobs <- selectedobs %>%
    mutate(
        coordinates_lon = unlist(map(geometry,1)),
        coordinates_lat = unlist(map(geometry,2))
    )

  minyear <- min(selectedobs$year)
  maxyear <- max(selectedobs$year)

  bbox <- getbb(paste(currentosmcity," , ",topcities$country[idx]))

  cachename <- paste0('.cache/stationnement_genant_villes_OSM_',currentosmcity,'.Rdata')
  if (file.exists(cachename)) {
    print(paste0("Load cache for ",currentosmcity))
    load(cachename)
  } else {
    print(paste0("Caching ",currentosmcity))


    feature.boundary <- NULL
    feature.district <- NULL
    feature.land <- NULL
    feature.building <- NULL
    feature.natural <- NULL
    feature.park <- NULL
    feature.water <- NULL
    ways.primary <- NULL
    ways.other <- NULL



    print("== get boundary")
    feature.boundary <- 
      bbox %>%
      opq()%>%
      add_osm_feature("admin_level",c(8)) %>%
      add_osm_feature(key="name",value=c(currentosmcity)) %>%
      osmdata_sf()

    # City not found, please use a citiesconverter key/value converter
    if (nrow(feature.boundary$osm_points) == 0) {
      stop(paste("======================== City ",currentosmcity, "not found"))
    }
    
    if (!(currentosmcity %in% nodistrict)) {
      print("== get district")
      feature.district <- 
        bbox %>%
        opq()%>%
        add_osm_feature("admin_level",c(11)) %>%
        osmdata_sf()
    }

    if (!(currentosmcity %in% noland)) {
      print("== get land")
      feature.land <- 
        bbox %>%
        opq()%>%
        add_osm_feature("landuse") %>%
        osmdata_sf()
    }
    
    if (!(currentosmcity %in% nopark)) {
      print("== get park")
      feature.park <- 
        bbox %>%
        opq()%>%
        add_osm_feature("leisure") %>%
        osmdata_sf()
    }

    if (!(currentosmcity %in% nobuilding)) {
      print("== get building")
      feature.building <- 
        bbox %>%
        opq()%>%
        add_osm_feature("building") %>%
        osmdata_sf()
    }

    if (!(currentosmcity %in% nowater)) {
      print("== get water")
      feature.water <- bbox %>%
        opq()%>%
        add_osm_feature('water') %>% 
        #add_osm_feature('natural', c('water')) %>% 
        osmdata_sf()
    }

    print("== get primary way")
    ways.primary <- bbox %>%
      opq()%>%
      add_osm_feature('highway', c('motorway', 'primary', 'secondary', 'tertiary')) %>% 
      osmdata_sf()

    print("== get other way")
    ways.other <- bbox %>%
      opq()%>%
      add_osm_feature('highway') %>%     
      osmdata_sf()

    cachelist <- list(
      feature.boundary = feature.boundary,
      feature.district = feature.district,
      feature.land = feature.land,
      feature.building = feature.building,
      feature.natural = feature.natural,
      feature.park = feature.park, 
      feature.water = feature.water,
      ways.primary = ways.primary,
      ways.other = ways.other
    )
    save(cachelist,file=cachename)
  }

  print("Compute boundary intersection")

  district <- NULL
  ways.primary <- NULL
  ways.other <- NULL
  building <- NULL
  water.multipolygons <- NULL
  water.polygons <- NULL
  land <- NULL
  park <- NULL

  # tryCatch(
  # {
    boundary <- st_transform(cachelist$feature.boundary$osm_multipolygons, 2154) 

    if (!is.null(cachelist$feature.district$osm_multipolygons)) {
      district <- st_transform(cachelist$feature.district$osm_multipolygons, 2154) 
      district <- st_intersection(district, boundary) 
    }

    if (!is.null(cachelist$ways.primary$osm_lines)) {
      ways.primary <- st_transform(cachelist$ways.primary$osm_lines, 2154)
      ways.primary <- st_intersection(ways.primary, boundary) 
    }

    if (!is.null(cachelist$ways.other$osm_lines)) {
      ways.other <- st_transform(cachelist$ways.other$osm_lines, 2154)
      ways.other <- st_intersection(ways.other, boundary) 
    }

    if (!is.null(cachelist$feature.land$osm_polygons)) {
      land <- st_transform(cachelist$feature.land$osm_polygons, 2154)
      land <- st_intersection(land, boundary) 
    }

    if (!is.null(cachelist$feature.park$osm_polygons)) {
      park <- st_transform(cachelist$feature.park$osm_polygons, 2154)
      park <- park %>%
        mutate(area = st_area(.)) %>%
        filter(area>=set_units(10000, "m^2"))

      park <- st_intersection(park, boundary) 
    }

    if (!is.null(cachelist$feature.building$osm_polygons)) {
      building <- st_transform(cachelist$feature.building$osm_polygons, 2154)
      building <- st_intersection(building, boundary) 
    }

    if (!is.null(cachelist$feature.water$osm_multipolygons)) {
      water.multipolygons <- st_transform(cachelist$feature.water$osm_multipolygons, 2154)
      water.multipolygons <- st_intersection(water.multipolygons, boundary)
    }
    if (!is.null(cachelist$feature.water$osm_polygons)) {
      water.polygons <- st_transform(cachelist$feature.water$osm_polygons, 2154)
      water.polygons <- st_intersection(water.polygons, boundary)
    }

    selectedobs <- st_intersection(selectedobs, boundary)


    print("Plot")
    g <- ggplot() +
      geom_sf(
        data = boundary, 
        fill = "#808080",
        color= '#404040',
        size = 0.5,
      )
          
    # Park
    if (!(currentosmcity %in% nopark) & !is.null(park)) {
      g <- g +
      geom_sf(
        data = park, 
        fill = "#67998b",
        color = NA,
        size = 0.05
      ) 
    }

    # # Water
    if (!(currentosmcity %in% nowater) & !is.null(water.multipolygons)) {
      g <- g +
      geom_sf(
        data = water.multipolygons, 
        fill = "#679299",
        color =  NA
      ) 
    } 

    if (!(currentosmcity %in% nowater) & !is.null(water.polygons)) {
      g <- g +
      geom_sf(
        data = water.polygons, 
        fill = "#679299",
        color =  NA
      )
    }

    # Land
    if (!(currentosmcity %in% noland) & !is.null(land)) {
      g <- g +
      geom_sf(
        data = land, 
        fill = "#808080",
        color= NA,
        size = 0.05,
      )
    }


    # Building
    if (!(currentosmcity %in% nobuilding) & !is.null(building)) {
      g <- g +
      geom_sf(
        data = building, 
        fill = "#707070",
        color= '#404040',
        size = 0.02,
      )
    }


    g <- g +
    geom_sf(data = ways.primary, color = '#AAAAAA', size = .2) +
    geom_sf(data = ways.other, color = '#AAAAAA', size = .05) 
    
    if (!(currentosmcity %in% nodistrict) & !is.null(district)) {
      g <- g +
      geom_sf(
        data = district, 
        fill = NA,
        color = '#ffe68040',
        linetype = 2,
        lwd = 0.1,
      )  
    }

    selectedobs$density <- get_density(selectedobs$coordinates_lon, selectedobs$coordinates_lat, n = 100)

    g <- g +
    geom_point(
      data=selectedobs,
      aes(x=coordinates_lon, y=coordinates_lat, color = density),
      size = 0.08,
      alpha=0.5,
      pch=20
    ) + 
    # scale_color_viridis()
    scale_color_gradient(low = "red", high = "yellow") 

    g <- g +
      geom_sf(
        data = boundary, 
        fill = NA,
        color= '#404040',
        size = 0.5,
      )

    if (!(currentosmcity %in% nodistrict) & !is.null(district)) {
      g <- g +
      geom_sf_text(data = district,
        aes(label = name),
        size = 0.6,
        alpha = 1,
        colour = "#CCCCCC"
      ) 
    }      

    g <- g +
    theme_minimal() + 
    theme(text = element_text(color = "#22211d"),
    axis.line = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title.x = element_text(size=9, color="grey90", hjust=0.25, vjust=3),
    axis.title.y = element_blank(),
    legend.position = "none",
    legend.text = element_text(size=9, color="grey20"),
    legend.title = element_text(size=10, color="grey20"),
    panel.grid.major = element_line(color = "#303030", size = 0.2),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face="bold", size=16, color="grey90", hjust=.5),
    plot.caption = element_text(size=8, color="grey90", hjust=1, vjust=0),
    plot.subtitle = element_text(size=12, color="grey70", hjust=.5),
    plot.margin = unit(c(t=1, r=-2, b=-1, l=-2),"lines"),
    plot.background = element_rect(fill = "#303030", color = NA), 
    panel.background = element_rect(fill = "#303030", color = NA), 
    legend.background = element_rect(fill = "#303030", color = NA),
    panel.border = element_blank()) +
    labs(x = "© Regardons ailleurs | Data: Vigilo ~ OpenStreetMap", 
        y = NULL, 
        title = currentosmcity, 
        subtitle = paste0("Stationements gênants\n",minyear, " - ", maxyear), 
        caption = "")

    print(paste0("=== Save ",imagename))
        
    ggsave(imagename,width= 7, height= 7, dpi = 1200)
    # tryCatch(
    #   {
    #     ggsave(imagename,width= 7, height= 7, dpi = 1200)
    #   },
    #   error = function(cond) {
    #       print(paste0("=== ERROR in ", currentosmcity))
    #     }
    # )
    Sys.sleep(2)
  # },
  # error = function(cond) {
  #         print(paste("=== ERROR in", currentosmcity,"City"))
  #       }  
  # )
}