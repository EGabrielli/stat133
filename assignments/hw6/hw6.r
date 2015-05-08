# Homework 6
# Stat 133, Lec 2, Spring 2015
# Due : Friday March 20th by 5 pm

# Review the slides on simulations for this assignment.

# Consider the following model on use of a new drug:
# We have a population of doctors, population size : <n.doctors>
# Every doctor has either adopted the use of a new drug, or not (0/1 status)
# Now write a function that runs a simulation for a period of :
# <n.days> where
# - every day exactly two _random_ doctors meet
# - if one has adopted but the other one has not then the
#   holdout adopts the use of the drug with probability p
# Return a matrix that shows for each day which doctors have adopted
# the use of the drug.

# Input varibles are
# <n.days> : the number of days the simulation should be run for
# <n.doctors> : total number of doctors 
# <initial.doctors> : a 0/1 vector of length <n.doctors>, 1 for adopters
# <p> : the probability that the non-adopter adopts the drug.

# Ouput variable
# <has_adopted> : matrix with <n.doctors> rows and <n.days> columns
#                 i.e. one row for each doctor
#                 the entries are 0 for days where the doctor is a
#                 non-adopter, else 1 (so once a row turns to 1 it stays as 1).


sim.doctors <- function(initial.doctors, n.doctors, n.days, p){
  if (p>1){
    return("p is >1")
  }
 
  if (length(initial.doctors) > n.doctors){
    return("initial.doctors does not equal n.doctors")
  }

  if (n.doctors > length(initial.doctors)){
    return("initial.doctors does not equal n.doctors")
  }

  i = 0
  for (i in 1:length(initial.doctors)){
    if (initial.doctors[i] > 1){
      return("initial.doctors has numbers other than 0s and 1s")
    }
  }
  
  docVec= 1:length(initial.doctors)

  changedMed <- matrix(c(docVec, initial.doctors), nrow = 2, ncol = n.doctors, byrow = T)

  for (i in 1:n.days){
    docmat <- runif(1,0,1)

    checkp <- sample(docVec, 2, replace=F)

    if (changedMed[2,checkp[1]] > changedMed[2,checkp[2]]){
      if (docmat <= p){
        changedMed[2,checkp[2]] = changedMed[2,checkp[1]]
      } 
    }
  
    if (changedMed[2,checkp[2]] > changedMed[2,checkp[1]]){
      if (docmat <= p){
        changedMed[2,checkp[1]] = changedMed[2,checkp[2]]
      }
      
      if (sum(changedMed[2,]) == n.doctors){
        return(changedMed)
      }
    
      i = i + 1
      
    }
  }
  return(changedMed)
}
# Generate a value for <initial.doctors> that has 10% 1s and 90% 0s.
# Run your function for at least 5 different values of <p> and plot
# on x-axis: days,
# on y-axis : the number of doctors that have already adopted the drug, on that day
# Put all 5 lines in one figure (e.g. use first plot() then lines() for the subsequent lines)


