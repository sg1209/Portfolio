# Soccer Player Analysis

# Project Overview

- The analysis was done using FIFA data found from “Kaggle.com”, which includes literally everything you can find in the video game FIFA - such as overall, age, weight, preferred foot and even things like club logo, real face. EA sports, the company of the game, collects and maintains their statistical database of real world soccer players through operating teams with producers, data contributors and volunteers, which makes the game FIFA able to reflect personal abilities of players nearly same with real world (Murphy, 2019). So, this analysis is trying to figure out what factor influences in order to make a “successful soccer player” which the data “Overall” stands for.

## Key Actions and Techniques

### Data Collection and Preparation:

- Downloaded the FIFA player data from Kaggle to enumerate performace of each players.

### Statistical Analysis:

- Applied statistical tests (ANOVA) to validate the relationships between multiple factors and player overall.


### Model Development:

- Constructed regression models to make the best prediction and performed polynomial variable transformation to increase the accuracy.

### Tools and Technologies
- R: Data analysis and manipulation.

- tidyverse: Data wrangling and aggregation.

- Statistical Testing: Hypothesis testing to validate findings.

- Regression Analysis: Modeling the relationship variables, mostly linear regression.

### Project Outcomes

- Through ANOVA test and comparing absolute error and RMSE, we could figure out the model with drawn variables and polynomial method used on variables with strong coefficients is the best model to predict the response “Overall”. We finalized that Wage, Value, International Reputation, Skill Moves, Height and Weight are important factors to determine the person’s overall physical statistics
