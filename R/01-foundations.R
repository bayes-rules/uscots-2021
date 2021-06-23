
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
# A movie that satisfies these criteria is said
# to have passed the Bechdel Test
#--------------------------------------------------#


# ~Question~: what percentage of all recent movies 
# do you think pass the Bechdel test?


# ~Question~: If you were to make a distribution
# for the proportion (pi) that would pass the
# Bechdel test what would it look like? 
# 
# - Where would it be centered (approximately)?
# - Would it be symmetric or skewed?
# - How sure are you about pi?


# ~Exercise with R~:
# Modify the parameters in the plot_beta()
# function below to produce a plot of 
# your prior distribution for pi: the proportion
# of recent movies that pass the Bechdel test
#
# Note: this may take some playing around
# before you land on a plot that is close
# to your prior understanding of pi. 
# It is OK (and encouraged!) to experiment and 
# try multiple values for the parameters!

library(bayesrules)
plot_beta(2,2) 


# ~Exercise with R~:
# You just collected some data on 20 recent 
# movies. It turns out that 9 of the 20 movies
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
# prior and that 9 out of 20 movies 
# passed the Bechdel test.

summarize_beta_binomial(2,2,0,2)


# ~Exercise with R~: Influence of the prior.
#
# Modify the code below to reflect our data
# Keeping our data the same (9 out of 20)
# but trying out different priors. 
#
# How does your prior distribution impact
# The posterior distribution?

plot_beta_binomial(2,2,0,2)
summarize_beta_binomial(2,2,0,2)
