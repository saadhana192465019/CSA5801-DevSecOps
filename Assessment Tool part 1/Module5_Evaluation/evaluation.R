############################################################
# MODULE 5
# PERFORMANCE EVALUATION
############################################################

library(ggplot2)

cat("Starting Evaluation Module...\n")
############################################################
# Read Final Simulation Dataset
############################################################

dataset <- read.csv(
  "Module4_Simulation/final_simulation.csv",
  stringsAsFactors = FALSE
)

cat("Simulation Dataset Loaded Successfully\n")
############################################################
# Dataset Summary
############################################################

summary(dataset)

str(dataset)

dim(dataset)
if(!dir.exists("Module5_Evaluation/graphs")){
  
  dir.create("Module5_Evaluation/graphs")
  
}
agent_state <- as.data.frame(table(dataset$Agent_State))

colnames(agent_state) <- c("State","Count")

write.csv(
  agent_state,
  "Module5_Evaluation/agent_state_distribution.csv",
  row.names=FALSE
)

print(agent_state)
threat_distribution <- as.data.frame(table(dataset$Threat))

colnames(threat_distribution) <- c("Threat","Count")

write.csv(
  threat_distribution,
  "Module5_Evaluation/threat_distribution.csv",
  row.names=FALSE
)
attack_result <- as.data.frame(table(dataset$Attack_Result))

colnames(attack_result) <- c("Attack_Result","Count")

write.csv(
  attack_result,
  "Module5_Evaluation/attack_result.csv",
  row.names=FALSE
)
infection <- as.data.frame(table(dataset$Infection_Level))

colnames(infection) <- c("Level","Count")

write.csv(
  infection,
  "Module5_Evaluation/infection_level.csv",
  row.names=FALSE
)
severity <- as.data.frame(table(dataset$Threat_Severity))

colnames(severity) <- c("Severity","Count")

write.csv(
  severity,
  "Module5_Evaluation/threat_severity.csv",
  row.names=FALSE
)
statistics <- data.frame(
  
  Metric=c(
    
    "Mean Risk Score",
    
    "SD Risk Score",
    
    "Mean CPU Usage",
    
    "Mean Memory Usage",
    
    "Mean Attack Probability"
    
  ),
  
  Value=c(
    
    mean(dataset$Risk_Score),
    
    sd(dataset$Risk_Score),
    
    mean(dataset$CPU_Usage),
    
    mean(dataset$Memory_Usage),
    
    mean(dataset$Attack_Probability)
    
  )
  
)

write.csv(
  
  statistics,
  
  "Module5_Evaluation/statistics.csv",
  
  row.names=FALSE
  
)
numeric_data <- dataset[sapply(dataset,is.numeric)]

correlation <- cor(numeric_data)

write.csv(
  
  correlation,
  
  "Module5_Evaluation/correlation_matrix.csv"
  
)
chi <- chisq.test(
  
  table(
    
    dataset$Threat,
    
    dataset$Attack_Result
    
  )
  
)

capture.output(
  
  chi,
  
  file="Module5_Evaluation/chisquare.txt"
  
)
anova_model <- aov(
  
  Risk_Score~Threat_Severity,
  
  data=dataset
  
)

capture.output(
  
  summary(anova_model),
  
  file="Module5_Evaluation/anova.txt"
  
)
ttest <- t.test(
  
  dataset$CPU_Usage,
  
  dataset$Memory_Usage
  
)

capture.output(
  
  ttest,
  
  file="Module5_Evaluation/ttest.txt"
  
)
png("Module5_Evaluation/graphs/Agent_State.png",800,600)

barplot(
  
  table(dataset$Agent_State),
  
  col=c("green","red","blue"),
  
  main="Agent State Distribution"
  
)

dev.off()
png("Module5_Evaluation/graphs/Threat_Distribution.png",800,600)

barplot(
  
  table(dataset$Threat),
  
  col="orange",
  
  main="Threat Distribution"
  
)

dev.off()
png("Module5_Evaluation/graphs/Attack_Result.png",800,600)

barplot(
  
  table(dataset$Attack_Result),
  
  col=c("steelblue","tomato"),
  
  main="Attack Result"
  
)

dev.off()
png("Module5_Evaluation/graphs/Infection_Level.png",800,600)

barplot(
  
  table(dataset$Infection_Level),
  
  col="purple",
  
  main="Infection Level"
  
)

dev.off()
png("Module5_Evaluation/graphs/Risk_Score.png",800,600)

hist(
  
  dataset$Risk_Score,
  
  col="skyblue",
  
  main="Risk Score Distribution"
  
)

dev.off()
summary_report <- data.frame(
  
  Evaluation=c(
    
    "Total Devices",
    
    "Healthy",
    
    "Infected",
    
    "Recovered",
    
    "Average Risk Score",
    
    "Average Attack Probability"
    
  ),
  
  Value=c(
    
    nrow(dataset),
    
    sum(dataset$Agent_State=="Healthy"),
    
    sum(dataset$Agent_State=="Infected"),
    
    sum(dataset$Agent_State=="Recovered"),
    
    mean(dataset$Risk_Score),
    
    mean(dataset$Attack_Probability)
    
  )
  
)

write.csv(
  
  summary_report,
  
  "Module5_Evaluation/final_report.csv",
  
  row.names=FALSE
  
)

cat("\n=====================================\n")
cat("MODULE 5 COMPLETED SUCCESSFULLY\n")
cat("=====================================\n")