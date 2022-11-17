#######################
### targets file ###
#######################

#### LOAD LIBRARIES ####
library(targets)
library(tarchetypes)
tar_option_set(packages = c("tidyverse", "broom"))


### SOURCE CODE ####
# Functions
source("R/Functions/make_trait_figure.R")
source("R/Functions/fancy_traits.R")


### MAKE PIPELINE ####
# source plans
source("R/targets_pipeline.R")

