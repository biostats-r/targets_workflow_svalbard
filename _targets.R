# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed. # nolint

# Set target options:
tar_option_set(
  packages = c("tidyverse"), # packages that your targets need to run
  #format = "rds" # default storage format
  # Set other options as needed.
)

# tar_make_clustermq() configuration (okay to leave alone):
options(clustermq.scheduler = "multicore")

# tar_make_future() configuration (okay to leave alone):
# Install packages {{future}}, {{future.callr}}, and {{future.batchtools}} to allow use_targets() to configure tar_make_future() options.

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# source("other_functions.R") # Source other scripts as needed. # nolint

# Replace the target list below with your own:
# target list
list(
  # data file
  tar_target(name = file,
             command = "data/PFTC4_Svalbard_2018_ITEX_Traits.csv",
             format = "file"),

  # import and transform
  tar_target(
    name = bistorta_height,
    command = get_file(file)
  ),
  # fit model for plant height
  tar_target(
    name = model,
    command = fit_model(bistorta_height)
  ),
  # make figure
  tar_target(
    name = figure,
    command = make_figure(bistorta_height)
  ),
  # render manuscript
  tar_quarto(name = ms, path = "svalbard_traits_targets.qmd")
)
