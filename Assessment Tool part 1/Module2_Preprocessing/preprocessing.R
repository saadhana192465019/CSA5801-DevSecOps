############################################################
# MODULE 2 : DATA PREPROCESSING
# Project : AI-Based Cyber Threat Propagation Simulation
############################################################

###############################
# Load Library
###############################

library(ggplot2)

###############################
# Read Dataset
###############################

dataset <- read.csv(
  "Module1_Dataset/synthetic_dataset.csv",
  stringsAsFactors = FALSE
)

cat("Dataset Loaded Successfully!\n")

###############################
# View Dataset
###############################

head(dataset)

str(dataset)

summary(dataset)

cat("\nNumber of Rows :", nrow(dataset), "\n")
cat("Number of Columns :", ncol(dataset), "\n")

###############################
# Check Missing Values
###############################

missing_values <- colSums(is.na(dataset))

print(missing_values)

###############################
# Remove Duplicate Records
###############################

dataset <- unique(dataset)

cat("\nDuplicate Records Removed\n")

###############################
# Encode Categorical Variables
###############################

dataset$Device_Type <- as.numeric(as.factor(dataset$Device_Type))

dataset$Operating_System <- as.numeric(as.factor(dataset$Operating_System))

dataset$Department <- as.numeric(as.factor(dataset$Department))

dataset$Vulnerability <- as.numeric(as.factor(dataset$Vulnerability))

dataset$Threat <- as.numeric(as.factor(dataset$Threat))

dataset$Attack <- as.numeric(as.factor(dataset$Attack))

dataset$Patch_Level <- as.numeric(as.factor(dataset$Patch_Level))

dataset$Firewall <- as.numeric(as.factor(dataset$Firewall))

dataset$Antivirus <- as.numeric(as.factor(dataset$Antivirus))

dataset$Compromised <- as.numeric(as.factor(dataset$Compromised))

cat("Categorical Encoding Completed\n")

###############################
# Normalize Numeric Variables
###############################

normalize <- function(x){
  (x-min(x))/(max(x)-min(x))
}

dataset$CPU_Usage <- normalize(dataset$CPU_Usage)

dataset$Memory_Usage <- normalize(dataset$Memory_Usage)

dataset$Network_Traffic <- normalize(dataset$Network_Traffic)

dataset$Failed_Logins <- normalize(dataset$Failed_Logins)

dataset$Open_Ports <- normalize(dataset$Open_Ports)

dataset$User_Behaviour_Score <- normalize(dataset$User_Behaviour_Score)

dataset$Risk_Score <- normalize(dataset$Risk_Score)

cat("Normalization Completed\n")

###############################
# Train Test Split
###############################

set.seed(123)

train_index <- sample(
  1:nrow(dataset),
  size = 0.70*nrow(dataset)
)

train_data <- dataset[train_index, ]

test_data <- dataset[-train_index, ]

cat("\nTraining Records :", nrow(train_data), "\n")
cat("Testing Records :", nrow(test_data), "\n")

###############################
# Correlation Matrix
###############################

numeric_data <- dataset[sapply(dataset,is.numeric)]

cor_matrix <- cor(numeric_data)

write.csv(
  cor_matrix,
  "Module2_Preprocessing/correlation_matrix.csv",
  row.names = TRUE
)

###############################
# Save Processed Dataset
###############################

write.csv(
  dataset,
  "Module2_Preprocessing/processed_dataset.csv",
  row.names = FALSE
)

write.csv(
  train_data,
  "Module2_Preprocessing/train_data.csv",
  row.names = FALSE
)

write.csv(
  test_data,
  "Module2_Preprocessing/test_data.csv",
  row.names = FALSE
)

###############################
# Create Graph Folder
###############################

if(!dir.exists("Module2_Preprocessing/graphs")){
  dir.create("Module2_Preprocessing/graphs")
}

###############################
# Histogram
###############################

png("Module2_Preprocessing/graphs/Risk_Histogram.png",
    width=800,height=600)

hist(dataset$Risk_Score,
     main="Risk Score Distribution",
     xlab="Risk Score",
     col="lightblue")

dev.off()

###############################
# Boxplot
###############################

png("Module2_Preprocessing/graphs/Risk_Boxplot.png",
    width=800,height=600)

boxplot(dataset$Risk_Score,
        main="Risk Score",
        col="lightgreen")

dev.off()

###############################
# Threat Distribution
###############################

png("Module2_Preprocessing/graphs/Threat_Distribution.png",
    width=800,height=600)

barplot(table(dataset$Threat),
        main="Threat Distribution",
        col="orange")

dev.off()

###############################
# Attack Distribution
###############################

png("Module2_Preprocessing/graphs/Attack_Distribution.png",
    width=800,height=600)

barplot(table(dataset$Attack),
        main="Attack Distribution",
        col="tomato")

dev.off()

###############################
# Summary Statistics
###############################

summary_table <- data.frame(
  
  Statistic = c(
    "Mean Risk Score",
    "SD Risk Score",
    "Mean CPU Usage",
    "Mean Memory Usage"
  ),
  
  Value = c(
    mean(dataset$Risk_Score),
    sd(dataset$Risk_Score),
    mean(dataset$CPU_Usage),
    mean(dataset$Memory_Usage)
  )
  
)

write.csv(
  summary_table,
  "Module2_Preprocessing/summary_table.csv",
  row.names=FALSE
)

cat("\n=====================================\n")
cat("MODULE 2 COMPLETED SUCCESSFULLY\n")
cat("=====================================\n")

cat("\nFiles Created:\n")

cat("processed_dataset.csv\n")
cat("train_data.csv\n")
cat("test_data.csv\n")
cat("correlation_matrix.csv\n")
cat("summary_table.csv\n")

cat("\nGraphs Saved Successfully!\n")