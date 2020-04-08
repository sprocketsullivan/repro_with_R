# create several files for later read in
for (i in 1:100) {
  write.csv(file = paste("file_", i, ".csv", sep = ""), data.frame(y = rnorm(20, 0, 3)))
}
# Exercise 1
# write a function to load and retrieve the mean and max of each file
# plot a boxplot
extractor <- function(k) {
  test.data <- read.csv(paste("file_", k, ".csv", sep = ""))
  print(mean(test.data$y))
  print(max(test.data$y))
  boxplot(test.data$y)
}
# plot the first 10 datasets
par(mfrow = c(2, 5))
for (i in 1:10) {
  extractor(i)
}

# now plot only extreme datasets
# where the mean is more than 1 away from 0
# give the number of the data set
# write a separate function for this
extractor2 <- function(k) {
  test.data <- read.csv(paste("file_", k, ".csv", sep = ""))
  if (abs(mean(test.data$y)) > 1) {
    boxplot(test.data$y)
    print(k)
  }
}
dev.off()
# let's hope it's not more than 16:)
par(mfrow = c(4, 4))
for (i in 1:100) {
  extractor2(i)
}

# identify all data files with the pattern="file*"
# and delete them
files <- dir()
file.remove(files[grep("file*", files)])

# if you are finished early read the chapter on style guide
# https://swcarpentry.github.io/r-novice-inflammation/06-best-practices-R/
# or
# http://adv-r.had.co.nz/Style.html
# or
# https://google.github.io/styleguide/Rguide.xml
# report this to other participants later
