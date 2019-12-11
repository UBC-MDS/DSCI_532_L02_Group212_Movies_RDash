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




plot_3_func <- function(movies= list("Alice in Wonderland", "Despicable Me", "Easy A"), 
                        metric="boxoffice", report="gross"){
  if(metric=="boxoffice" & report=="gross"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(worldwide_gross := worldwide_gross/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=worldwide_gross))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
      xlab("Movie Title(s)")+
      ylab(paste0(firstup(metric), " in Million USD($)"))+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
  else if(metric=="boxoffice" & report=="adj"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(worldwide_adj := worldwide_adj/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=worldwide_adj))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
      xlab("Movie Title(s)")+
      ylab(paste0(firstup(metric), " in Million USD($)"))+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
  else if(metric=="profit" & report=="gross"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(worldwide_profit_gross = worldwide_profit_gross/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=worldwide_profit_gross))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
      xlab("Movie Title(s)")+
      ylab(paste0(firstup(metric), " in Million USD($)"))+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
  else if(metric=="profit" & report=="adj"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(worldwide_profit_adj = worldwide_profit_adj/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=worldwide_profit_gross))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
      xlab("Movie Title(s)")+
      ylab(paste0(firstup(metric), " in Million USD($)"))+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
  else if(metric=="bits"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(worldwide_bits = worldwide_bits/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=worldwide_bits))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for Butts in Seats (BITS)"))+
      xlab("Movie Title(s)")+
      ylab("BITS Per Million People")+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
  else if(metric=="budget" & report=="gross"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(production_budget = production_budget/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=production_budget))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
      xlab("Movie Title(s)")+
      ylab(paste0(firstup(metric), " in Million USD($)"))+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
  else if(metric=="budget" & report=="adj"){
    plot_3_for_ibeam <- df_movies %>% 
      mutate(production_budget_adj = production_budget_adj/1000000) %>% 
      filter(title %in% movies) %>% 
      ggplot(aes(x=title, y=production_budget_adj))+
      geom_bar(stat="identity", position="dodge")+
      ggtitle(paste0("Comparison Movie Title(s) for ", firstup(report), " ",firstup(metric)))+
      xlab("Movie Title(s)")+
      ylab(paste0(firstup(metric), " in Million USD($)"))+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    
    plot_3_for_ibeam <-ggplotly(plot_3_for_ibeam)
    plot_3_for_ibeam
  }
}

plot_3_func(metric = "budget", report = "adj")
