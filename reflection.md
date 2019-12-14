# Reflection

For week4, we chose to work with the `movie` dataset from vega_datasets, instead of translating our python dash app to R.

### App Critique

### What it does well

We like that our app includes thoughtful metrics outside of the default values that were available in the dataset. For example, we have considered the impact of inflation which provides the user the flexibility to visualise both gross and adjusted-for-inflation values for box office sales and overall profit. We also added a "Butts in seats" which allows users to explore how movie attendance has changed over time (which you might not be able to infer based on other revenue metrics if the average movie ticket price has changed drastically over time). 

### Limitations

Some limitations of our app include:

 - it only includes movies from 1980 to 2010
 - columns with `NA` values were dropped
 - movies with production budgets in the bottom 5% were dropped
      - this includes small independent films
      
Limitations due to time constraint(s):

 - we were unable to remove default plotly hover tool over all plot(s) (even after seeking help from TA's and other colleagues)
 - apply CSS formatting to correct the colour of the `year slider`

### Future Improvements and Additions

Potential additions / improvements include:

 - add more data from outside resource(s) to compensate for missing years of data
 - separate the data into small and big production(s)
 - include CSS formatting to improve the overall layout
 - add additional groupings to explore patterns amongst distributors or genres of movies (horror, action, romantic comedies, etc)
 - improve the code (potentially through vectorization) to reduce delays between making a selection and having the plots update