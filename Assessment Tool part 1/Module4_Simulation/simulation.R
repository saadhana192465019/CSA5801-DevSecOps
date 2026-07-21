############################################################
# MODULE 4
# HYBRID ABM + DES SIMULATION
############################################################

library(ggplot2)

cat("Starting Module 4...\n")

############################################################
# Read Dataset
############################################################

dataset <- read.csv(
  "Module3_CTGAN/simulation_dataset.csv",
  stringsAsFactors = FALSE
)

cat("Dataset Loaded Successfully\n")

############################################################
# Initialize Simulation
############################################################

set.seed(123)

dataset$Agent_State <- "Healthy"

dataset$Simulation_Time <- 0

dataset$Recovery_Time <- NA

dataset$Propagation_Count <- 0

############################################################
# Select Initial Infected Devices
############################################################

initial_nodes <- sample(1:nrow(dataset),50)

dataset$Agent_State[initial_nodes] <- "Infected"

############################################################
# Simulation Loop
############################################################

for(time in 1:20){
  
  infected <- which(dataset$Agent_State=="Infected")
  
  for(i in infected){
    
    targets <- sample(1:nrow(dataset),5)
    
    for(j in targets){
      
      if(dataset$Agent_State[j]=="Healthy"){
        
        if(runif(1) < dataset$Attack_Probability[j]){
          
          dataset$Agent_State[j] <- "Infected"
          
          dataset$Simulation_Time[j] <- time
          
          dataset$Propagation_Count[j] <-
            dataset$Propagation_Count[j]+1
          
        }
        
      }
      
    }
    
  }
  
}

############################################################
# Recovery Event
############################################################

infected <- which(dataset$Agent_State=="Infected")

recover <- sample(
  infected,
  floor(length(infected)*0.40)
)

dataset$Agent_State[recover] <- "Recovered"

dataset$Recovery_Time[recover] <- sample(
  21:30,
  length(recover),
  replace=TRUE
)

############################################################
# Create Graph Folder
############################################################

if(!dir.exists("Module4_Simulation/graphs")){
  
  dir.create("Module4_Simulation/graphs")
  
}

############################################################
# Save Dataset
############################################################

write.csv(
  dataset,
  "Module4_Simulation/final_simulation.csv",
  row.names=FALSE
)

############################################################
# Summary
############################################################

summary_table <- data.frame(
  
  State=c("Healthy","Infected","Recovered"),
  
  Count=c(
    
    sum(dataset$Agent_State=="Healthy"),
    
    sum(dataset$Agent_State=="Infected"),
    
    sum(dataset$Agent_State=="Recovered")
    
  )
  
)

write.csv(
  
  summary_table,
  
  "Module4_Simulation/simulation_summary.csv",
  
  row.names=FALSE
  
)

############################################################
# Graph 1
############################################################

png(
  "Module4_Simulation/graphs/Agent_State.png",
  800,
  600
)

barplot(
  table(dataset$Agent_State),
  col=c("green","red","blue"),
  main="Agent State"
)

dev.off()

############################################################
# Graph 2
############################################################

png(
  "Module4_Simulation/graphs/Propagation.png",
  800,
  600
)

hist(
  dataset$Propagation_Count,
  col="orange",
  main="Propagation Count"
)

dev.off()

############################################################
# Graph 3
############################################################

png(
  "Module4_Simulation/graphs/Recovery_Time.png",
  800,
  600
)

hist(
  na.omit(dataset$Recovery_Time),
  col="steelblue",
  main="Recovery Time"
)

dev.off()

############################################################
# Graph 4
############################################################

png(
  "Module4_Simulation/graphs/Attack_Probability.png",
  800,
  600
)

hist(
  dataset$Attack_Probability,
  col="tomato",
  main="Attack Probability"
)

dev.off()

############################################################
# Finish
############################################################

cat("\n")
cat("====================================\n")
cat("MODULE 4 COMPLETED SUCCESSFULLY\n")
cat("====================================\n")