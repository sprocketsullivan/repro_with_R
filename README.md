# Reproducible Research with R

## Preparation for the course

Each participants should prior to the course:

* Complete [DataCamp](https://learn.datacamp.com/) courses Introduction to R and Intermediate R. If you have not yet received an invitation please contact us!
* Install in the newest(!) version:  
  + [R](https://cran.r-project.org/)
  + [RStudio](https://rstudio.com/products/rstudio/download/)  
  + [Git](https://git-scm.com/) (this is for version control)
* Get accounts for:
  + [Github](https://github.com/) You can have the academic version with Charité email


Important resources to use if you do not know how to proceed/need help:

* [Cheat sheets](https://rstudio.com/resources/cheatsheets/) on different packages like tidyverse, ggplot, etc. 
* Stackoverflow: A community of nerds at your disposal. All beginners questions have been already posted so a simple search is enough!
* help function in R (put cursor on function name and press F1 or type ?function_name)
* at the end of each help text there is a so called vignette that will give an executable example so that you can experiment with the function and its outputs
* Contact us. We will explain rules for our classes in the first session.

## Course Program

We will meet on Tuesdays (once on a Wednesday), 2pm - 6pm, in presence in the conference room Atrium at the BIH (5th floor, Anna-Lousia-Karsch-Straße 2, 10178 Berlin). Each course part will consist of two short lectures on issues in reproducibility in research, an introduction to a specific topic in programming with R, and an exercise.  

0. Pre course work: Course work on DataCamp (Introduction to R + Intermediate R)
Particularly recommended for participants with no or little experience in R.

**1. Session 13.11.**

Part 1 Preregistration, Functions in R  
   Exercise: Functions 
   
Part 2 Data Management  
   Exercise: Vectorisation  

*Homework*:  
I Introduction to the Tidyverse on DataCamp  
II  Read [Tutorial](https://doi.org/10.1177/2515245918754826) for Git/Github  

**2. Session 04.12.**  

Part 1 Git and Github  
   Exercise: Git and Github  

Part 2 Tidyverse  
   Exercise: tidyverse  
   Read: https://doi.org/10.1371/journal.pone.0185195  

*Homework*:  
Datacamp course ggplot2   

**3. Session 15.01.**  

Part 1 Advanced Plotting  
   Exercise: ggplot  
   
Part 2 Introduction Statistics with R 
   Exercise: linear_models  
   
*Homework*:  
2 courses of your choice on DataCamp  

**4. Session 22.01.**  

Part 1 Linear Mixed Models    
   Exercise: linear_mixed_models  
   
Part 2 Reproducible Research from Planning to Publication  
   Exercise: Open Peer Review  

## Technical challenges

We plan to conduct all sessions in presence. Please bring a laptop with Chrome browser installed. You can also install everything locally, but it is not certain whether we will have time to troubleshoot every computer.

All code will be provided on Github where also this document here resides. Additionally, an [OSF project](https://osf.io/wvdxy/) will contain all presentations and a link to the Github repository.  

Each course part will begin with a 20-minute presentation on issues of reproducibility (see [Course Program](#Course-Program)). After this, there will be a short introduction to R functionalities needed in the upcoming exercise. The exercise itself will be done on your computer, which is why it is essential for you to make sure you have installed and tested R and RStudio on your computer beforehand. If you experience persistent difficulties with this, please let us know. Please bear in mind that you need to install all libraries prior to using them.


    install.packages("tidyverse")
    library(tidyverse)

The installation has to be done only once. The library has to be loaded each time R is restarted.
It is good practice to load the libraries at the start of the script where they are used.





