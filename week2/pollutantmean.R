## R Programming Assignment 1
## @csimokat

## Part 1: write a function "pollutantmean" that calculates the mean of a pollutant (sulfate or 
## nitrate) across a list of monitors. The func takes 3 args: dir, pollutant, id.
## Given a vector monitor ID numbers "pollutantmean" reads that monitors particulate matter data
## from the directory specified in the "directory" argument and returns the mean of the pollutant
## across all of the monitors, ignoring any missing values coded as NA.

pollutantmean <- function(directory, pollutant, id = 1:332) {
  means <- numeric(length(id))
  weights <- numeric(length(id))
  
  for(i in 1:length(id)) {
    ids <- sprintf("%03d.csv", id[i])
    file <- paste(getwd(),"/",directory,"/",ids, sep="")
    data <- read.csv(file, header=T, na.strings=c("NA","NaN"," "))
    data <- na.omit(data)
    means[i] <- mean(data[,pollutant], na.rm=T)
    weights[i] <- nrow(data)
  }
  
  weighted.mean(means, weights)
}