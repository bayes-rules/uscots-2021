
#-------Background Information --------------------#
#
# In Alison Bechdel’s 1985 comic strip The Rule, 
# a character states that they only see a movie 
# if it satisfies the following three rules:
#
# -the movie has to have at least two women in it;
# -these two women talk to each other; and
# -they talk about something besides a man.
#
#--------------------------------------------------#


# ~Question~: what percentage of all recent movies 
# do you think pass the Bechdel test?


# ~Question~: If you were to make a distribution
# for the proportion (pi) that would pass the
# Bechdel test what would it look like?


# ~Exercise with R~:
# Modify the parameters in the plot_beta()
# function below to produce a plot of 
# your prior distribution for pi: the proportion
# of recent movies that pass the Bechdel test

library(bayesrules)
plot_beta(2,2) 


# ~Exercise with R~:
# You just collected some data on 20 recent 
# movies. It turns out that 7 of the 20 movies
# pass the Bechdel test. Run the line of code
# with the question mark to learn about the
# parameters of the plot_beta_binomial()
# function and modify the plot_beta_binomial() 
# function below to plot your
# prior, the likelihood, and the posterior

?plot_beta_binomial()
plot_beta_binomial(2,2,0,2)


# ~Exercise With R~:
# In addition to plotting, we can also
# Describe the prior and 
# posterior with numeric summaries
# using the summarize_beta_binomial()
# function. Modify 
# the summarize_beta_binomial() below
# to incorporate information on your 
# prior and that 7 out of 20 movies 
# passed the Bechdel test.

summarize_beta_binomial(2,2,0,2)
