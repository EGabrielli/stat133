#################################################################################
#### BML Simulation Study

#### Put in this file the code to run the BML simulation study for a set of input parameters.
#### Save some of the output data into an R object and use save() to save it to disk for reference
#### when you write up your results.
#### The output can e.g. be how many steps the system took until it hit gridlock or
#### how many steps you observered before concluding that it is in a free flowing state.


bml.sim(10,10,.5)
#36, 196
bml.sim(25,50,.4)
#72, 70, 
bml.sim(35,55,.9)
#dint stop
bml.sim(75,25,.6)
#105, 127
bml.sim(20,20,.3)
#36, 196
bml.sim(90,30,.5)
#153, 111, 
bml.sim(35,55,.9)
#didnt stop
bml.sim(75,25,.6)
#210,201
bml.sim(15,15,.4)
#98, 21
bml.sim(90,90,.25)
#100,111
bml.sim(30,60,.75)
#didnt stop
bml.sim(50,25,.1)
#165,110

