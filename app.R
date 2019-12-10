# Adding full interactivity

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
library(tidyverse)
library(plotly)
library(gapminder)
options(tidyverse.quiet = TRUE,
        repr.plot.width = 12,
        repr.plot.height = 5)
library(ggridges)
library(scales)


app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

# Selection components

#read in movies df
df_movies <- read_csv("data/movies_data_clean.csv") %>% 
  mutate(worldwide_gross = worldwide_gross/1000000) %>% 
  mutate(worldwide_adj = worldwide_adj/1000000) %>% 
  mutate(worldwide_profit_gross = worldwide_profit_gross/1000000) %>% 
  mutate(worldwide_profit_adj = worldwide_profit_adj/1000000) %>% 
  mutate(worldwide_bits = worldwide_bits/1000000) %>% 
  mutate(production_budget = production_budget/1000000) %>% 
  mutate(production_budget_adj = production_budget_adj/1000000)
  
#We can get the years from the dataset to make ticks on the slider
yearMarks <- lapply(unique(df_movies$year), as.character)
names(yearMarks) <- unique(df_movies$year)
yearSlider <- dccRangeSlider(
  id="year",
  marks = yearMarks,
  min = 1980,
  max = 2010,
  step=5,
  value = list(1980, 2010)
)



# Storing the labels/values as a tibble means we can use this both 
# to create the dropdown and convert colnames -> labels when plotting
yaxisKey <- tibble(label = c("Box Office", "Profit", "Butts in Seats"),
                   value = c("worldwide_gross", "worldwide_profit_gross", "worldwide_bits"))


yaxisDropdown <- dccDropdown(
  id = "y-axis",
  options = lapply(
    1:nrow(yaxisKey), function(i){
      list(label=yaxisKey$label[i], value=yaxisKey$value[i])
    }),
  value = "worldwide_gross"
)

inflation_adj <- dccRadioItems(
  id='inf-type',
  options=list(
    list('label'='Gross', 'value'='gross'),
    list('label'='Adjusted for inflation', 'value'='adj')
    ),
  value='adj',
  labelStyle=list(
    "display"= "inline-block",
    "padding"= "12px 12px 12px 0px"
    )
)

chart_type <- dccRadioItems(
  id='chart-type',
  options=list(
    list('label'='Jitter', 'value'='jitter'),
    list('label'='Line (Median)', 'value'='line')
  ),
  value='jitter',
  labelStyle=list(
    "display"= "inline-block",
    "padding"= "12px 12px 12px 0px"
  )
)

# Use a function make_graph() to create the graph

# Uses default parameters such as all_continents for initial graph
make_graph <- function(years=c(1980, 2010), 
                       yaxis="worldwide_gross", inf="adj", type="jitter"){
  
  # gets the label matching the column value
  if(inf=="adj"){
    yaxisKey <- tibble(label = c("Box Office", "Profit", "Butts in Seats"),
                       value = c("worldwide_adj", "worldwide_profit_adj", "worldwide_bits"))
    title_end = " - Adjusted for inflation"
  }
  else{
    yaxisKey <- tibble(label = c("Box Office", "Profit", "Butts in Seats"),
                       value = c("worldwide_gross", "worldwide_profit_gross", "worldwide_bits"))
    title_end = " - Not Adjusted for inflation"
  }
    
  # if inflation selected, use adjusted values
  if(inf=="adj"){
    if(yaxis =="worldwide_gross"){
      yaxis_to_plot = "worldwide_adj"
    }
    else if(yaxis == "worldwide_profit_gross"){
      yaxis_to_plot = "worldwide_profit_adj"
    }
    else if(yaxis=="worldwide_bits"){
      yaxis_to_plot = "worldwide_bits"
    }
  }
  else yaxis_to_plot = yaxis
  
  y_label <- yaxisKey$label[yaxisKey$value==yaxis_to_plot]
  
  #filter our data based on the year/continent selections
  data <- df_movies %>%
    filter(year >= years[1] & year <= years[2])
  
  

  
  # reference for converting yaxis string to col reference (quosure) by `!!sym()`
  # see: https://github.com/r-lib/rlang/issues/116
  # originally from Kate S's example
  p1 <- ggplot(data, aes(x=year, y=!!sym(yaxis_to_plot), colour=year)) +
    geom_jitter(alpha=.5, size =.3) +
    scale_x_continuous(breaks = unique(data$year))+
    scale_y_continuous(labels = comma)+
    xlab("Year") +
    ylab(paste0("Worldwide ", y_label, " (Millions)")) +
    geom_line(aes(x=year, y=median(!!sym(yaxis_to_plot)))) +
    ggtitle(paste0("Change in ", y_label, " Over Time", title_end)) +
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
          legend.position = "none")
  
  
  p2 <- data %>% 
    group_by(year) %>%
    mutate(median_metric = median(!!sym(yaxis_to_plot))) %>% 
    ggplot(aes(x=year, y=median_metric))+
    geom_line()+
    scale_x_continuous(breaks = unique(data$year))+
    scale_y_continuous(labels = comma)+
    geom_point()+
    ggtitle(paste0("Change in ", y_label, " Over Time", title_end))+
    xlab("Year")+
    ylab(paste0("Worldwide ", y_label, " (Millions)"))+
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  
  if(type == "jitter"){
    ggplotly(p1) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_gross:.2f}',
                              '<b>%{text}</b>')
      )
  }
  else{
    ggplotly(p2) %>% 
      add_trace(
        hovertemplate = paste('<i>US Boxoffice</i>: $%{worldwide_gross:.2f}',
                              '<b>%{text}</b>')
      )
  }
  
}

# Now we define the graph as a dash component using generated figure
graph <- dccGraph(
  id = 'gap-graph',
  figure=make_graph() # gets initial data using argument defaults
)



app$layout(
  htmlDiv(
    list(
      htmlH1('M is for Movies'),
      htmlH2('Comparing success metrics'),
      #selection components
      #htmlLabel('Select a year range:'),
      htmlLabel('Select y-axis metric:'),
      yaxisDropdown,
      inflation_adj,
      chart_type,
   
      
      #graph 
      graph, 
      htmlIframe(height=20, width=10, style=list(borderWidth = 0)), #space
      htmlLabel('Select a year range:'),
      yearSlider,
      htmlIframe(height=15, width=10, style=list(borderWidth = 0)), #space

      dccMarkdown("[Data Source]()")
    )
  )
)

# Adding callbacks for interactivity
# We need separate callbacks to update graph and table
# BUT can use multiple inputs for each!
app$callback(
  #update figure of gap-graph
  output=list(id='gap-graph', property='figure'),
  #based on values of year, continent, y-axis components
  params=list(input(id='year', property='value'),
              input(id='y-axis', property='value'),
              input(id='inf-type', property='value'),
              input(id='chart-type', property='value')),
  #this translates your list of params into function arguments
  function(year_value, yaxis_value, inf_type, chart_selection) {
    make_graph(year_value, yaxis_value, inf_type, chart_selection)
  })


app$run_server()