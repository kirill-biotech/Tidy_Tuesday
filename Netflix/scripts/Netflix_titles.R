# Load libraries
library(tidyverse)
library(here)

# Load and filter data
# Will select only titles released from the year 2000 on and from top 5 countries with most releases
filt_data <- read_csv(here("Netflix", "data", "netflix_titles.csv")) %>% # load data from file into a dataframe
  subset(release_year >= 2000 & release_year < 2021) %>% # select titles no older than the year 2000 and exclude the incomplete 2021 data
  subset(country == c("United States","India","United Kingdom","Japan","South Korea")) # select only titles from top 5 countries
#view(filt_data) # check that the data was loaded and filtered correctly

# Process data
# 1. Subset data into separate dataframes for each country
# 2. Create dataframes of number of titles released each year for each country
US_titles <- subset(filt_data, country == "United States") # subset the filtered data set for the US
US_freq <- as.data.frame(table(US_titles$release_year)) # make a table of frequencies of release years and store it as a dataframe

India_titles <- subset(filt_data, country == "India") # subset the filtered data set for India
India_freq <- as.data.frame(table(UK_titles$release_year)) # make a table of frequencies of release years and store it as a dataframe

UK_titles <- subset(filt_data, country == "United Kingdom") # subset the filtered data set for the UK
UK_freq <- as.data.frame(table(UK_titles$release_year)) # make a table of frequencies of release years and store it as a dataframe

Japan_titles <- subset(filt_data, country == "Japan") # subset the filtered data set for Japan
Japan_freq <- as.data.frame(table(Japan_titles$release_year)) # make a table of frequencies of release years and store it as a dataframe

SK_titles <- subset(filt_data, country == "South Korea") # subset the filtered data set for South Korea
SK_freq <- as.data.frame(table(SK_titles$release_year)) # make a table of frequencies of release years and store it as a dataframe


# Plot processed data
ggplot() + # initiate ggplot with empty parameters, as they will be passed by individual datasets for each line
  geom_line(data = US_freq, aes(x = Var1, y = Freq, group = 1, color = 'red')) + # render a line for the US, set axes and group the corresponding years and frequencies, set color
  geom_line(data = India_freq, aes(x = Var1, y = Freq, group = 1, color = 'green')) + # render a line for India, set axes and group the corresponding years and frequencies, set color
  geom_line(data = UK_freq, aes(x = Var1, y = Freq, group = 1, color = 'blue')) + # render a line for the UK, set axes and group the corresponding years and frequencies, set color
  geom_line(data = Japan_freq, aes(x = Var1, y = Freq, group = 1, color = 'magenta')) + # render a line for Japan, set axes and group the corresponding years and frequencies, set color
  geom_line(data = SK_freq, aes(x = Var1, y = Freq, group = 1, color = 'cyan')) + # render a line for South Korea, set axes and group the corresponding years and frequencies, set color
  labs(title = "Number of titles released each year by each country as available on Netflix", # add plot title
       subtitle = "Since the year 2000, excluding 2021, by top 5 countries with most releases", # add plot subtitle
       x = "Year",
       y = "Number of titles released") + # set axis labels
  theme(axis.text.x = element_text(angle = 90)) + # rotate year labels
  scale_color_manual(name = "Country", labels = c("UK", "South Korea", "India", "Japan", "United States"), values = c("blue", "cyan", "green", "magenta", "red")) # set legend labels and colors

ggsave(here("Netflix","output","titles_by_country.jpg"),#save plot
       width = 7, height = 5) #set aspect ratio