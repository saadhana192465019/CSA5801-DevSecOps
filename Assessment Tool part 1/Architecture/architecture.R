library(DiagrammeR)

grViz("

digraph CyberThreatProject {

graph [
layout = dot,
rankdir = TB,
fontsize = 16,
labelloc = t,
label = 'AI Cyber Threat Simulation Architecture'
]

node [
shape = rectangle,
style = filled,
fillcolor = LightSkyBlue,
color = navy,
fontname = Helvetica,
fontsize = 12,
width = 3,
height = 0.8
]

edge [
color = black,
penwidth = 2,
arrowsize = 0.8
]

A [label='Module 1\n\nDataset Generation\n\n• Device Data\n• Threat Data\n• Attack Data']

B [label='Module 2\n\nData Preprocessing\n\n• Cleaning\n• Encoding\n• Normalization']

C [label='Module 3\n\nCyber Threat Generation\n\n• Attack Probability\n• Risk Score\n• Threat Severity']

D [label='Module 4\n\nHybrid Simulation\n\n• Agent Based Model (ABM)\n• Discrete Event Simulation (DES)\n• Threat Propagation']

E [label='Module 5\n\nEvaluation\n\n• Accuracy\n• Precision\n• Recall\n• F1 Score\n• Statistical Tests']

F [label='Results\n\n• CSV Files\n• Graphs\n• Statistics',
fillcolor='PaleGreen']

G [label='Final Report\n\n• Architecture\n• Analysis\n• Conclusion',
fillcolor='Khaki']

A -> B
B -> C
C -> D
D -> E
E -> F
F -> G

}
")
source("Architecture/architecture.R")
