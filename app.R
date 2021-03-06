##########################
# Loading libraries
#########################

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
library(tidyverse)
library(plotly)
library(gapminder)
options(tidyverse.quiet = TRUE,
        repr.plot.width = 6,
        repr.plot.height = 5)

library(ggridges) 
library('scales')
library(ggplot2)


app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

#read in movies df
df_movies <- read_csv("data/movies_data_clean.csv") %>% 
  mutate(worldwide_gross = worldwide_gross/1000000) %>% 
  mutate(worldwide_adj = worldwide_adj/1000000) %>% 
  mutate(worldwide_profit_gross = worldwide_profit_gross/1000000) %>% 
  mutate(worldwide_profit_adj = worldwide_profit_adj/1000000) %>% 
  mutate(worldwide_bits = worldwide_bits/1000000) %>% 
  mutate(production_budget = production_budget/1000000) %>% 
  mutate(production_budget_adj = production_budget_adj/1000000)

##################################################################
# Selection components
##################################################################

#Making a slider following the DSCI 532 participation example
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

# Select metric to show on y-axis
yaxisDropdown <- dccDropdown(
  id = "y-axis",
  options = lapply(
    1:nrow(yaxisKey), function(i){
      list(label=yaxisKey$label[i], value=yaxisKey$value[i])
    }),
  value = "worldwide_gross"
)

# Select whether to include inflation
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

# Select line or jitter plot
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

# Select which movies to compare
moviesDropdown <- dccDropdown(
  id = "movies-dd",
  # Credit to Kate S and teh participation app4.R example for the code below
  # map/lapply can be used as a shortcut instead of writing the whole list
  # especially useful if you wanted to filter by country!
  options = map(
    df_movies$title, function(x){
      list(label=x, value=x)
    }),
  value = c("Jurassic Park", "The Lion King","Gladiator", "Die Hard 2", "The Aviator"), #I picked these movies as default
  multi = TRUE
)


##############################################################################
# JITTER / LINE GRAPH FUNCTION
##############################################################################

# Uses default parameters such as all_continents for initial graph
make_graph_1 <- function(years=c(1980, 2010), 
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
  
  #jitter plot
  p1 <- ggplot(data, aes(x=year, y=!!sym(yaxis_to_plot), colour=year, 
                         text = paste('</br> Movie: ', title,
                                      '</br> Year: ', year,
                                      '</br> Distributor: ', distributor,
                                      '</br>', y_label,"(M): ", round(!!sym(yaxis_to_plot), 1)))) +
    geom_jitter(alpha=.5, size =0.7, color= "#ff8000") +
    scale_x_continuous(breaks = unique(data$year))+
    scale_y_continuous(labels = comma, trans='log10') +
    xlab("Year") +
    ylab(paste0("Worldwide ", y_label, " (Millions) - log(10) scale")) +
    geom_line(aes(x=year, y=median(!!sym(yaxis_to_plot)))) +
    ggtitle(paste0("Change in ", y_label, " Over Time", title_end)) +
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.background = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
          legend.position = "none", axis.text.x = element_text(angle = 45,color='#0d0d0d'), plot.title = element_text(hjust = 0.5, size=18),axis.title.x = element_blank(),axis.text.y = element_text(color='#0d0d0d'))
  
  #line and point chart
  p2 <- data %>% 
    group_by(year) %>%
    mutate(median_metric = median(!!sym(yaxis_to_plot))) %>% 
    ggplot(aes(x=year, y=median_metric, group=1, text = paste('</br> Year: ', year,
                                                              '</br>Average ', y_label,"(M): ", round(median_metric, 1)))) +
    scale_x_continuous(breaks = unique(data$year))+
    geom_line(colour = "#cc6600") +
    scale_y_continuous(labels = comma)+
    geom_point()+
    ggtitle(paste0("Change in ", y_label, " Over Time", title_end))+
    xlab("Year")+
    ylab(paste0("Worldwide ", y_label, " (Millions)"))+
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.background = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
          axis.text.x = element_text(angle = 45,color='#0d0d0d'), plot.title = element_text(hjust = 0.5, size=18),
          axis.title.x = element_blank(),axis.text.y = element_text(color='#0d0d0d'))
  
  if(type == "jitter"){
    ggplotly(p1, tooltip = "text") %>% config(displayModeBar = FALSE)
  }
  else{
    ggplotly(p2, tooltip = "text") %>% config(displayModeBar = FALSE)
  }
}

##############################################################################
# END JITTER / LINE GRAPH FUNCTION
##############################################################################


#######################################################################
# START BAR PLOT
#######################################################################

#bar plot
make_graph_2 <- function(years=c(1980, 2010), 
                         yaxis="worldwide_gross", inf="adj"){
  
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
    filter(year >= years[1] & year <= years[2]) %>% 
    arrange(desc(!!sym(yaxis_to_plot))) %>%
    slice(1:10)
  
  p3 <- ggplot(data, aes(x=reorder(title, !!sym(yaxis_to_plot)), y=!!sym(yaxis_to_plot),  
                         text = paste('</br> Movie: ', title,
                                      '</br> Year: ', year,
                                      '</br> Distributor: ', distributor,
                                      '</br>', y_label,"(M): ", round(!!sym(yaxis_to_plot), 1)))) +
    geom_bar(stat = 'identity',fill = "#ffcc99") +
    #scale_x_continuous(breaks = unique(data$year))+
    scale_y_continuous(labels = comma) +
    xlab("") +
    ylab(paste0("Worldwide ", y_label, " (Millions)")) +
    coord_flip()+
    ggtitle(paste0("Top 10 Movies")) +
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.background = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
          legend.position = "none",plot.title = element_text(hjust = 0.5, size=15),
          axis.text.x=element_text(size=12,color="#000000"),axis.text.y = element_text(color='#0d0d0d'))
  ggplotly(p3, tooltip = "text") %>% config(displayModeBar = FALSE)
}

