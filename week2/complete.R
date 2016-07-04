## R Programming Assignment 1
## @csimokat

## Part 2: Write a function that reads a directory full of files and reports the number of 
## completely observed cases in each data file. The function should return a data frame where the
## first column is the name of the file and the second is the number of complete cases.

complete <- function(directory, id=1:332) {
  nobs <- numeric(length(id))
  
  for(i in 1:length(id)) {
    ids <- sprintf("%03d.csv", id[i])
    file <- paste(getwd(),"/",directory,"/",ids, sep="")
    data <- read.csv(file, header=T, na.strings=c("NA","NaN"," "))
    data <- na.omit(data)
    nobs[i] <- nrow(data)
  }
  
  df <- data.frame(id,nobs)
  names(df) <- c("id", "nobs")
  df
}