options(tidyverse.quiet = TRUE,
        repr.plot.width = 12,
        repr.plot.height = 5)
library("tidyverse")
library("cowplot")
library("gapminder")
library("ggridges") 
library("scales")
library("janitor")

#read in csv
df_movies_raw <- read_csv("../data/movies_clean_data_python.csv")

#drop index and clean column names 
df_movies_raw <- df_movies_raw %>%
  select(-X1) %>% 
  clean_names()

usd_box <- "US Gross Box-Office in Millions ($)"
year <- "Year"

#Boxplot test us_gross 
boxplot_test <- df_movies_raw %>% 
  mutate(us_gross = us_gross/1000000) %>% 
  mutate(release_year = as.factor(release_year)) %>% 
  group_by(release_year) %>%
  ggplot( aes(x=release_year, us_gross))+
  geom_boxplot()+
  ggtitle(paste0(usd_box, " VS. ", year))+
  xlab(year)+
  ylab(usd_box)+
  scale_y_continuous(labels = dollar)+
  theme_bw()+ 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

ggsave("../img/test_boxplot.png", plot = boxplot_test, width = 12, height = 5)
  
usd_box_median <- "Median US Gross Box-Office in Millions ($)"
year_median <- "Year"

#line dotplot median boxoffic test us_gross 
median_line_test <- df_movies_raw %>% 
  mutate(us_gross = us_gross/1000000) %>% 
  group_by(release_year) %>%
  mutate(median_metric = median(us_gross)) %>% 
  ggplot(aes(x=release_year, y=median_metric))+
  geom_line()+
  geom_point()+
  ggtitle(paste0(usd_box_median, " VS. ", year))+
  xlab(year)+
  ylab(usd_box_median)+
  scale_y_continuous(labels = dollar)+
  theme_bw()+ 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))


ggsave("../img/test_med_line_plot.png", plot = median_line_test, width = 12, height = 5)

#Compareson Bar Chart

#filter it into a variable based off of the list given in the 
#dropdown select bar
movies = list("Alice in Wonderland", "Despicable Me", "Easy A")

movie_comp_bar <-df_movies_raw %>% 
  mutate(us_gross = us_gross/1000000) %>% 
  filter(title %in% movies) %>% 
  ggplot(aes(x=title,y=us_gross))+
  geom_bar(stat="identity", position="dodge")+
  ggtitle(paste0("Comparison Movie Title(s) for ", usd_box))+
  xlab("Movie Title(s)")+
  ylab(usd_box)+
  scale_y_continuous(labels = dollar)+
  theme_bw()+ 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))


ggsave("../img/test_movie_comp_bar.png", plot = movie_comp_bar, width = 4, height = 4)
