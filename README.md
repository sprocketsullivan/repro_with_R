# Reproducible Research with R

## Preparation for the course

Each participants should prior to the course:

* Complete [Datacamp](https://learn.datacamp.com/) courses Introduction (before Intro Part) and Intermediate R (Before Advanced Part). If you have not yet received an invitation please contact us!
* Install in the newest(!) version:  
  + [R](https://cran.r-project.org/)
  + [RStudio](https://rstudio.com/products/rstudio/download/)  
  + [Git](https://git-scm.com/) (this is for version control)
* Get accounts for:
  + [Github](https://github.com/) You can have the academic version with Charité email
  + [RStudio Cloud](https://rstudio.cloud) You can login via the Github credentials  

Important resources to use if you do not know how to proceed/need help:

* [Cheat sheets](https://rstudio.com/resources/cheatsheets/) on different packages like tidyverse/ggplot, etc. 
* Stackoverflow A community of nerds at your disposal. All beginners questions have been already posted so a simple search is enough!
* help function in R (put cursor on function name and press F1 or type ?function_name)
* at the end of each help text there is a so called vignette that will give an executable example so that you can experiment with the function and its outputs
* contact us. We will explain rules for our online classes in the first session.

## Course Program

We will meet on Wednesdays in an online format.  We will use Teams as video conferencing software. Each course will consist of a short lecture on issues in reproducibility in research, an introduction to a specific topic in programming with R, and an exercise.  
0. Pre course work: Course work on Datacamp (Introduction to R)  

**Introductory Part**  
1. 04.11. Introduction to Reproducible Workflows, R, RStudio, Rstudio Cloud  
2. 11.11. Descriptive statistics with R, Notebooks  
3. 18.11. Inferential statistics with R  
    I) Homework: Intermediate R on DataCamp  
    
**Advanced Part**  
4. 25.11.Preregistration, functions in R  
   I) Exercise: Functions  
   II) Homework: Play around with RStudio Cloud and your own RStudio instance on your computer  
5. 02.12. Data management  
 I) Exercise: Vectorisation  
 II) Homework: Read through the [tutorial](https://doi.org/10.1177/2515245918754826) for Git/Github  
6. 09.12. Git and Github  
  I) Exercise: Git and Github (not as an exercise on Github 
  II) Homework: tidyverse on Datacamp; Read: https://doi.org/10.1038/s41598-018-27482-2  
7. 16.12. Tidyverse  
 I) Exercise: tidyverse  
 II) Homework: ggplot2 part 1 on Datacamp; Read: https://doi.org/10.1371/journal.pone.0185195  
8. 13.01. Advanced Plotting  
   I) Exercise: ggplot  
   II) Homework: course of your choice on Datacamp  
9. 20.01. Linear Models  
 I) Exercise: linear_models  
 II) Homework: course of your choice on Datacamp  
10. 27.01. Linear Mixed Models  
 I) Exercise: linear_mixed_models  
11. 03.02. Theme of your choice  
12. 10.02. Theme of your choice  
Examples:  
* Machine Learning  
* shiny apps  
* meta research  
13. 17.02. Reproducible Research from planning to publication  


## Technical challenges

This course will be taught online only and with that come some challenges. In the first session we will try to resolve as many as possible. We will use the Charité instance of MS teams as our platform for video meetings. For questions during the exercises, we have separate rooms. You can raise your hand and we will then invite you in one of the rooms. All code will be provided on Github where also this document here resides. Additionally, an [OSF project](https://osf.io/wvdxy/) will contain all presentations and a link to the Github repository.  
Each session will begin with a 20 Minute Presentation on issues of reproducibility (see [Course Program](#Course-Program)). After this, there will be a short introduction to R functionalities needed in the upcoming exercise. The exercise itself will be done online in the RStudio cloud. This allows us to run all the exercises without the need to install everything locally on your computer. You are encouraged, however, to also do the same things locally on your computer. Please bear in mind that you need to install all libraries prior to using them.


    install.packages("tidyverse")
    library(tidyverse)

The installation has to be done only once. The library has to be loaded each time R is restarted.
It is good practice to load the libraries at the start of the script where they are used.

## Instructions for RStudio Cloud

I will invite you to RStudio Cloud before the course, you need an account however (see [Preparation](#Preparation-for-the-course)). When the course starts we will the clone the course project to your project folder. All libraries are preinstalled. Each folder in the project is one course day. You will need to work on the exercise file. Only resort to the solution file after the course day. The exercise is that you try to solve this on your own (with our help) and not just copy paste a solution.





