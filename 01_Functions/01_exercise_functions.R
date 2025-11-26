# create several files for later read in
dir.create("./01_Functions/created_files/")
for (i in 1:100) {
  write.csv(file = paste("./01_Functions/created_files/file_", i, ".csv", sep = ""), data.frame(y = rnorm(20, 0, 3)))
}
# Exercise 1
# write a function to load and retrieve the mean and max of each file and plot a boxplot
# You will first have to read in the created files within the function with read.csv()





# plot the first 10 datasets
# the following line will ensure that each plot has a 2 by 5 panel layout
par(mfrow = c(2, 5))
par(mar=c(.5,1.5,.5,.5))
for () {
  # use the first function here 
}


# now plot only extreme data sets
# where the mean is more than 1 away from 0
# give the number of the data set
# write a separate function for this
# again, don't forget to first read in the files with read.csv() command 





# the following line cancels the last figure
dev.off()
# let's hope it's not more than 16:)
par(mfrow = c(4, 4))
par(mar=c(.5,1.5,.5,.5))
for (i in 1:100) {
  #use your second function here!
}
# IF plot margin are too small enlarge plot window in the lower right corner of the RStudio IDE
# identify all data files with the pattern="file*"
# and delete them
files <- dir("./01_Functions/created_files/")
file.remove(paste("./01_Functions/created_files/", files[grep("file*", files)], sep = ""))

# if you are finished early read the chapter on style guide
# https://swcarpentry.github.io/r-novice-inflammation/06-best-practices-R/
# or
# http://adv-r.had.co.nz/Style.html
# or
# https://google.github.io/styleguide/Rguide.xml
# report this to other participants later
