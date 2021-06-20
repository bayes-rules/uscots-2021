# Loading packages --------------------------------------------------------

library(bayesrules)
library(rstanarm)
library(bayesplot)
library(tidyverse)
library(tidybayes)
library(devtools)

#### installing bayesrules package

# install_github("bayes-rules/bayesrules")


# Data Wrangling ----------------------------------------------------------


data(weather_WU)

weather_WU %>% 
  group_by(location) %>% 
  tally()



# Modeling ----------------------------------------------------------------


weather_model_1 <- stan_glm(temp3pm ~ temp9am, 
                            data = weather_WU, family = gaussian,
                            prior_intercept = normal(25, 5),
                            prior = normal(0, 2.5, autoscale = TRUE), 
                            prior_aux = exponential(1, autoscale = TRUE),
                            chains = 4, iter = 5000*2, seed = 84735)


# MCMC diagnostics

mcmc_trace(weather_model_1, size = 0.1)

