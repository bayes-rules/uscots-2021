library(ggplot2)
library(dplyr)
library(bayesplot)
library(bayesrules)


# set up story (bechdel)

# Plot the "real" posterior.
plot_beta(alpha = , beta = )



# Now let's PRETEND we don't know the posterior.
# Instead, we'll *approximate* this posterior using 3 separate Markov chain samples.
# The book explores how to simulate such samples using rstan and rstanarm.
# But to focus on how to *use* the chain output, we'll import chains that were simulated for us:
chain_1 <- read.csv("")
chain_2 <- read.csv("")
chain_3 <- read.csv("")


# Our eventual goal is to use a Markov chain sample to approximate the posterior model of pi.
# Before doing so, we must perform some *diagnostics*.
# That is, we must check whether our chains seem "trustworthy".
# To begin, we can think of a chain as a *tour* around posterior plausible pi values.
# We want that tour to look as random as possible, for the chain to behave like a random sample.
# *Trace plots* provide a glimpse into the tour, plotting the sampled pi value (y axis)
# in the order we observed them (x axis).
# Compare and contrast the trace plots for the 3 Markov chains. Syntax is provided for chain 1.
mcmc_trace(chain_1)




# Before using any of these three samples to approximate our posterior, diagnostics
# trace plots: tour
# compare and contrast


# unlike random sample, each value in a Markov chain value depends upon those before it
# behave as randomly as possible
# check autocorrelation (explain lags)


# plot of where the tour spent its time
# density plot approximations



# Use CHAIN 1 to approximate features of the posterior (forget about the others)
# the actual posterior mean of ... is ...
# YOU TRY: approximate the posterior mean using your sample
# Scroll below for a solution











# Solution





# Approximate a 95% posterior credible interval
# i.e. obtain the range of the middle 95% of posterior plausible values
# (How can we interpret this?)
# compare to qbeta()






# Solution




# Approximate the posterior probability that....
# compare to pbeta()






# Solution






# Challenge: posterior prediction
# Simulate and plot the posterior predictive model of ...
# HINTS: 
# Each value in the chain represents a posterior plausible value of pi
# Simulate an outcome of .... at each pi value













# MCMC Under the Hood

# Warning: uses functions and for loops

# Run this
one_mh_iteration <- function(w, current){
  # STEP 1: Propose the next chain location
  proposal <- runif(1, min = current - w, max = current + w)
  
  # STEP 2: Decide whether or not to go there
  proposal_plaus <- dnorm(proposal, 0, 1) * dnorm(6.25, proposal, 0.75)
  current_plaus  <- dnorm(current, 0, 1) * dnorm(6.25, current, 0.75)
  alpha <- min(1, proposal_plaus / current_plaus)
  next_stop <- sample(c(proposal, current), 
                      size = 1, prob = c(alpha, 1-alpha))
  
  # Return the results
  return(data.frame(proposal, alpha, next_stop))
}

plot_one_mh_iteration <- function(w, current){
  one_iteration <- one_mh_iteration(w, current)
  proposal <- one_iteration$proposal
  accepted <- one_iteration$next_stop != current
  if(accepted == TRUE)  {col <- "green"}
  if(accepted == FALSE) {col <- "red"}
  plot_normal(mean = 4, sd = 0.6) + 
    geom_segment(aes(x = current, xend = current, 
                 y = 0, yend = dnorm(current, mean = 4, sd = 0.6))) + 
    geom_segment(aes(x = proposal, xend = proposal, 
                     y = 0, yend = dnorm(proposal, mean = 4, sd = 0.6)),
                 color = col)
}


mh_tour <- function(N, w){
  # 1. Start the chain at location 3
  current <- 3
  
  # 2. Initialize the simulation
  mu <- rep(0, N)
  
  # 3. Simulate N Markov chain stops
  for(i in 1:N){    
    # Simulate one iteration
    sim <- one_mh_iteration(w = w, current = current)
    
    # Record next location
    mu[i] <- sim$next_stop
    
    # Reset the current location
    current <- sim$next_stop
  }
  
  # 4. Return the chain locations
  return(data.frame(mu))
}


tour_1 <- mh_tour(N = 5000, w = 0.1)
mcmc_trace(tour_1)
mcmc_acf(tour_1)
mcmc_dens(tour_1)  + 
  stat_function(fun = dnorm, args = list(4,0.6), color = "blue") 
  


tour_2 <- mh_tour(N = 5000, w = 20)
mcmc_trace(tour_2)
mcmc_acf(tour_2)
mcmc_dens(tour_2) + 
  stat_function(fun = dnorm, args = list(4,0.6), color = "blue")
  


# Find a better window!
