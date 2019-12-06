# Reflection

## Feedback

In the third week, we were able to incorporate the following suggestions in our app:
- Changed the definition of Education Mobility Index (EMI) to make it concise and impactful
- Instructions to effectively interact with the world map and bar plot were added
- Changed the title of the line plots to make them more meaningful
- Highlighted the title "Region / Country / Economy Comparisons"
- Formatted the titles, axis, legend(s) etc. for all plots
- Adjusted the alignment and proportions of the world map and the bar plot

We also updated our Code of conduct to include a section on 'Expected Behaviour'.

Following suggestion(s) were not incorporated in milestone 3 due to time constraints:
- Countries with `NaN` values do not show up on the plot (spent a ridiculous amount of hours trying to troubleshoot this to no avail)
- Add zoom in functionality in the world map, as small countries are hard to see on the map
     - This functionality does not exist in Altair [link_to_open_issue](https://github.com/altair-viz/altair/issues/632)
     - Though regular zoom in facilitated by all brower(s) should be an acceptable workaround for the purpose of this lab
     - Faceting by continent is also a feasible workaround and infact potentially be more insightful when compared to the whole world
- Ability to filter the bar chart to say, top 10 countries or specific countries selected

Following suggestions were not implemented as per group consensus:
- Change colourscheme of the world map
- Add a line that mentions that missing data is not incroporated in the plots

## App Critique

### What it does well

We think our app is clean and concise without a lot of superfluous information. The interactive features have all been designed with specific purposes in mind, and not just for the sake of it. 

### Limitations

Some limitations of our app include:
 - it only includes information on education mobility
 - countries with `NaN` values do not show up on the plot
 - small countries are hard to see on the map

### Future Improvements and Additions

Potential additions / improvements include:
 - adding more data on overall income mobility and indicators of mobility to be able to dig into deeper research questions
 - instead of the world map, facet by continent(s)
 - adding a selection filter to the bar chart to be able to filter the number of countries shown (i.e. top 20, bottom 10, etc)

## Reflection on the usefullness of the feedback
Overall the feedback activity conducted during lab 3 session was a productive exercise. It had a positive and constructive impact on our work. We were able to prioritize the suugestions based on their frequency among the reviewers. "fly on the wall" activity in particular stood out, as it enabled us to identify the obvious flaws in our app.