# R console input and evaluation
x <- 1
print(x)
msg <- "hello"
x

# Create a sequence
x <- 1:20
x

# Data Types - vectors and lists
x <- c(0.5,0.6) # numeric
x <- c(T,F) # logical
x <- c("a", "b", "c") # character
x <- 9:29 # integer
x <- c(1+0i, 2+4i) # complexit

# Mixing objects - works be coercion
y <- c(1.7, "a") # character
y <- c(T, 2) # numeric
y <- c("A", TRUE) # character T <- 1, F <- 0

# Explicit Coercion
x <- 0:6
class(x)
as.logical(x)
as.character(x)

# Lists
x <- list(1, "a", TRUE, 1+4i)
x

# Data types - matrices -- special type of vector
m <- matrix(nrow=2, ncol=3)
m
dim(m)
attributes(m)
m <- matrix(1:6, nrow=2, ncol=3)
m

m <- 1:10
m
dim(m) <- c(2,5)
m

# cbind and rbind
x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x,y)

# Factors - unorderd or ordered for categorical data analysis
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x)
unclass(x)

x <- factor(c("yes", "yes", "no", "yes", "no"), levels=c("yes", "no"))
x

# Missing values
x <- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x)
x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

# Data Frames
x <- data.frame(foo = 1:4, bar=c(T,T,F,F))
x
nrow(x)
ncol(x)

# Names
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf")
x
names(x)

x <- list(a=1, b=2, c=3)
m <- matrix(1:4, nrow=2, ncol=2)
dimnames(m) <- list(c("a","b"),c("c","d"))
m

# Reading tabular data
# read.table, read.csv, readLines, source, dget, load, unserialize
# Writing data
# write.table, writeLines, dump, dput, save, serialize

# Reading large tables -- comments and classes are important to timing and memory
intial <- read.table("datatable.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt", colClasses=classes)

# Calculating memory requirements
# df with 1.5MM rows 120 columns all numeric - 8 bytes/numeric
# 1500000 x 120 x 8 = 1440000000 / 2^20 = 1373.29 MB = 1.34 GB

# Text data formats - dput() and dump()
# These preserve the metadata

y <- data.frame(a=1,b="a")
dput(y)
dput(y, file="y.R")
new.y <- dget("y.R")
new.y

x <- "foo"
y <- data.frame(a=1, b="a")
dump(c("x","y"), file="data.R")
rm(x,y)
source("data.R")
y
x

# Connections: interfaces to the outside world
# file, gzfile, bzfile, url
con <- file("foo.txt", "r")
data <- read.csv(con)
close(con)
# is the same as read.csv(file)
# readLines
con <- gzfile("words.gz")
x <- readLines(con,10)
x
# Read a website
con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)
close(con)

# Subsetting
# [, [[, $
x <- c("a", "b", "c", "c", "d", "a")
x[1]
x[2]
x[1:4]
x[x > "a"]
u <- x > "a"
u
x[u]

# Subsetting lists
x <- list(foo=1:4, bar=0.6)
x[1]
x[[1]]
x$bar
x["bar"]
x <- list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)]
name <- "foo"
x[[name]]
x <- list(a=list(10,12,14), b=c(3.14,2.81))
x[[c(1,3)]]
x[[1]][[3]]
x[[c(2,1)]]

# subsetting matricies
x <- matrix(1:6,2,3)
x[1,2]
x[2,1]
x[1,]
x[,2]
x[1,2,drop=F]
x[1,,drop=F]

# Subsetting - partial matching
x <- list(aardvark = 1:5)
x$a
x[["a"]]
x[["a", exact=F]]

# Subsetting - removing missing values
x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)
x[!bad]
y <- c("a","b",NA,"d",NA,"f")
good <- complete.cases(x,y)
good
x[good]
y[good]

airquality[1:6,]
good <- complete.cases(airquality)
airquality[good,][1:6,]

# Vectorized Operations
# Generally speaking vectorized functions good, looping bad! (for R and Python)
x <- 1:4; y <- 6:9
x+y
x > 2
x >= 2
y == 8
x * y
x / y

x <- matrix(1:4,2,2); y <- matrix(rep(10,4),2,2)
x * y # element-wise multiplication
x / y # element-wise division
x %*% y # matrix multiplication