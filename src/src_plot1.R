#load packages
options(tidyverse.quiet = TRUE,
        repr.plot.width = 12,
        repr.plot.height = 5)
library("tidyverse")
library("ggridges") 
library("plotly")

#read in csv
df_movies <- read_csv("../data/movies_data_clean.csv")

plot_1_func <- function(type="boxplot", metric="boxoffice", report="gross"){
  if(type=="boxplot" & metric=="boxoffice" & report=="gross"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_gross = worldwide_gross/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=worldwide_gross, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("WorldWide Gross Box-Office VS. Year")+
      xlab("Year")+
      ylab("WorldWide Gross Box-Office in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_gross:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="boxplot" & metric=="boxoffice" & report=="adj"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_adj = worldwide_adj/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=worldwide_adj, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("Adjusted For Inflation WorldWide Box-Office VS. Year")+
      xlab("Year")+
      ylab("Adjusted For Inflation WorldWide Box-Office in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_adj:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="boxplot" & metric=="profit" & report=="gross"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_profit_gross = worldwide_profit_gross/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=worldwide_profit_gross, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("Gross Worldwide Profit VS. Year")+
      xlab("Year")+
      ylab("Gross Worldwide Profit in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_profit_gross:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="boxplot" & metric=="profit" & report=="adj"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_profit_adj = worldwide_profit_adj/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=worldwide_profit_adj, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("Adjusted For Inflation Worldwide Profit VS. Year")+
      xlab("Year")+
      ylab("Adjusted For Inflation Worldwide Profit in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_profit_adj:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="boxplot" & metric=="bits"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_bits = worldwide_bits/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=worldwide_bits, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("Butts in Seats (bits) VS. Year")+
      xlab("Year")+
      ylab("Bits per Million People")+
      #scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_bits:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="boxplot" & metric=="budget" & report=="gross"){
    plot_for_ibeam <- df_movies %>% 
      mutate(production_budget = production_budget/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=production_budget, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("Gross Production Budget VS. Year")+
      xlab("Year")+
      ylab("Gross Production Budget in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{production_budget:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="boxplot" & metric=="budget" & report=="adj"){
    plot_for_ibeam <- df_movies %>% 
      mutate(production_budget_adj = production_budget_adj/1000000) %>% 
      mutate(year = as.factor(year)) %>% 
      group_by(year) %>%
      ggplot(aes(x=year, y=production_budget_adj, color=year, text = paste("title: ",title)))+
      #geom_boxplot(outlier.shape = NA)+
      geom_jitter(alpha=.5, size =.3)+
      ggtitle("Adjusted For Inflation Production Budget VS. Year")+
      xlab("Year")+
      ylab("Adjusted For Inflation Production Budget in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
            legend.position = "none")
    plot_for_ibeam <- ggplotly(plot_for_ibeam) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{production_budget_adj:.2f}',
                              '<b>%{text}</b>')
      )
    plot_for_ibeam
  }
  else if(type=="line" & metric=="boxoffice" & report=="gross"){
    plot_for_ibeam <- df_movies %>% 
    mutate(worldwide_gross = worldwide_gross/1000000) %>% 
    group_by(year) %>%
    mutate(median_metric = median(worldwide_gross)) %>% 
    ggplot(aes(x=year, y=median_metric))+
    geom_line()+
    geom_point()+
    ggtitle("Median WorldWide Gross Box-Office")+
    xlab("Year")+
    ylab("Median WorldWide Gross Box-Office in Millions ($)")+
    scale_y_continuous(labels = dollar)+
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else if(type=="line" & metric=="boxoffice" & report=="adj"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_adj = worldwide_adj/1000000) %>% 
      group_by(year) %>%
      mutate(median_metric = median(worldwide_adj)) %>% 
      ggplot(aes(x=year, y=median_metric))+
      geom_line()+
      geom_point()+
      ggtitle("Adjusted For Inflation Median WorldWide Box-Office")+
      xlab("Year")+
      ylab("Adjusted For Inflation Median WorldWide Profit in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else if(type=="line" & metric=="profit" & report=="gross"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_profit_gross = worldwide_profit_gross/1000000) %>% 
      group_by(year) %>%
      mutate(median_metric = median(worldwide_profit_gross)) %>% 
      ggplot(aes(x=year, y=median_metric))+
      geom_line()+
      geom_point()+
      ggtitle("Median WorldWide Gross Profit")+
      xlab("Year")+
      ylab("Median WorldWide Gross Profit in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else if(type=="line" & metric=="profit" & report=="adj"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_profit_adj = worldwide_profit_adj/1000000) %>% 
      group_by(year) %>%
      mutate(median_metric = median(worldwide_profit_adj)) %>% 
      ggplot(aes(x=year, y=median_metric))+
      geom_line()+
      geom_point()+
      ggtitle("Adjusted For Inflation Median WorldWide Profit")+
      xlab("Year")+
      ylab("Adjusted For Inflation Median WorldWide Proft in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else if(type=="line" & metric=="bits"){
    plot_for_ibeam <- df_movies %>% 
      mutate(worldwide_bits = worldwide_bits/1000000) %>% 
      group_by(year) %>%
      mutate(median_metric = median(worldwide_bits)) %>% 
      ggplot(aes(x=year, y=median_metric))+
      geom_line()+
      geom_point()+
      ggtitle("Median WorldWide Butts In Seats (BITS)")+
      xlab("Year")+
      ylab("Median WorldWide BITS Per Million People")+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else if(type=="line" & metric=="budget" & report=="gross"){
    plot_for_ibeam <- df_movies %>% 
      mutate(production_budget = production_budget/1000000) %>% 
      group_by(year) %>%
      mutate(median_metric = median(production_budget)) %>% 
      ggplot(aes(x=year, y=median_metric))+
      geom_line()+
      geom_point()+
      ggtitle("Median WorldWide Gross Production Budget")+
      xlab("Year")+
      ylab("Median WorldWide Gross Production Budget in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else if(type=="line" & metric=="budget" & report=="adj"){
    plot_for_ibeam <- df_movies %>% 
      mutate(production_budget_adj = production_budget_adj/1000000) %>% 
      group_by(year) %>%
      mutate(median_metric = median(production_budget_adj)) %>% 
      ggplot(aes(x=year, y=median_metric))+
      geom_line()+
      geom_point()+
      ggtitle("Adjusted For Inflation Median WorldWide Production Budget")+
      xlab("Year")+
      ylab("Adjusted For Inflation Median WorldWide Production Budget in Millions ($)")+
      scale_y_continuous(labels = dollar)+
      theme(panel.border = element_blank(), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
    plot_for_ibeam <- ggplotly(plot_for_ibeam) 
    plot_for_ibeam
  }
  else{
    print("fail")
  }
}

plot_1_func(type="boxplot", metric="bits", report="adj")
