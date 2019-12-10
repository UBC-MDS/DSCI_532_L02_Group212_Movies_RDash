#load packages
options(tidyverse.quiet = TRUE,
        repr.plot.width = 12,
        repr.plot.height = 5)
library("tidyverse")
library("ggridges") 
library("plotly")
library("scales")

#read in csv
df_movies <- read_csv("../data/movies_data_clean.csv")


#Credit to usser sindri_baldur link to stackoverflow https://stackoverflow.com/questions/18509527/first-letter-to-upper-case
firstup <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}
col_name_func <- function(metric="boxoffice", report="gross"){
  if(metric=="boxoffice" & report=="gross"){
    col_name = "worldwide_gross"
  }
  else{
    print("stop")
  }
}

col_name_temp <- col_name_func()
col_name_temp

plot_2_func <- function(metric="boxoffice", report="gross"){
  df_movies %>% 
    filter(worldwide_gross >= quantile(worldwide_gross, .9925)) %>% 
    ggplot(aes(x=reorder(title,worldwide_gross), y=worldwide_gross))+
    geom_bar(stat="identity", position="dodge")+
    coord_flip()+
    ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
    xlab("Movie Title(s)")+
    ylab(paste0(firstup(metric), " in Million USD($)"))+
    scale_y_continuous(labels = dollar)+
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  
  
}


plot_2_func()
