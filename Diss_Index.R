# This function calculates the index of dissimilarity by dividing the unit square into 4 quadrants and 
#looking at the proportion of each type in each quadrant.
# Inputs:
# x1: a vector of the x locations of type 1 people (length = number of type 1 people)
# y1: a vector of the y locations of type 1 people (length = number of type 1 people)
# x2: a vector of the x locations of type 2 people (length = number of type 2 people)
# y2: a vector of the y locations of type 2 people (length = number of type 2 people)
#
# Return Value:  the index of dissimilarity, between 0 and 1 (0=perfect integration, 1=perfect segregation)

calcindex <- function(x1,y1,x2,y2){
  
  n1 = length(x1)
  n2 = length(x2)
  
  q1e=sum(as.integer((x1<0.5)&(y1<0.5)))
  q2e=sum(as.integer((x1>=0.5)&(y1<0.5)))
  q3e=sum(as.integer((x1<0.5)&(y1>=0.5)))
  q4e=sum(as.integer((x1>=0.5)&(y1>=0.5)))
  
  q1o=sum(as.integer((x2<0.5)&(y2<0.5)))
  q2o=sum(as.integer((x2>=0.5)&(y2<0.5)))
  q3o=sum(as.integer((x2<0.5)&(y2>=0.5)))
  q4o=sum(as.integer((x2>=0.5)&(y2>=0.5)))
  
  r = 0.5*(abs(q1e/n1-q1o/n2)+abs(q2e/n1-q2o/n2)+abs(q3e/n1-q3o/n2)+abs(q4e/n1-q4o/n2))
  
  return(r)
  
}
