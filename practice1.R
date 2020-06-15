install.packages("ggplot2") # once per machine
library("ggplot2")          # in each relevant script

# Plot the `midwest` data set, with college education rate on the x-axis and
# percentage of adult poverty on the y-axis
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty))

# A bar chart of the total population of each state
# The `state` is mapped to the x-axis, and the `poptotal` is mapped
# to the y-axis
ggplot(data = midwest) +
  geom_col(mapping = aes(x = state, y = poptotal))

# A hexagonal aggregation that counts the co-occurrence of college
# education rate and percentage of adult poverty
ggplot(data = midwest) +
  geom_hex(mapping = aes(x = percollege, y = percadultpoverty))

# A plot with both points and a smoothed line
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty)) +
  geom_smooth(mapping = aes(x = percollege, y = percadultpoverty))

# Change the color of each point based on the state it is in
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = state)
  )

# Set a consistent color ("red") for all points -- not driven by data
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty),
    color = "red",
    alpha = .9
  )

?geom_point()
View(midwest)

# Load the `dplyr` and `tidyr` libraries for data manipulation
install.packages("dplyr")
install.packages("tidyr")
library("dplyr")
library("tidyr")

# Wrangle the data using `tidyr` and `dplyr` -- a common step!
# Select the columns for racial population totals, then
# `gather()` those column values into `race` and `population` columns
state_race_long <- midwest %>%
  select(state, popwhite, popblack, popamerindian, popasian, popother) %>%
  gather(key = race, value = population, -state) # all columns except `state`

head(state_race_long)
tail(state_race_long)

# Create a stacked bar chart of the number of people in each state
# Fill the bars using different colors to show racial composition
ggplot(state_race_long) +
  geom_col(mapping = aes(x = state, y = population, fill = race))

# Create a percentage (filled) column of the population (by race) in each state
ggplot(state_race_long) +
  geom_col(
    mapping = aes(x = state, y = population, fill = race), position = "fill"
  )

# Create a grouped (dodged) column of the number of people (by race) in each state
ggplot(state_race_long) +
  geom_col(
    mapping = aes(x = state, y = population, fill = race), position = "dodge"
  )
