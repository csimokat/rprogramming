library(datasets)
data(iris)
?iris
which(iris$Species == "virginica")
round(mean(iris$Sepal.Length[which(iris$Species == "virginica")]))

apply(iris[,1:4],2,mean)

data(mtcars)
?mtcars

sapply(split(mtcars$mpg,mtcars$cyl), mean) # yes
apply(mtcars,2,mean) # no
with(mtcars, tapply(mpg,cyl,mean)) # yes
tapply(mtcars$cyl, mtcars$mpg, mean) # no
tapply(mtcars$mpg, mtcars$cyl, mean) # yes
mean(mtcars$mpg, mtcars$cyl) # no
sapply(mtcars,cyl,mean) # no
split(mtcars, mtcars$cyl) # no
lapply(mtcars, mean) # no

colMeans(iris[,1:4])
class(colMeans(iris[,1:4]))
apply(iris,2,mean)
apply(iris,1,mean)
apply(iris[,1:4], 2, mean)

round(abs(mean(mtcars$hp[which(mtcars$cyl == 4)])-mean(mtcars$hp[which(mtcars$cyl == 8)])))

debug(ls)
ls(x)
undebug(ls)
