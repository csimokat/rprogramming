# check and set working directory from ~/ to ~/rprogramming/week1
getwd()
setwd("~/rprogramming/week1")

# Example function
myfunction <- function() {
  x <- rnorm(100)
  mean(x)
}

# Second function
second <- function(x) {
  x + rnorm(length(x))
}

