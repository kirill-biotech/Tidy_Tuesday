# Load libraries
library(tidyverse)
library(here)

# Load and clean data
main_df <- read_csv(here("Superbowl", "data", "youtube.csv")) %>% # load from file
  select(5:11, 16:17) %>% # select only the columns needed
  na.omit() # delete rows with NA


# Process data
# Calculate "like score" for each ad, likes minus dislikes
main_df$like_score <- with(main_df, like_count - dislike_count) # add column like_score and put the calculated value into it for each row

# Calculate how many criteria each ad meets
main_df$criteria <- rowSums(main_df == TRUE)

#view(main_df)

# Make dataframes for ads that meet each number of criteria from 1 to 6
crit_1 <- main_df %>%
  subset(criteria == 1)

crit_2 <- main_df %>%
  subset(criteria == 2)

crit_3 <- main_df %>%
  subset(criteria == 3)

crit_4 <- main_df %>%
  subset(criteria == 4)

crit_5 <- main_df %>%
  subset(criteria == 5)

crit_6 <- main_df %>%
  subset(criteria == 6)

ggplot() +
  geom_violin(width = 0.5, data = crit_1, aes(x = 1, y = like_score)) +
  geom_violin(width = 0.5, data = crit_2, aes(x = 2, y = like_score)) +
  geom_violin(width = 0.5, data = crit_3, aes(x = 3, y = like_score)) +
  geom_violin(width = 0.5, data = crit_4, aes(x = 4, y = like_score)) +
  geom_violin(width = 0.5, data = crit_5, aes(x = 5, y = like_score)) +
  geom_violin(width = 0.5, data = crit_6, aes(x = 6, y = like_score)) +
  scale_y_continuous(trans='log2') +
  scale_x_discrete(name = "Number of criteria met")

ggsave(here("Superbowl","output","ads_criteria_and_likes.jpg"),#save plot
       width = 7, height = 5) #set aspect ratio