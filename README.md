# Shelling
This program implements and simulates a simplified version of Shelling's location model in order to learn more about expected rates of segregation for various parameters of the model. The basic idea of Shelling’s model is that there are two kinds of people (i.e. two races) and that individuals are fine living in integrated neighborhoods. However, they dislike being extreme minorities where most of their neighbors are of the other type. When too many of their neighbors are of the other type, they move to a new neighborhood that is acceptable.

###Initial Configuration:
Each individual is located at a random location (x,y) on a unit square:
(x,y) ε [0,1] x [0,1]

###Moving:
If at least t% of 10 closest neighbors are of the same type, then do not move.
If fewer than t% of 10 closest neighbors are of the same type, then move. Choose a new random location and check if it meets the threshold. If so, move there. If not, repeat until the randomly chosen location is acceptable.

###Equilibrium:
Equilibrium occurs when everyone is OK with their current location, no one wants to move.

###Algorithm:
Repeat until no one moves: For each individual:

  Check if individual moves or not: (1) Calculate distance between that individual and everyone else, (2) sort by distance, (3) take 10 closest neighbors and count how many of same type, (4) compare to 10*t
  
  While individual wants to move: Move to random location
  
  Check if individual moves or not
  
###Diss_Index
This function calculates the dissimilarity index that is used to determine if an individual will want to move based on the race of his neighbors.

###Shelling
This is the program that implements the simulation and can be used to derive parameter sensitivity.
