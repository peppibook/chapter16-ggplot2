
# Google maps
library(ggplot2)
library(ggmap)

#
# Register your GOOGLE KEY!!
#
register_google(key='AIzaSyBClez4HTaT4HL08e487E1NG6T63sBxbDQ')   # Register the google key.

gc <- geocode(enc2utf8("종로구"))               # longitide and latitude
gc
cen <- as.numeric(gc)                           # transit longitide and latitudeÎ into numbers
cen
map <- get_googlemap(center=cen)                # create the map
ggmap(map)                                      # Show the map 

#
# Create a google map of Seoul.
#
gc2 <- geocode(enc2utf8("Seoul"))
gc2
cen2 <- as.numeric(gc2)                           # transit longitide and latitudeÎ into numbers
cen2
map2 <- get_googlemap(center=cen2)                # create the map
ggmap(map2)                                      # Show the map 


#
# Create a google map of Paris.
#
gc3 <- geocode(enc2utf8("Paris"))
gc3
cen3 <- as.numeric(gc3)                           # transit longitide and latitudeÎ into numbers
cen3
map3 <- get_googlemap(center=cen3)                # create the map
ggmap(map3)                                      # Show the map 


# Seol-Ak-San mountain
gc <- geocode(enc2utf8("설악산"))         # longitude and latitude 
cen <- as.numeric(gc)                     # transit them into numbers
map <- get_googlemap(center=cen,          # Centuralized 
                     zoom=9,              # Zoom out
                     size=c(640,640),     # map size
                     maptype="roadmap")   # map type
ggmap(map)                                # Show the map

# London
gc4 <- geocode(enc2utf8("London"))         # longitude and latitude 
cen4 <- as.numeric(gc4)                     # transit them into numbers
map4 <- get_googlemap(center=cen4,          # Centuralized 
                     zoom=9,              # Zoom out
                     size=c(640,640),     # map size
                     maptype="hybrid")   # map type
ggmap(map4)                                # Show the map

# Show the map by entering the longitude and latitude
# library(ggmap)
# register_google(key='AIzaSyCK...E9urxjSpPOA') # Register your google key

cen <- c(-118.233248, 34.085015) # It is a google map for LA.
map <- get_googlemap(center=cen)              # Create the map
ggmap(map)                                    # Show the map


# Make a marker on the center of a google map

gc5 <- geocode(enc2utf8("용인시"))        # longitude, latitude
cen5 <- as.numeric(gc5)                  #  transit them into numbers
map5 <- get_googlemap(center=cen5,       # Centuralized
                     maptype="roadmap",              # map type
                     marker=gc5)                      # make a marker
ggmap(map5)                             # Show a google map

# London
gc6 <- geocode(enc2utf8("London"))        # longitude, latitude
cen6 <- as.numeric(gc6)                  #  transit them into numbers
map6 <- get_googlemap(center=cen6,       # Centuralized
                     maptype="roadmap",              # map type
                     marker=gc6)                      # make a marker
ggmap(map6)                             # Show a google map

# Sejong University
gc7 <- geocode(enc2utf8("Sejong University"))         # longitude and latitude 
cen7 <- as.numeric(gc7)                     # transit them into numbers
map7 <- get_googlemap(center=cen7,          # Centuralized 
                      zoom=9,              # Zoom out
                      size=c(320,320),     # map size
                      maptype="roadmap",
                      marker=gc7)   # map type
ggmap(map7)                                # Show the map