#######################################################################
#END BAR PLOT
#######################################################################

######################################################################
# START COMPARISON PLOT
######################################################################

#bar plot
make_graph_3 <- function(yaxis="worldwide_gross", inf="adj",
                         movies_sel=c("Alice in Wonderland", "Despicable Me", "Easy A")){
  
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
    #filter(year >= years[1] & year <= years[2]) %>% 
    filter(title %in% movies_sel) 
  
  p4 <- ggplot(data, aes(x=reorder(title, !!sym(yaxis_to_plot)), y=!!sym(yaxis_to_plot),  
                         text = paste('</br> Movie: ', title,
                                      '</br> Year: ', year,
                                      '</br> Distributor: ', distributor,
                                      '</br>', y_label,"(M): ", round(!!sym(yaxis_to_plot), 1)))) +
    geom_bar(stat = 'identity', position="dodge",fill = "#ffcc99") +
    #scale_x_continuous(breaks = unique(data$year))+
    scale_y_continuous(labels = comma) +
    xlab("") +
    ylab(paste0("Worldwide ", y_label, " (Millions)")) +
    coord_flip() +
    ggtitle(paste0("Comparing Movies")) +
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.background = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
          legend.position = "none", plot.title = element_text(hjust = 0.5, size=15),
          axis.text.x=element_text(size=12,color="#000000"),axis.text.y = element_text(color='#0d0d0d'))
  ggplotly(p4, tooltip = "text") %>% config(p4, displayModeBar = FALSE)
}

######################################################################
# END COMPARISON PLOT
######################################################################

# Now we define the graph as a dash component using generated figure
graph <- dccGraph(
  id = 'gap-graph',
  figure=make_graph_1() # gets initial data using argument defaults
)

graph2 <- dccGraph(
  id = 'bar-graph',
  figure=make_graph_2() # gets initial data using argument defaults
)

graph3 <- dccGraph(
  id = 'comp-graph',
  figure=make_graph_3() # gets initial data using argument defaults
)



##########################################################################
# START LAYOUT
##########################################################################

app$layout(
  htmlDiv(
    list(
      htmlDiv(
        list(
          htmlH3("Group 212"),
          htmlH2("M is for Movies!")
          #htmlH4("Smaller Text")
        ), style = list('columnCount'=2, 'background-color'= '#669999','padding'= '15px 10px')
      ),
      
      htmlDiv(
        list(
          htmlDiv(
            list(
              dccMarkdown("**Select a a y-axis metric from the dropdown:**"),
              yaxisDropdown,
              dccMarkdown("**Select whether to adjust for inflation  ( 2019 USD):**"),
              inflation_adj,
              dccMarkdown("**Select main chart type:**"),
              chart_type,
              dccMarkdown("This application depicts the profit made by movies from 1980 to 2010."),
              dccMarkdown("An unconventional metric **_Butts in Seats_** is introduced. It indicates the estimated attendance of a movie.")
            ), style = list('background-color'='#94b8b8', 'columnCount'=1, 'width'='20%','padding'= '10px')
          ),
          htmlDiv(
            list(
              #htmlP("Main Plot"),
              graph,
              yearSlider
            ), style=list('columnCount'=1, 'width'='75%','padding'= '25px')
          )
        ), style = list('display'='flex')#, style = list('width'="30%", 'background-color'='lightgrey')
      ),
      
      htmlDiv(
        list(
          htmlDiv(
            list(
              dccMarkdown("**Select movies to compare:**"),
              moviesDropdown
            ), style = list('background-color'='#94b8b8', 'columnCount'=1, 'width'='20%','padding'= '10px')
          ),
          htmlDiv(
            list(
              graph3,
              graph2
            ), style=list('columnCount'=2, 'width'='75%')
          )
        ), style = list('display'='flex')#, style = list('width'="20%", 'background-color'='lightgrey')
      ),
      dccMarkdown("Data is from the vega dataset 'Movies'"),
      dccMarkdown("[Source](https://raw.githubusercontent.com/vega/vega-datasets/master/data/movies.json)")
      
    )
  )
)

###########################################################################
# END LAYOUT
###########################################################################


###########################################################################
# START CALLBACKS
############################################################################

# Callback for graph / line chart
app$callback(
  #update figure of gap-graph
  output=list(id='gap-graph', property='figure'),
  params=list(input(id='year', property='value'),
              input(id='y-axis', property='value'),
              input(id='inf-type', property='value'),
              input(id='chart-type', property='value')),
  #this translates your list of params into function arguments
  function(year_value, yaxis_value, inf_type, chart_selection) {
    make_graph_1(year_value, yaxis_value, inf_type, chart_selection)
  })

# Callback for bar chart
app$callback(
  #update figure of bar-graph
  output=list(id='bar-graph', property='figure'),
  params=list(input(id='year', property='value'),
              input(id='y-axis', property='value'),
              input(id='inf-type', property='value')),
  #this translates your list of params into function arguments
  function(year_value, yaxis_value, inf_type) {
    make_graph_2(year_value, yaxis_value, inf_type)
  })

# Callback for comparison bar chart
app$callback(
  #update figure of comp-graph
  output=list(id='comp-graph', property='figure'),
  params=list(input(id='y-axis', property='value'),
              input(id='inf-type', property='value'),
              input(id='movies-dd', property='value')),
  #this translates your list of params into function arguments
  function(yaxis_value, inf_type, movies_dd) {
    make_graph_3(yaxis_value, inf_type, movies_dd)
  })

#####################################################################
# END CALLBACKS
#####################################################################


app$run_server()