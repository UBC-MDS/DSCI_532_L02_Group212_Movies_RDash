library("tidyverse")
library("cowplot")
library("gapminder")
library("ggridges") 
library("scales")
library("janitor")

df_movies_raw <- read_csv("../data/movies_clean_data_python.csv")
df_tix_price <- read_csv("../data/movie_ticket_prices.csv")
df_inf <-read_csv("../data/inflation_data_1980_to_2010.csv")

#drop index and clean column names 
df_movies_raw <- df_movies_raw %>%
  select(-X1) %>% 
  clean_names() %>% 
  rename(year = release_year) 

#change the column types for tix price 
df_tix_price$year <- as.numeric(df_tix_price$year)
df_tix_price$price <- str_remove(df_tix_price$price, "[$]")
df_tix_price$price <- as.numeric(df_tix_price$price)


#join the three tables together
df_movies_raw <- left_join(df_movies_raw, df_tix_price, by = "year")
df_movies_raw <- left_join(df_movies_raw, df_inf, by ="year")

#check if all the movie titles are unique or if an additional col of 
#movie & title needs be added.

unique(length(df_movies_raw$title))
length(df_movies_raw$title)

#conclude that all titles in this data set are unique, no addiontal wrangling

#make an profit column, world and us. Box offit - production budget
df_movies_raw <- df_movies_raw %>% 
  mutate(us_profit_gross = us_gross - production_budget, 
         worldwide_profit_gross = worldwide_gross - production_budget)

#butts in seats (bits) us and world.  Boxoffice/price per ticket 
df_movies_raw <- df_movies_raw %>% 
  mutate(us_bits = us_gross/price, 
         worldwide_bits = worldwide_gross/price)

#adjust for inflation budget, boxoffice and profit. adj = gross/inflation  
df_movies_raw <- df_movies_raw %>% 
  mutate(us_adj = us_gross/amount,
         us_profit_adj = us_profit_gross/amount, 
         production_budget_adj = production_budget/amount,
         worldwide_adj = worldwide_gross/amount, 
         worldwide_profit_adj = worldwide_profit_gross/amount)

#reorder the data frame and drop some non essental info
df_movies_raw <- df_movies_raw %>% 
  select(title, year, distributor,
         us_gross, us_profit_gross, us_adj, us_profit_adj, us_bits,
         worldwide_gross, worldwide_profit_gross, worldwide_adj, worldwide_profit_adj, worldwide_bits,        
         production_budget, production_budget_adj)
  
df_movies_clean <- df_movies_raw

write_csv(df_movies_clean, "../data/movies_data_clean.csv")
  
