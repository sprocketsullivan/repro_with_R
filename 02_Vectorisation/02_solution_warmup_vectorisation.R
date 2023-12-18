# We first create a sample from hospital protocols describing the disability level of 1000 patients post-stroke. 
# The severity levels are "no symptoms", "no significant disability", "slight disability", "moderate disability", "moderately severe disability" and "severe disability"
# Create a character vector from the disability levels 
disability_levels <- c("no symptoms", 
                       "no significant disability", 
                       "slight disability", 
                       "moderate disability", 
                       "moderately severe disability", 
                       "severe disability")

# Now sample from the character vector with the command "sample" and define the disease severity 
# If more than one patient is counted for each disability level, how do we have to define "replace"?
disability_severity<- sample(disability_levels, size = 1000 , replace = TRUE) 

# create a dataframe called "patient_data" with the two variables disease_severity and patient id 
patient_data <- data.frame(disability_severity, id = 1:1000)

# Patients with no symptoms or no significant disability can soon be handled in the outpatient 
# care sector. Therefore we want to create a new variable "outpatient", which takes the value 1 for patients
# with "no symptoms" and "no significant disability" and the value 0 for patients with higher disability 
# levels 

# create the values of the variable "outpatient" using a for-loop 
outpatient_1 <- vector(length = 1000) 
for (i in 1:length(disability_severity)) {
  if (disability_severity[i] == "no symptoms" | disability_severity[i] == "no significant disability") {
    outpatient_1[i] <- 1} else {
      outpatient_1[i] <- 0}
}

# now create the values of the variables "outpatient" using the vectorized ifelse() command 
outpatient_2 <- vector(length = 1000) 
outpatient_2  <- ifelse(patient_data$disability_severity == "no symptoms"| patient_data$disability_severity == "no significant disability", 1, 0) 


# check if vector outpatient_1 is equal to vector outpatient_2 for all data points
sum(outpatient_1 == outpatient_2)
# add the new outpatient variable to the dataframe 
patient_data$outpatient <- outpatient_2 # you can of course also add outpatient_1


