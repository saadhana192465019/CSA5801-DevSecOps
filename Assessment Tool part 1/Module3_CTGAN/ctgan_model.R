############################################################
# MODULE 3
# CYBER ATTACK SIMULATION
############################################################

library(ggplot2)

############################################################
# Read Processed Dataset
############################################################

dataset <- read.csv(
  "Module2_Preprocessing/processed_dataset.csv",
  stringsAsFactors = FALSE
)

cat("Processed Dataset Loaded Successfully\n")

############################################################
# Set Seed
############################################################

set.seed(123)

############################################################
# Attack Probability
############################################################

dataset$Attack_Probability <-
  round(runif(nrow(dataset),0.2,0.95),2)

############################################################
# Simulate Attack Success
############################################################

dataset$Attack_Result <-
  ifelse(dataset$Attack_Probability>0.60,
         "Successful",
         "Blocked")

############################################################
# Simulate Infection Level
############################################################

dataset$Infection_Level <-
  sample(
    c("Low","Medium","High"),
    nrow(dataset),
    replace=TRUE,
    prob=c(0.4,0.35,0.25)
  )

############################################################
# Threat Severity
############################################################

dataset$Threat_Severity <-
  ifelse(
    dataset$Risk_Score>0.80,
    "Critical",
    ifelse(
      dataset$Risk_Score>0.60,
      "High",
      ifelse(
        dataset$Risk_Score>0.40,
        "Medium",
        "Low"
      )
    )
  )

############################################################
# Save Simulation Output
############################################################

write.csv(
  dataset,
  "Module3_CTGAN/simulation_dataset.csv",
  row.names=FALSE
)

cat("Simulation Dataset Saved Successfully\n")
############################################################
# Summary Statistics
############################################################

summary_table <- data.frame(
  
  Metric=c(
    
    "Successful Attacks",
    
    "Blocked Attacks",
    
    "Average Risk",
    
    "Average Attack Probability"
    
  ),
  
  Value=c(
    
    sum(dataset$Attack_Result=="Successful"),
    
    sum(dataset$Attack_Result=="Blocked"),
    
    mean(dataset$Risk_Score),
    
    mean(dataset$Attack_Probability)
    
  )
  
)

write.csv(
  
  summary_table,
  
  "Module3_CTGAN/simulation_summary.csv",
  
  row.names=FALSE
  
)
if(!dir.exists("Module3_CTGAN/graphs"))
  dir.create("Module3_CTGAN/graphs")
png(
  "Module3_CTGAN/graphs/Attack_Result.png",
  width=800,
  height=600
)

barplot(
  table(dataset$Attack_Result),
  col=c("green","red"),
  main="Attack Result"
)

dev.off()
png(
  "Module3_CTGAN/graphs/Threat_Severity.png",
  width=800,
  height=600
)

barplot(
  table(dataset$Threat_Severity),
  col="orange",
  main="Threat Severity"
)

dev.off()
png(
  "Module3_CTGAN/graphs/Infection_Level.png",
  width=800,
  height=600
)

barplot(
  table(dataset$Infection_Level),
  col="steelblue",
  main="Infection Level"
)

dev.off()
cat("\n====================================\n")
cat("MODULE 3 COMPLETED SUCCESSFULLY\n")
cat("====================================\n")