# Intro to the R Language
# Loop functions
# lapply() - loop over a list and evalutate a function on each element
# sapply() - same as lapply but try to simplify the result
# apply() - apply a function over the margins of an array
# tapply() - apply a function over subsets of a vector
# mapply() - multivariate version of lapply
# split() is useful with the apply functions
# lapply(X, FUN, ...)
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif)
lapply(x, runif, min = 0, max = 10)

x <- list(a = matrix(1:4,2,2), b = matrix(1:6,3,2))
x
lapply(x, function(elt) elt[,1]) # Anonymous Function

# sapply will simplify lapply results if possible
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100, 5))
sapply(x,mean)

# apply good for rows or columns in a matrix
x <- matrix(rnorm(200),20,10)
apply(x,2,mean) # the 2 tells us we want the columns, aggregate the rows by function
apply(x,1,sum) # the 1 tells us we want the rows, aggregate the columns by function

# for sums and means on columns and rows
# rowSums, rowMeans, colSums, colMeans
# much faster than the above examples

x <- matrix(rnorm(200),20,10)
apply(x,1,quantile,probs=c(.25,.75))

a <- array(rnorm(2*2*10),c(2,2,10))
apply(a,c(1,2),mean)
rowMeans(a,dims=2)

# mapply
# str(mapply); function(FUN, ..., MoreArgs = NULL, SIMPLIFY = T, USE.NAMES = T)
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
  rnorm(n,mean,sd)
}
noise(5,1,2)
noise(1:5,1:5,2) # doesn't work as expected
mapply(noise,1:5,1:5,2) # works as expected -- allows vectorizing a function not vectorized

# tapply - subsets of vectors
# str(tapply); function(X, INDEX, FUN = NULL, ..., simplify = T)
# e.g. take group means
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10)
f
tapply(x,f,mean)
tapply(x,f,mean,simplify=F)
tapply(x,f,range)

# split
# str(split); function(x, f, drop = F, ...)
# split takes a vector or other object and splits it into groups
# determined by a factor or list of factors
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10)
split(x,f)
lapply(split(x,f),mean) # could also be done as tapply

library(datasets)
head(airquality)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")], na.rm=T))
# Splitting on more than one level
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
f1
f2
interaction(f1,f2)
str(split(x, list(f1,f2)))

# debugging tools - diagnosing the problem
# how do you know there is a problem?
# message - generic notice function continues
# warning - indicates something is wrong, but maybe not fatal
# error - fatal problem occured, execution stops
# all are conditions
# condition - a generic concept for indicating something unexpected happened

# warning
log(-1)

printmessage <- function(x) {
  if(x>0)
    print("x is greater than zero")
  else
    print("x is less than or equal to zero")
  invisible(x) # prevents autoprinting
}

printmessage(1)
printmessage(NA)

printmessage2 <- function(x) {
  if(is.na(x))
    print("x is a missing value!")
  else if(x>0)
    print("x is greater than zero")
  else
    print("x is less than or equal to zero")
  invisible(x) # prevents autoprinting
}

x <- log(-1)
printmessage2(x)

# Debugging basic tools
# traceback - prints out the function call stack after an error occurs
# debug - flags a function for "debug" mode which allows stepping through one line at a time
# browser - suspends the execution wherever it is called and puts the function in debug mode
# trace - allows you to insert debug code into a function in specific places
# recover - allows you to modify the error behavior so you can browser the function call stack

rm(x)
mean(x)
traceback()

lm(y ~ x)
traceback()

debug(lm)
lm(y ~ x)

options(error=recover)
read.csv("nosuchfile")

