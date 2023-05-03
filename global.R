library(magrittr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(grid)
library(markdown)

# Source helper functions ---
source("helpers.R") 

# Load Data
nba_data <- load_nba_data("data/all_data.csv")