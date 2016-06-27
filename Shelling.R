setwd("~/Documents/MSE/ECON524")

calcindex <- function(x1,y1,x2,y2){ #Given function for calculating index of dissimilarity
  
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

Shelling = function(N,f,t,s){ #Initializes Shelling as a function of N, f, t, and s
  result = matrix(nrow = s, ncol = 2) #creates matrix to store results
  
  for(k in 1:s) { #loops through number of simulation 
    ntype1 = round(N*f) #calculates number of type 1 people
    ntype2 = N - ntype1 #calculates number of type 2 people
    
    #creates starting x and y locations for people of each type
    startxloc1 = runif(ntype1) 
    startxloc2 = runif(ntype2)
    startyloc1 = runif(ntype1)
    startyloc2 = runif(ntype2)
    
    #calculates and stores intital dissimilarity index
    rinitial = calcindex(startxloc1,startyloc1,startxloc2,startyloc2) 
    result[k,1] = rinitial
    
    #creates data frame to store initial locations of all people and their corresponding types
    locations = data.frame("ID" = 1:N, "Xlocation" = NA, "Ylocation" = NA, "Type" = NA)
    locations$Xlocation[1:ntype1] = startxloc1
    locations$Ylocation[1:ntype1] = startyloc1
    locations$Type[1:ntype1] = 1
    locations$Xlocation[(ntype1+1):N] = startxloc2
    locations$Ylocation[(ntype1+1):N] = startyloc2
    locations$Type[(ntype1+1):N] = 2
    
    #creates a dataframe to store optimal locations for each person
    optlocations = matrix(nrow = N, ncol = 3)
    colnames(optlocations) = c("Xlocation","Ylocation","Type")
    optlocations = as.data.frame(optlocations)
    
    #creates a dataframe to store distances between a given person and all other people
    distances = matrix(nrow = nrow(locations),ncol = 2)
    colnames(distances) = c("Distance", "Type")
    distances = as.data.frame(distances)
    
    
    for (i in 1:length(locations$ID)) { #loops through locations for each person 
      x = locations$Xlocation[i] #sets person i's x location
      y = locations$Ylocation[i] #sets person i's y location
      type = locations$Type[i] #sets person i's type
      
      distances$Distance[] = sqrt(((locations$Xlocation[]-x)^2)+((locations$Ylocation[]-y)^2)) #finds the distance between person i and all other people
      distances$Type[] = locations$Type[] #sets the type of each person in the distance dataframe
      distances = distances[order(distances$Distance),] #orders distances from person i in ascending order
      
      if (length(which(distances$Type[2:11]==type))<10*t) { #checks to see if person wishes to move
        while(length(which(distances$Type[2:11]==type))<10*t){ #loops until person doesn't wish to move 
          locations[i,2:3] = runif(2) #resets x and y locations of person i
          x = locations$Xlocation[i] #sets x location
          y = locations$Ylocation[i] #sets y location
          
          distances$Distance[] = sqrt(((locations$Xlocation[]-x)^2)+((locations$Ylocation[]-y)^2)) #recalculates distances between person i and everyone else
          distances$Type[] = locations$Type[] #sets types of all people
          distances = distances[order(distances$Distance),] #orders distances from person i in ascending order
        }
        
      }
      #person i no longer wants to move
      optlocations$Xlocation[i] = x #sets x location for person i to an optimal x location
      optlocations$Ylocation[i] = y #sets y location for person i to an optimal y location
      optlocations$Type[i] = type #sets type for person i
    } 
    
    #creates optimal x and y location vectors for people of types 1 and 2, for use in the calcindex function
    optxloc1 = optlocations$Xlocation[optlocations$Type==1]
    optyloc1 = optlocations$Ylocation[optlocations$Type==1]
    optxloc2 = optlocations$Ylocation[optlocations$Type==2]
    optyloc2 = optlocations$Ylocation[optlocations$Type==2]
    
    roptimal = calcindex(optxloc1,optyloc1,optxloc2,optyloc2) #calculates optimal index
    result[k,2] = roptimal #stores optimal index for simulation s
  }
  finalresult = c(mean(result[,1]),mean(result[,2])) #creates vector of averages for initial indices and equilibrium indices
  return(finalresult) #returns average initial index and equilibrium index from all simulations
}

