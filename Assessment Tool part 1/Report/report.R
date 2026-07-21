############################################################
# REPORT GENERATION
############################################################

cat("=====================================\n")
cat("GENERATING PROJECT REPORT\n")
cat("=====================================\n")

############################################################
# Create Report Folders
############################################################

dir.create("Report/Tables", showWarnings = FALSE, recursive = TRUE)
dir.create("Report/Figures", showWarnings = FALSE, recursive = TRUE)
dir.create("Report/Final_Report", showWarnings = FALSE, recursive = TRUE)

############################################################
# Copy Tables
############################################################

table_files <- list.files(
  "Results/Tables",
  full.names = TRUE
)

for(i in table_files){
  
  file.copy(
    i,
    file.path("Report/Tables", basename(i)),
    overwrite = TRUE)
  
}

############################################################
# Copy Graphs
############################################################

graph_files <- list.files(
  "Results/Graphs",
  full.names=TRUE)

for(i in graph_files){
  
  file.copy(
    i,
    file.path("Report/Figures",basename(i)),
    overwrite=TRUE)
  
}

############################################################
# Create Report Summary
############################################################

dataset <- read.csv(
  "Module4_Simulation/final_simulation.csv"
)

sink("Report/Final_Report/Project_Report.txt")

cat("CYBER THREAT PROPAGATION PROJECT\n\n")

cat("====================================\n")
cat("DATASET SUMMARY\n")
cat("====================================\n")

cat("Total Devices :",nrow(dataset),"\n")
cat("Total Variables :",ncol(dataset),"\n\n")

cat("====================================\n")
cat("DEVICE STATE\n")
cat("====================================\n")

print(table(dataset$Agent_State))

cat("\n")

cat("====================================\n")
cat("THREAT DISTRIBUTION\n")
cat("====================================\n")

print(table(dataset$Threat))

cat("\n")

cat("====================================\n")
cat("ATTACK RESULT\n")
cat("====================================\n")

print(table(dataset$Attack_Result))

cat("\n")

cat("====================================\n")
cat("STATISTICS\n")
cat("====================================\n")

cat("Mean Risk Score :",mean(dataset$Risk_Score),"\n")
cat("SD Risk Score :",sd(dataset$Risk_Score),"\n")

cat("Mean CPU Usage :",mean(dataset$CPU_Usage),"\n")
cat("Mean Memory Usage :",mean(dataset$Memory_Usage),"\n")
cat("Mean Attack Probability :",mean(dataset$Attack_Probability),"\n")

sink()

############################################################
# Finish
############################################################

cat("\n=====================================\n")
cat("REPORT GENERATED SUCCESSFULLY\n")
cat("=====================================\n")