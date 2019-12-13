# Reflection

For week4, we chose to work with the `movie` dataset from vega_datasets, instead of translating our python dash app to R.

### App Critique

### What it does well

We think our app is clean and concise without a lot of superfluous information. The interactive features have all been designed with specific purposes in mind, and not just for the sake of it. We have considered the impact of inflation which provides the user the flexibility to visualise both gross and inflated revenue numbers over years. We re-introduced a historic metric, "Butts in seats", as in our opinion, it's a relevant metric in the context of revenue patterns.

### Limitations

Some limitations of our app include:

 - it only includes movies from 1980 to 2010
 - columns with `NA` values were dropped
 - movies with production budget in the bottom 5% were dropped
      - this includes small independent films
      
Limitations due to time constraint(s):

 - remove default plotly hover tool over all plot(s)
 - use CSS to correct the colour of the `year slider`

### Future Improvements and Additions

Potential additions / improvements include:

 - add more data from outside resource(s)
 - separate the data into small and big production(s)
 - include CSS formatting for overall better layout