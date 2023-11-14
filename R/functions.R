# My custom functions

# clean and prepare data for analysis


# fit linear regression
fit_model <- function(data, response, predictor){
  mod <- lm(as.formula(paste(response, "~", predictor)), data = data)
  mod
}

# make a figure
