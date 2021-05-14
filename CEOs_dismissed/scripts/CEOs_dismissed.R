# Load libraries
library(tidyverse)
library(here)

# Load and filter data
CEO_data <- read_csv(here("CEOs_dismissed", "data", "departures.csv"))
#view(CEO_data) # check that the data was loaded properly

# Process data
years_count <- as.data.frame( # store the following as a dataframe
  table(CEO_data$fyear)) %>% # use table function to count the number of occurrences of each value in the fyear column
subset(Var1 != 1987) %>% # remove the data for year 1987 because there is no data until 1992
subset(Var1 != 2020) # remove the data for year 2020 because it is not complete
#view(years_count) # check that the data was processed properly

# Plot data
ggplot(years_count, # plot the dataframe years_count
       aes(x = Var1, # set x axis to discrete years
           y = Freq, # set Y axis to frequency
           fill = Freq)) + # set fill color to also represent frequency
  labs(title = "Number of CEOs dismissed in years 1992-2019",
       x = "Year",
       y = "Number of CEOs dismissed", # set labels
       fill = "") + # set legend label to empty
  theme(axis.text.x = element_text(angle = 90)) + # rotate X axis labels
  geom_bar(stat = "identity") + # render bar graph with axes assigned above
  scale_fill_gradient(low = "black", high = "red") # set color gradient for the bars and assign colors

ggsave(here("CEOs_dismissed","output","bar_chart.jpg"),#save plot
       width = 7, height = 5) #set aspect ratio
