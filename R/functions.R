# My custom functions

# import and filter bistorta vivipara and the trait plant height
get_file <- function(file){
  dat <- read_csv(file) |>
    filter(Taxon == "bistorta vivipara",
           Trait == "Plant_Height_cm")
}

# fit lm
fit_model <- function(data){
  model <- lm(Value ~ Treatment, data = data)
  model
}

# make figure
make_figure <- function(data){
  ggplot(data, aes(x = Treatment, y = Value)) +
    geom_boxplot(fill = c("grey80", "red")) +
    labs(x = "Treatment", y = "Height cm")
}
