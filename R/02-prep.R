library(rstan)
library(dplyr)

# STEP 1: DEFINE the model
bb_model <- "
  data {
    int<lower = 0, upper = 20> Y;
  }
  parameters {
    real<lower = 0, upper = 1> pi;
  }
  model {
    Y ~ binomial(20, pi);
    pi ~ beta(2, 2);
  }
"

# Chain 1
chain_1 <- stan(model_code = bb_model, data = list(Y = 9), 
                chains = 1, iter = 5000*2, seed = 84735) %>% 
  as.data.frame() %>% 
  select(pi)


# Chain 2
chain_2 <- stan(model_code = bb_model, data = list(Y = 9), 
                chains = 1, iter = 50*2, seed = 84735) %>% 
  as.data.frame() %>% 
  select(pi)

# Chain 3 (this doesn't use rstan -- for illustrative purposes only)
one_mh_iteration <- function(w, current){
  # STEP 1: Propose the next chain location
  proposal <- runif(1, min = current - w, max = current + w)
  
  # STEP 2: Decide whether or not to go there
  if(proposal > 1 | proposal < 0) {next_stop <- current}
  else{
    proposal_plaus <- dbeta(proposal, 2, 2) * dbinom(9, 20, proposal)
    current_plaus  <- dbeta(current, 2, 2)  * dnorm(9, 20, current)
    alpha <- min(1, proposal_plaus / current_plaus)
    next_stop <- sample(c(proposal, current), 
                        size = 1, prob = c(alpha, 1-alpha))
  }
  
  # Return the results
  return(data.frame(proposal, alpha, next_stop))
}

mh_tour <- function(N, w){
  # 1. Start the chain at location 0.5
  current <- 0.5
  
  # 2. Initialize the simulation
  pi <- rep(0, N)
  
  # 3. Simulate N Markov chain stops
  for(i in 1:N){    
    # Simulate one iteration
    sim <- one_mh_iteration(w = w, current = current)
    
    # Record next location
    pi[i] <- sim$next_stop
    
    # Reset the current location
    current <- sim$next_stop
  }
  
  # 4. Return the chain locations
  return(data.frame(pi = pi))
}

set.seed(84735)
chain_3 <- mh_tour(N = 5000, w = 0.01)




# Save the chains
library(here)
write.csv(chain_1, here("R", "chain_1.csv"), row.names = FALSE)
write.csv(chain_2, here("R", "chain_2.csv"), row.names = FALSE)
write.csv(chain_3, here("R", "chain_3.csv"), row.names = FALSE)
