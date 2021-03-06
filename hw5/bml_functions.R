#################################################################################
#### Functions for BML Simulation Study


#### Initialization function.
## Input : size of grid [r and c] and density [p]
## Output : A matrix [m] with entries 0 (no cars) 1 (red cars) or 2 (blue cars)
## that stores the state of the system (i.e. location of red and blue cars)

#basic values
bml.init <- function(r,c,p){
  CarType <- c(0:2)
  probability = c(p*0.6, p*0.4, 1-p)
  matrix(sample(CarType, r*c, probability, replace = TRUE), nrow = r, ncol = c)
}

#going north
Direction.North <- function(m) {
  if(nrow(m)==1) {
    return(m)
  }
  check <- m[c(nrow(m), 1:(nrow(m)-1)),]!=0
  
  Blue.Cars <- m*(m==2)
  m*(m!=2) + Blue.Cars*check + (Blue.Cars*!check)[c(2:nrow(m), 1), ]
}
#going east
Direction.East <- function(m) {
  if(ncol(m)==1) {
    return(m)
  }
  check <- m[, c(2:ncol(m), 1)]!=0
  
  Red.Cars <- m*(m==1)
  m*(m!=1) + Red.Cars*check + (Red.Cars*!check)[,c(ncol(m), 1:(ncol(m)-1))] 
}
#step function
bml.step <- function(m){
  stepping <- Direction.East(Direction.North(m))
  return(list(stepping, !all(m==stepping)))
}
#simulationfunction
bml.sim <- function(r, c, p){
  type<-bml.init(r,c,p)
  match = T
  first=0
  last=1000
  while(match==T&(first<last)){
    if(bml.step(type)[[2]]==F){
      match=F
    }
    image(t(apply(type, 2, rev)), axes = F, col = c("white", "red", "blue"))
    type=bml.step(type)[[1]]
    first=first+1
  }
  if (first!=last){
    return(first)
  }
=======
bml.init <- function(r, c, p){

  
   #return(m)
}

#### Function to move the system one step (east and north)
## Input : a matrix [m] of the same type as the output from bml.init()
## Output : TWO variables, the updated [m] and a logical variable
## [grid.new] which should be TRUE if the system changed, FALSE otherwise.

## NOTE : the function should move the red cars once and the blue cars once,
## you can write extra functions that do just a step north or just a step east.

bml.step <- function(m){

  
   #return(list(m, grid.new))
}

#### Function to do a simulation for a given set of input parameters
## Input : size of grid [r and c] and density [p]
## Output : *up to you* (e.g. number of steps taken, did you hit gridlock, ...)

bml.sim <- function(r, c, p){

}
