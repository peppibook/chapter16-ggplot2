# Plot the `midwest` data set, with college education rate on the x-axis and
# percentage of adult poverty on the y-axis. Color by state.
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty, color = state))

# Create a better label for the `inmetro` column
labeled <- midwest %>%
  mutate(location = if_else(inmetro == 0, "Rural", "Urban"))

labeled

# Subset data by state
wisconsin_data <- labeled %>% filter(state == "WI")
michigan_data <- labeled %>% filter(state == "MI")
wisconsin_data
# Define continuous scales based on the entire data set:
# range() produces a (min, max) vector to use as the limits
x_scale <- scale_x_continuous(limits = range(labeled$percollege))
y_scale <- scale_y_continuous(limits = range(labeled$percadultpoverty))

x_scale
y_scale

# Define a discrete color scale using the unique set of locations (urban/rural)
color_scale <- scale_color_discrete(limits = unique(labeled$location))

# Plot the Wisconsin data, explicitly setting the scales
ggplot(data = wisconsin_data) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location)
  ) +
  x_scale +
  y_scale +
  color_scale

# Plot the Michigan data using the same scales
ggplot(data = michigan_data) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location)
  ) +
  x_scale +
  y_scale +
  color_scale

# Change the color of each point based on the state it is in
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = state)
  ) +
#  scale_color_brewer(palette = "Set1") # use the "Set3" color palette
 scale_color_manual(values = c("red", "blue", "green", "yellow", "black"))

?top_n

df <- data.frame(x = c(10, 4, 1, 6, 3, 1, 1))
df %>% top_n(2)

# Create a horizontal bar chart of the most populous counties
# Thoughtful use of `tidyr` and `dplyr` is required for wrangling

# Filter down to top 10 most populous counties
top_10 <- midwest %>%
  top_n(10, wt = poptotal) %>%
  unite(county_state, county, state, sep = ", ") %>% # combine state + county
  arrange(poptotal) %>% # sort the data by population
  mutate(location = factor(county_state, county_state)) # set the row order

county_state
?unite
df <- expand_grid(x = c("a", NA), y = c("b", NA))
df

df %>% unite("z", x:y, remove = FALSE)

?mutate
a = c(10,20,30)
b = c(1,2,3)
c = c(4,5,6)
d = c(7,8,9)
df=data.frame(a,b,c,d)
b1=sum(b+1)
b1

df_1 = df %>% mutate(a1=sum(a+1)) 
df_1

# Render a horizontal bar chart of population
ggplot(top_10) +
  geom_col(mapping = aes(x = location, y = poptotal)) +
  coord_flip() # switch the orientation of the x- and y-axes

# Create a better label for the `inmetro` column
labeled <- midwest %>%
  mutate(location = if_else(inmetro == 0, "Rural", "Urban"))
labeled
labeled$inmetro

# Create the same chart as Figure 16.9, faceted by state
ggplot(data = labeled) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location),
    alpha = .6
  ) +
  facet_wrap(~state) # pass the `state` column as a *fomula* to `facet_wrap()`

?facet_wrap

# Adding better labels to the plot in Figure 16.10
ggplot(data = labeled) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location),
    alpha = .6
  ) +
  
  # Add title and axis labels
  labs(
    title = "Percent College Educated versus Poverty Rates", # plot title
    x = "Percentage of College Educated Adults", # x-axis label
    y = "Percentage of Adults Living in Poverty", # y-axis label
    color = "Urbanity" # legend label for the "color" property
  )

# Load the `ggrepel` package: functions that prevent labels from overlapping
install.packages("ggrepel")
library(ggrepel)

# Find the highest level of poverty in each state
most_poverty <- midwest %>%
  group_by(state) %>% # group by state
  top_n(1, wt = percadultpoverty) %>% # select the highest poverty county
  unite(county_state, county, state, sep = ", ") # for clear labeling

# Store the subtitle in a variable for cleaner graphing code
subtitle <- "(the county with the highest level of poverty
  in each state is labeled)"

# Plot the data with labels
ggplot(data = labeled, mapping = aes(x = percollege, y = percadultpoverty)) +
  
  # add the point geometry
  geom_point(mapping = aes(color = location), alpha = .6) +
  # add the label geometry
  geom_label_repel(
    data = most_poverty, # uses its own specified data set
    mapping = aes(label = county_state),
    alpha = 0.8
  ) +
  
  # set the scale for the axis
  scale_x_continuous(limits = c(0, 55)) +
  
  # add title and axis labels
  labs(
    title = "Percent College Educated versus Poverty Rates", # plot title
    subtitle = subtitle, # subtitle
    x = "Percentage of College Educated Adults", # x-axis label
    y = "Percentage of Adults Living in Poverty", # y-axis label
    color = "Urbanity" # legend label for the "color" property
  )
