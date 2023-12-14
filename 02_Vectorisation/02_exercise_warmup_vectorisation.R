# We first create a sample from hospital protocols describing the disability level of 1000 patients post-stroke. 
# The severity levels are "no symptoms", "no significant disability", "slight disability", "moderate disability", "moderately severe disability" and "severe disability"
# Create a character vector from the disability levels 
disability_levels <- c()

# Now sample from the character vector with the command "sample" and define the disease severity 
# If more than one patient is counted for each disability level, how do we have to define "replace"?
disability_severity<- sample(disability_levels, size =  , replace = ) 

# create a dataframe called "patient_data" with the two variables disease_severity and patient id 
patient_data <- data.frame(disability_severity, id = )


# Patients with no symptoms or no significant disability can soon be handled in the outpatient 
# care sector. Therefore we want to create a new variable "outpatient", which takes the value 1 for patients
# with "no symptoms" and "no significant disability" and the value 0 for patients with higher disability 
# levels 

# create the values of the variable "outpatient" using a for-loop 

outpatient <- vector(length = 1000) 
for (i in 1:) {
  if () {
   } else {
     }
}

# now create the values of the variables "outpatient" using the vectorized ifelse() command 
outpatient <- vector(length = 1000) 
outpatient  <- ifelse(patients == | patients == , , ) 


# add the new outpatient variable to the dataframe 


