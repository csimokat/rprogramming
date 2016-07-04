# Control structures in R
# if-else, for, while, repeat, break, next, return

# if-else
if (x > 3) {
  y <- 10
} else {
  y <- 0
}

# Also valid
y <- if (x > 3) {
  10
} else {
  0
}

# for loops
for(i in 1:10) {
  print(i)
}

x <- c("a", "b", "c", "d")

for(i in 1:4) {
  print(x[i])
}

for(i in seq_along(x)) {
  print(x[i])
}

for(letter in x) {
  print(letter)
}

for(i in 1:4) print(x[i])

# for loops can be  nested
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
} 

# While loops
count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}

# Testing more than one condition
z <- 5
while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, .5)
  
  if(coin == 1) { ##rand walk
    z <- z + 1
  } else {
      z <- z - 1
    }
}

# Repeat, next, break
xO <- 1
tol <- 1e-8

repeat {
  x1 <- computeEstimate() # Fake/example function
  
  if(abs(x1-xO)) {
    break
  } else {
    xO <- x1
  }
}

for(i in 1:100) {
  if(i <= 20) {
    # skip first 20
    next
  }
  # Do something else 
}

# return signals a function should exit and return a value

# First R Function
add2 <- function(x, y) {
  x + y
} # R will automatically return the last function's value

# Another function
above10 <- function(x) {
  use <- x > 10
  x[use]
}

above <- function(x, n) {
  use <- x > n
  x[use]
}

# Default args can be set
above <- function(x, n=10) {
  use <- x > n
  x[use]
}

# Using data frames
columnmean <- function(x, removeNA = T) {
  nc <- ncol(x)
  means <- numeric(nc)
  
  for(i in 1:nc) {
    means[i] <- mean(x[,i], na.rm = removeNA)
  }
  means
}

# Functions
f <- function(args) {
  # Do something
}

# formals, args

# Lazy eval
f <- function(a, b) {
  print(a)
  print(b)
}

f(45) # only one number means b has no value

# scoping rules
# How R know which value to assing a symbol?
# R uses lexical or static scoping
# Lexical scoping in R means that the values of free variables are searched for in the 
# environment in which the function was defined
# global envionrment is the workspace in R
# DEF environment - a collection of (symbol, value) pairs
# every env has a parent, possible for env to have multiple children
# only env with no parent is the empty one
# a function + env = a function closure

f <- function(x, y) {
  x^2 + y / z # z is a free variables, while x and y are formal arguments
}

# R scoping rules
make.power <- function(n) {
  pow <- function(x) {
    x^n
  }
  pow
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)

# Look at the environment
ls(environment(cube))
get("n", environment(cube))
ls(environment(square))
get("n", environment(square))

y <- 10

f <- function(x) {
  y <- 2
  y^2 + g(x)
}

g <- function(x) {
  x*y
}

f(3) # what get's returned?

# clear environment and then run
g <- function(x) {
  a <- 3
  x+a+y
}
g(2) # error in g(2) : object "y" not found
y <- 3
g(2)

# Application Optimization
# optim, nlm, optimize - take a function to find a min/max (e.g. log-likelihood)

# Maximizing a normal likelihood
make.NegLogLik <- function(data, fixed=c(F,F)) {
  params <- fixed
  function(p) {
    params[!fixed] <- p
    mu <- params[1]
    sigma <- params[2]
    a <- -.5*length(data)*log(2*pi*sigma^2)
    b <- -.5*sum((data-mu)^2) / (sigma^2)
    -(a + b)
  }
}

set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL))

# Estimating parameters
optim(c(mu = 0, sigma = 1), nLL)$par
# fixing sigma = 2
nLL <- make.NegLogLik(normals, c(F,2))
optimize(nLL, c(-1,3))$minimum
# fixing mu = 1
nLL <- make.NegLogLik(normals,c(1,F))
optimize(nLL, c(1e-6,10))$minimum

# Plotting the likelihood
nLL <- make.NegLogLik(normals, c(1,F))
x <- seq(1.7,1.9, len=100)
y <- sapply(x, nLL)
plot(x, exp(-(y- min(y))), type="l")

# Dates and times
x <- as.Date("1970-01-01")
x
unclass(x)
unclass(as.Date("1970-01-02"))
# For times posixct (int) and posixlt (list)
x <- Sys.time()
x
p <- as.POSIXlt(x)
names(unclass(p))
p$sec
unclass(x) # Already posixct type
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)

x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y
x <- as.POSIXlt(x)
x-y

# track time zones and leap years automatically
x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y
x <- as.POSIXct("2012-10-25 1:00:00")
y <- as.POSIXct("2012-10-25 6:00:00", tz="GMT")
y-x

