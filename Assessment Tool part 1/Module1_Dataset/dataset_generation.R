############################################################
# MODULE 1 : SYNTHETIC CYBERSECURITY DATASET GENERATION
# Project : AI-Based Cyber Threat Propagation Simulation
############################################################

# Load Packages
library(ggplot2)
library(writexl)

# Set Seed
set.seed(123)

# Number of Records
n <- 1000

############################################################
# Possible Values
############################################################

device_type <- c(
  "Laptop",
  "Desktop",
  "Server",
  "IoT Device"
)

operating_system <- c(
  "Windows",
  "Linux",
  "macOS",
  "Android"
)

department <- c(
  "HR",
  "Finance",
  "Admin",
  "IT",
  "Sales"
)

############################################################
# 10 Vulnerabilities
############################################################

vulnerability <- c(
  "Weak Password",
  "Unpatched Software",
  "SQL Injection",
  "Open Port",
  "Firewall Misconfiguration",
  "Outdated Antivirus",
  "Privilege Escalation",
  "Cross-Site Scripting",
  "Remote Code Execution",
  "Buffer Overflow"
)

############################################################
# 4 Threats
############################################################

threat <- c(
  "Malware",
  "Ransomware",
  "Insider Threat",
  "APT"
)

############################################################
# 3 Attack Types
############################################################

attack <- c(
  "Phishing",
  "Brute Force",
  "DDoS"
)

############################################################
# Create Dataset
############################################################

dataset <- data.frame(
  
  Device_ID = paste0("DEV", sprintf("%04d",1:n)),
  
  Device_Type = sample(device_type,n,replace=TRUE),
  
  Operating_System = sample(operating_system,n,replace=TRUE),
  
  Department = sample(department,n,replace=TRUE),
  
  Vulnerability = sample(vulnerability,n,replace=TRUE),
  
  Threat = sample(threat,n,replace=TRUE),
  
  Attack = sample(attack,n,replace=TRUE),
  
  CPU_Usage = round(runif(n,20,100),2),
  
  Memory_Usage = round(runif(n,15,98),2),
  
  Network_Traffic = round(runif(n,50,500),2),
  
  Failed_Logins = sample(0:20,n,replace=TRUE),
  
  Open_Ports = sample(1:25,n,replace=TRUE),
  
  Patch_Level = sample(c("Updated","Outdated"),n,replace=TRUE),
  
  Firewall = sample(c("Enabled","Disabled"),n,replace=TRUE),
  
  Antivirus = sample(c("Installed","Not Installed"),n,replace=TRUE),
  
  User_Behaviour_Score = round(runif(n,40,100),2),
  
  Risk_Score = sample(1:100,n,replace=TRUE),
  
  Compromised = sample(c("Yes","No"),n,replace=TRUE)
  
)

############################################################
# Display First Records
############################################################

head(dataset)

############################################################
# Display Structure
############################################################

str(dataset)

############################################################
# Display Summary
############################################################

summary(dataset)

############################################################
# Save Dataset
############################################################

write.csv(
  dataset,
  "Module1_Dataset/synthetic_dataset.csv",
  row.names=FALSE
)

############################################################
# Save Excel File
############################################################

write_xlsx(
  dataset,
  "Module1_Dataset/synthetic_dataset.xlsx"
)

cat("Dataset Generated Successfully!\n")
# =========================================================
# MODULE 1 - PART 2 : SUMMARY STATISTICS & GRAPHS
# Append this BELOW the previous code in dataset_generation.R
# =========================================================

# Create graphs folder if it does not exist
if (!dir.exists("Module1_Dataset/graphs")) {
  dir.create("Module1_Dataset/graphs", recursive = TRUE)
}

# -----------------------------
# Summary statistics
# -----------------------------
summary_table <- data.frame(
  Metric = c("Mean_Risk", "Median_Risk", "SD_Risk",
             "Min_Risk", "Max_Risk"),
  Value = c(
    mean(dataset$Risk_Score),
    median(dataset$Risk_Score),
    sd(dataset$Risk_Score),
    min(dataset$Risk_Score),
    max(dataset$Risk_Score)
  )
)

# Save summary table
write.csv(summary_table,
          "Module1_Dataset/summary_table.csv",
          row.names = FALSE)

# -----------------------------
# Graph 1: Threat Distribution
# -----------------------------
p1 <- ggplot(dataset, aes(x = Threat)) +
  geom_bar() +
  ggtitle("Threat Distribution")

ggsave("Module1_Dataset/graphs/Threat_Distribution.png",
       plot = p1, width = 6, height = 4)

# -----------------------------
# Graph 2: Attack Distribution
# -----------------------------
p2 <- ggplot(dataset, aes(x = Attack)) +
  geom_bar() +
  ggtitle("Attack Distribution")

ggsave("Module1_Dataset/graphs/Attack_Distribution.png",
       plot = p2, width = 6, height = 4)

# -----------------------------
# Graph 3: Risk Score Histogram
# -----------------------------
p3 <- ggplot(dataset, aes(x = Risk_Score)) +
  geom_histogram(binwidth = 10) +
  ggtitle("Risk Score Histogram")

ggsave("Module1_Dataset/graphs/Risk_Histogram.png",
       plot = p3, width = 6, height = 4)

# -----------------------------
# Graph 4: Risk Score Boxplot
# -----------------------------
p4 <- ggplot(dataset, aes(y = Risk_Score)) +
  geom_boxplot() +
  ggtitle("Risk Score Boxplot")

ggsave("Module1_Dataset/graphs/Risk_Boxplot.png",
       plot = p4, width = 4, height = 6)

cat("Summary table and graphs saved successfully!\n")