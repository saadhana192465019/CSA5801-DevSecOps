###############################################################
# MODULE 6 - RESULTS COLLECTION
###############################################################

cat("========================================\n")
cat("COLLECTING PROJECT RESULTS\n")
cat("========================================\n")

###############################################################
# Create Result Folders
###############################################################

dir.create("Results/Graphs", recursive = TRUE, showWarnings = FALSE)
dir.create("Results/Tables", recursive = TRUE, showWarnings = FALSE)
dir.create("Results/Statistics", recursive = TRUE, showWarnings = FALSE)
dir.create("Results/Datasets", recursive = TRUE, showWarnings = FALSE)

###############################################################
# Copy Datasets
###############################################################

datasets <- c(
  "Module1_Dataset/synthetic_dataset.csv",
  "Module2_Preprocessing/processed_dataset.csv",
  "Module3_CTGAN/simulation_dataset.csv",
  "Module4_Simulation/final_simulation.csv"
)

for(i in datasets){
  
  if(file.exists(i)){
    
    file.copy(
      from=i,
      to=file.path("Results/Datasets",basename(i)),
      overwrite=TRUE)
    
  }
  
}

###############################################################
# Copy Graphs
###############################################################

graph_folder <- "Module5_Evaluation/graphs"

if(dir.exists(graph_folder)){
  
  graphs <- list.files(
    graph_folder,
    pattern="\\.png$",
    full.names=TRUE)
  
  for(i in graphs){
    
    file.copy(
      from=i,
      to=file.path("Results/Graphs",basename(i)),
      overwrite=TRUE)
    
  }
  
}

###############################################################
# Copy CSV Tables
###############################################################

tables <- list.files(
  "Module5_Evaluation",
  pattern="\\.csv$",
  full.names=TRUE)

for(i in tables){
  
  file.copy(
    from=i,
    to=file.path("Results/Tables",basename(i)),
    overwrite=TRUE)
  
}

###############################################################
# Copy Statistical Results
###############################################################

statistics <- list.files(
  "Module5_Evaluation",
  pattern="\\.txt$",
  full.names=TRUE)

for(i in statistics){
  
  file.copy(
    from=i,
    to=file.path("Results/Statistics",basename(i)),
    overwrite=TRUE)
  
}

###############################################################
# Display Summary
###############################################################

cat("\n")

cat("Datasets Copied :",length(list.files("Results/Datasets")),"\n")

cat("Graphs Copied :",length(list.files("Results/Graphs")),"\n")

cat("Tables Copied :",length(list.files("Results/Tables")),"\n")

cat("Statistics Copied :",length(list.files("Results/Statistics")),"\n")

cat("\n")

cat("========================================\n")
cat("RESULTS GENERATED SUCCESSFULLY\n")
cat("========================================\n")