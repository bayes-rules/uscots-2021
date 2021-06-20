# Installing Packages -----------------------------------------------------

install.packages("tidyverse")
install.packages("rstan")
install.packages("rstanarm")
install.packages("devtools")
install.packages("bayesplot")
install.packages("tidybayes")
devtools::install_github("mdogucu/bayesrules")


# Checking installations --------------------------------------------------

# Load some packages
library(bayesrules)
library(rstanarm)
library(bayesplot)
library(tidyverse)
library(tidybayes)

# Load the data
data(weather_WU)
weather_WU %>% 
  group_by(location) %>% 
  tally()

# Model
weather_model_1 <- stan_glm(temp3pm ~ temp9am, 
                            data = weather_WU, family = gaussian,
                            prior_intercept = normal(25, 5),
                            prior = normal(0, 2.5, autoscale = TRUE), 
                            prior_aux = exponential(1, autoscale = TRUE),
                            chains = 4, iter = 5000*2, seed = 84735)


# MCMC diagnostics
mcmc_trace(weather_model_1, size = 0.1)

