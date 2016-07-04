## R Programming Assignment 1
## @csimokat

## Part 3: Write a function that takes a directory of data files and a threshold for complete
## cases and calculates the correlation between sulfate and nitrate for monitor locations where
## the number of completely observed cases (on all variables) is greater than the threshold.
## The function should return a vector of correlations for the monitors that meet the threadhold.
## If no monitors meet the requirement, then the function should return a numeric vector of
## length 0.

corr <- function(directory, threshold=0) {
  
  nobs <- numeric(length(dir("~/rprogramming/week2/specdata")))
  corrVect <- numeric()
  
  for(i in 1:length(dir("~/rprogramming/week2/specdata"))) {
    ids <- sprintf("%03d.csv", i)
    file <- paste(getwd(),"/",directory,"/",ids, sep="")
    data <- read.csv(file, header=T, na.strings=c("NA","NaN"," "))
    data <- na.omit(data)
    nobs[i] <- nrow(data)
    
    if(nobs[i] > threshold) {
      corrVect <- c(corrVect, cor(data[,2], data[,3]))
    }
  }
  corrVect
}