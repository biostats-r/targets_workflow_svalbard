FROM rocker/rstudio:latest

# Install desired R packages using rocker helper script.
RUN install2.r --error \
    tidyverse \
    gt \
    usethis \
    quarto \
    targets \
    here

