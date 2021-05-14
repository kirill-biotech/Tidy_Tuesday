# Load libraries
library(tidyverse)
library(here)

# Load and filter data
# Will select only titles released from the year 2000 on and from top 5 countries with most releases
filt_data <- read_csv(here("Netflix", "data", "netflix_titles.csv")) %>% # load data from file into a dataframe
  subset(release_year >= 2000) %>% # select titles no older than the year 2000
  subset(country == c("United States","India","United Kingdom","Japan","South Korea")) # select only titles from top 5 countries
#view(filt_data) # check that the data was loaded and filtered correctly

# Process data
# Create dataframes of number of titles released each year for each country
US_titles <- subset(filt_data, country == "United States")
US_freq <- as.data.frame(table(US_titles$release_year))

India_titles <- subset(filt_data, country == "India")
India_freq <- as.data.frame(table(UK_titles$release_year))

UK_titles <- subset(filt_data, country == "United Kingdom")
UK_freq <- as.data.frame(table(UK_titles$release_year))

Japan_titles <- subset(filt_data, country == "Japan")
Japan_freq <- as.data.frame(table(Japan_titles$release_year))

SK_titles <- subset(filt_data, country == "South Korea")
SK_freq <- as.data.frame(table(SK_titles$release_year))


# Plot processed data
ggplot() +
  geom_line(data = US_freq, aes(x = Var1, y = Freq, group = 1, color = 'red')) +
  geom_line(data = India_freq, aes(x = Var1, y = Freq, group = 1, color = 'green')) +
  geom_line(data = UK_freq, aes(x = Var1, y = Freq, group = 1, color = 'blue')) +
  geom_line(data = Japan_freq, aes(x = Var1, y = Freq, group = 1, color = 'magenta')) +
  geom_line(data = SK_freq, aes(x = Var1, y = Freq, group = 1, color = 'cyan')) +
  labs(title = "Number of titles released each year by each country as available on Netflix",
       subtitle = "Since the year 2000, by top 5 countries with most releases") +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_color_manual(name = "Country", labels = c("UK", "South Korea", "India", "Japan", "United States"), values = c("blue", "cyan", "green", "magenta", "red"))

ggsave(here("Netflix","output","titles_by_country.jpg"),#save plot
       width = 7, height = 5) #set aspect ratio