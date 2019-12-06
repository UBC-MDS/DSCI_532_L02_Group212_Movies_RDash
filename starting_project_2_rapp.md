## Sketch

![](img/dashboard_schematic_movies.png)

## Plot 1

*Code*
```
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
```

*Plot*

![](img/test_boxplot.png)



>Plot 1 Will show a box plot of each of the year in one of the four metrics of box office/profit/bits/budget reported in gross or adjusted for inflation. However, it only shows gross box-office Hover tip needs to be added because most of the fun is looking at the outlier cases. 

## Plot 2

*Code*

```
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
```

*Plot*

![](img/test_med_line_plot.png)

>Plot 2 Will show the median line of one of the four metrics for movies for each year and reported in gross or adjusted for inflation. However, due to time limitation only the default of gross and box-office has been implemented. 

## Plot 3

*Code*

```
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

```
*Plot*

![](img/test_movie_comp_bar.png)

>Plot 3 Will be a bar chart (potentially swap to another type of chart) that the user can input into search bar above to compare the movies and it will show the metric selected and reporting type from the radio button at the top of the screen above plot 1. A hover tooltip that shows the other metrics should be included to make the analysis tool more robust. The filter list from the search bar functionality is off to a good start and it will not take much more to get it going. 