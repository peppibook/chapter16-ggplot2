# library(ggmap)
# register_google(key='AIzaSyCK...E9urxjSpPOA') # ????Ű  ????
# library(ggplot2)

# Prepare the dataset
sp <- sample(1:nrow(wind),50)                   # Sample 50 out of the dataset
df <- wind[sp,]
head(df)

cen <- c(mean(df$lon), mean(df$lat))            # Centuralized
gc <- data.frame(lon=df$lon, lat=df$lat)        # Coordinates
head(gc)

# Make markers on the map
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=6,
                     marker=gc)
ggmap(map)

# Express the circle size proportional to wind velocity
map <- get_googlemap(center=cen,                # Bring the map
                     maptype="roadmap",
                     zoom=6)
gmap <- ggmap(map)                              # save the map
gmap+geom_point(data=df,                        # Circle on the map
                aes(x=lon,y=lat,size=spd),
                alpha=0.5, 
                col="blue") +
  scale_size_continuous(range = c(1, 14))      # control the circle size
