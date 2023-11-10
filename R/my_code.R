### Script to test how warming affects plant height in Bistorta vivipara.

# load libraries
library(tidyverse)
library(here)
library(performance)

# import data
raw_traits <- read_delim(file = here("data/PFTC4_Svalbard_2018_Gradient_Traits.csv"))

# data cleaning
traits <- raw_traits |>
  # remove NAs
  filter(!is.na(Value)) |>
  # order factor and rename variable gradient
  mutate(Gradient = case_match(Gradient,
                               "C" ~ "Control",
                               "B" ~ "Nutrients"),
         Gradient = factor(Gradient, levels = c("Control", "Nutrients")))

# prepare data for analysis and filter bistorta species and plant height
bistorta <- traits |>
  filter(Taxon == "alopecurus magellanicus",
         Trait == "Leaf_Area_cm2")

# run a linear model
mod_height <- lm(Value ~ Gradient, data = bistorta)
summary(mod_height)
# check model assumptions
check_model(mod_height)

# plot treatments vs plant height
ggplot(bistorta, aes(x = Gradient, y = Value)) +
  geom_boxplot(fill = c("grey80", "darkgreen")) +
  labs(x = "", y = "Plant height (cm)") +
  theme_bw()
