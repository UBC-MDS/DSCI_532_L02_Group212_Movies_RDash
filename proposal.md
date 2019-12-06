## DSCI 532 Group 212 Proposal: Movies Dashboard

### Section 1: Motivation and Purpose

Movie studios will often boast about their high box office numbers, but without a larger picture of the entire industry it can be difficult to gage what these numbers really mean. The success of a film can be determined by looking into outcomes such as profits, butts in seats and box office. These numbers are recorded in databases such as IMDB, but this platform doesn’t allow you to compare films for a more holistic picture of the movie industry and what movies are successful.

### Section 2: Description of the data

The data set we are using is the vega_datasets movie database. The database is made up of entries of box office records collected from publicly available knowledge from Box Office Mojo and they act as the central collection database for movie related information. Data has movies from 1965 to 2010, however dude to the limitation of data collections in the 1960s and 1970s this application will focus on the entries of from 1980 to 2010. 

The movies database is made up as ‘title’ and `release_date` which will be the main keys for our data base. Furthermore, data is made up of features such as `director`, `genre` and `imbd_score`. However because this is a business focused dashboard this app will focus on the `US_Gross`,  `Worldwide_Gross`, and `Production Budge`. We will also be mutating this data to adjust it for inflation, profits, and create new metric that we are going to call the butts in seats (BITS) which will be the estimated attendances of the movies. 

#### Limitations

Originally, the data was a collection of 3201 entries; However, a lot of these columns have NA values in key information and due to time limitation, these columns will have to be dropped. As mentioned above we will be limiting our data to 1980 to 2010 due to the information collection issue of the 1960s and 1970s. To make sure that small independence films do not bring down the median because they will not have the resources the bottom 5% of `production_budgets` and bottom 1% of `US_Gross` will be dropped. This will narrow down our data set from the original 3201 observations to 2664 observations. 

#### Variables

- `release_year` – `release_data` with the month and day dropped
- `title` – The main release title of the movie 
- `US_Gross` – Box office revenue inside the USA and Canada reported in $ USD
- 'Worldwide_Gross` – International box office revenue reported in $ USD 
- `Production_Budget ` – The estimated budget of a movie title reported in $ USD 
- `profit_gross` - `Worldwide_Gross` minus `Production_Budget` reported in $ USD
- `bits_gross` – Butts in Seats an estimated of US and Canada attendance `US_Gross` / `price_per_ticket` 
- `US_adj` – Box office revenue inside the USA and Canada reported in adjusted for inflation $ USD
- `Worldwide_adj` – International box office revenue reported in adjusted for inflation 
$ USD 
- `Production_Budget_adj` – The estimated budget of a movie title reported in adjusted for inflation $ USD
`profit_gross` 
– `Worldwide_adj` minus `Production_adj reported in adjusted for inflation $ USD
- `US_bits_adj` – Butts in Seats an estimated of US and Canada attendance `US_Gross_adj` / `price_per_ticket` 




### Section 3: Research questions and usage scenarios


We are proposing to build a visualization app that depicts the profits of films, broken down by year from 1980-2010 in order to directly compare the success of these films. Through the use of this app, we will be able to see a wide breadth of information that will answer inquiries such as whether movies are becoming more expensive to make, whether they’re making more profit now than in the past, and whether audiences are going to the movies more or less frequently than in previous years. 

The CEO of a small film studio is deciding what the studios next big undertaking will be. Over the last few years, the films the studio has released have not performed very well at all. The studio is at risk of having to shut down if their next film does not do well in box offices. Previously, the CEO has not done much research into what films audiences are flocking to see, but this time she’s decided it’s in her best interest. In order to do this, she would like to gather a better understanding of what films audiences enjoy most by looking into audience numbers and film profits. She first turns to IMDB for their wealth of movie stats but reaches a roadblock when she discovers that there’s no way for her to directly compare films. Through using our app, she will be able to look at the data set on films ranging 30 years and see what movies performed the highest, the lowest and at the average, all depicted on a box plot. If she wants to look more specifically into the films from 2010, she can select this year from a drop-down menu and then select the films from that year she is most interested in gathering information on. In doing this, she will be able to see the numbers of these films side by side in order to directly compare them.
With this information, she will be able to compile a list of films that performed well that year in order to further her research on the type of film she wants to make.

