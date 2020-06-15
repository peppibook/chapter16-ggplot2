# library(ggmap)
# register_google(key='AIzaSyCK...E9urxjSpPOA')  # ±¸±ÛÅ°  µî·Ï
library(ggplot2)



names <- c("Yong Du Arm","Sung San","Jung Bang",
           "Jung Mun","Han Ra 1100","Cha Gyeo") 
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125") 
gc <- geocode(enc2utf8(addr))           # Latitude, Longitude 
gc

# Create a dataframe
df <- data.frame(name=names, 
                 lon=gc$lon, 
                 lat=gc$lat) 
df

cen <- c(mean(df$lon),mean(df$lat))     # Centuralized 
map <- get_googlemap(center=cen,        # Bring the map  
                     maptype="roadmap",               # map type
                     zoom=10,                         # Zoom out
                     size=c(640,640),                 # map size
                     marker=gc)                       # Markers on the map
ggmap(map)                              # markers on the map

# Put Tourist attraction sites on the map 
gmap <- ggmap(map)
gmap+geom_text(data=df,                 # Texts on the map
               aes(x=lon,y=lat),        # coordinates 
               size=3,                  # text size
               label=df$name)           # contexts

