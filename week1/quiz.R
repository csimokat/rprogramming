x <- 4
class(x)

x <- 4L
class(x)

x <- c(4,T)
class(x)

x <- c(4, "a", T)
class(x)

x <- c(1,3,5); y <- c(3,2,10)
cbind(x,y)
rbind(x,y)
class(cbind(x,y))

x <- list(2,"a","b",T)
x[[1]]
class(x[[1]])

x <- list("foo", "bar")
class(x)

x <- 1:4; y <- 2
x+y
class(x+y)

x <- c(3,5,1,10,12,6)
x
x[x<6] <- 0
x
x[x %in% 1:5] <- 0
x

x <- c(17,14,4,5,13,12,10)
x
x[x>10] <- 4
x
x[x>=11] <- 4
data <- read.csv("hw1_data.csv")
names(data)
data[1:2,]
nrow(data)
data[152:153,]
data$Ozone[47]
sum(is.na(data$Ozone))
mean(data$Ozone, na.rm=T)
which(data$Ozone > 31 & data$Temp >90)
mean(data[which(data$Ozone > 31 & data$Temp >90),]$Solar.R)
mean(data[which(data$Month == 6),]$Temp)
max(data[which(data$Month == 5),]$Ozone, na.rm=T)
