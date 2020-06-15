install.packages("maps")
install.packages("mapproj")
library(maps)
library(mapproj)


# Load a shapefile of U.S. states using ggplot's `map_data()` function
state_shape <- map_data("state")

head(state_shape)

# Create a blank map of U.S. states
ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group),
    color = "white", # show state outlines
    size = .1        # thinly stroked
  ) +
  coord_map() # use a map-based coordinate system

# Create a data frame of city coordinates to display
cities <- data.frame(
  city = c("Seattle", "Denver"),
  lat = c(47.6062, 39.7392),
  long = c(-122.3321, -104.9903)
)

# Draw the state outlines, then plot the city points on the map
ggplot(state_shape) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group)) +
  geom_point(
    data = cities, # plots own data set
    mapping = aes(x = long, y = lat), # points are drawn at given coordinates
    color = "red"
  ) +
  coord_map() # use a map-based coordinate system


# Load and format eviction notices data
# Data downloaded from https://catalog.data.gov/dataset/eviction-notices

# Load packages for data wrangling and visualization
library("dplyr")
library("tidyr")


#
# Practice the function 'as.Date'
dates <- c("02/27/2017", "02/27/1992", "01/14/1992", "02/28/1992", "02/01/1992")
as.Date(dates, "%m/%d/19%y")


x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z

#
# Practice the function 'separate'
install.packages("dplyr")
library(dplyr)

df <- data.frame(x = c(NA, "a.b", "a.d", "b.c"))
df %>% separate(x, c("A", "B"))

# If only want to split specified number of times use extra = "merge"
df <- data.frame(x = c("x: 123", "y: error: 7"))
df %>% separate(x, c("key", "value"), ": ", extra = "merge")

?separate
df <- data.frame(x = c("POINT (-13 234.8512890111102347)", "POINT (-234 12.5)", "POINT (-256 567.5)"))

df <- df %>% separate(x, c(NA, "B"), " ", extra="merge") %>% separate(B, c("lat", "long")," ")

as.numeric(gsub("\\(","",df$lat), options(digits = 15))
as.double(gsub("\\)", "", df$long), options(digits = 20)) # remove closing parentheses

df7 <- data.frame(x = c(NA, "a.b", "a.d", "b.c"))
df7 %>% separate(x, c("A", "B"))

# If you just want the second variable:
df7 %>% separate(x, c(NA, "B"))

# Select the col(Location)
df2 <- notices %>% select(Location)
df2
is.data.frame(df2)

df2 <- notices %>% separate(Location, c(NA, "B"), " ", extra="merge") %>% separate(B, c("lat", "long")," ")
df2$lat
df2 <- df2 %>% separate(c("lat", "long")," ")

# Load .csv file of notices
notices <- read.csv("sources/Eviction_Notices.csv", stringsAsFactors = F)

# Remove the NA
notices <- notices[complete.cases(notices),]

df2 <- notices %>% 
  mutate(date = as.Date(File.Date, format="%m/%d/20%y")) %>%
  filter(format(date, "%Y") == "2017") %>%
  separate(Location, c(NA, "B"), " ", extra="merge") %>% 
  separate(B, c("lat", "long")," ") %>%
  mutate(
    lat = as.numeric(gsub("\\(", "", lat)), # remove starting parentheses
    long = as.numeric(gsub("\\)", "", long)) # remove closing parentheses
  )
df2$lat
df2$long

?as.numeric

# Data wrangling: format dates, filter to 2017 notices, extract lat/long data
notices <- notices %>%
  mutate(date = as.Date(File.Date, format="%m/%d/20%y")) %>%
  filter(format(date, "%Y") == "2017") %>%
  separate(Location, c(NA, "B"), " ", extra = "merge") %>% # split 'POINT' and '()'
  separate(B, c("lat", "long"), " ") %>% # split column at the space
  mutate(
    lat = as.numeric(gsub("\\(", "", lat)), # remove starting parentheses
    long = as.numeric(gsub("\\)", "", long)) # remove closing parentheses
  )
notices$lat
notices$long
is.numeric(notices$lat)

head(notices)
View(notices)

# Create a map of San Francisco, with a point at each eviction notice address
# Use `install_github()` to install the newer version of `ggmap` on GitHub
#devtools::install_github("dkhale/ggmap") # once per machine
install.packages("ggmap")
citation("ggmap")
library("ggmap")
library("ggplot2")

# qmplot function 
?qmplot

# only violent crimes
violent_crimes <- subset(crime,
                         offense != "auto theft" &
                           offense != "theft" &
                           offense != "burglary"
)

# rank violent crimes
violent_crimes$offense <- factor(
  violent_crimes$offense,
  levels = c("robbery", "aggravated assault", "rape", "murder")
)

# restrict to downtown
violent_crimes <- subset(violent_crimes,
                         -95.39681 <= lon & lon <= -95.34188 &
                           29.73631 <= lat & lat <=  29.78400
)

View(violent_crimes)

theme_set(theme_bw())

qmplot(lon, lat, data = violent_crimes, colour = offense,
       size = I(3.5), alpha = I(.6), legend = "topleft")

qmplot(lon, lat, data = violent_crimes, geom = c("point","density2d"))
qmplot(lon, lat, data = violent_crimes) + facet_wrap(~ offense)
qmplot(lon, lat, data = violent_crimes, extent = "panel") + facet_wrap(~ offense)
qmplot(lon, lat, data = violent_crimes, extent = "panel", colour = offense, darken = .4) +
  facet_wrap(~ month)

