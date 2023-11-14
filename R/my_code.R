### Script to test how marine nutrients affect leaf area in Alopecurus magellanicus

# load libraries
library(tidyverse)
library(here)
library(performance)

# import data
raw_traits <- read_delim(file = here("data/PFTC4_Svalbard_2018_Gradient_Traits.csv"))

# clean data and prepare for analysis
traits <- raw_traits |>
  # remove NAs
  filter(!is.na(Value)) |>
  # order factor and rename variable gradient
  mutate(Gradient = case_match(Gradient,
                               "C" ~ "Control",
                               "B" ~ "Nutrients"),
         Gradient = factor(Gradient, levels = c("Control", "Nutrients"))) |>
  # select one species and one trait
  filter(Taxon == "alopecurus magellanicus",
         Trait == "Leaf_Area_cm2")

# run a linear model
mod_area <- lm(Value ~ Gradient, data = traits)
summary(mod_area)
# check model assumptions
check_model(mod_area)

# make figure
ggplot(traits, aes(x = Gradient, y = Value)) +
  geom_boxplot(fill = c("grey80", "darkgreen")) +
  labs(x = "", y = expression(Leaf~area~cm^2)) +
  theme_bw()
