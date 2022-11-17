##########################
#### targets pipeline ####
##########################

# Import data
targets_pipeline <- list(

  # trait data
  tar_target(
    name = traits_raw,
    command = "data/PFTC4_Svalbard_2018_ITEX_Traits.csv",
    format = "file"
  ),

  #import trait data
  tar_target(
    name = traits,
    command = read_csv(file = traits_raw) |>
      # only use Dryas heath
      filter(Site == "DH") |>
      # remove NP ratio from data. Not part of original analysis
      filter(Trait %in% c("Dry_Mass_g", "Leaf_Area_cm2", "LDMC", "SLA_cm2_g", "Leaf_Thickness_mm", "Plant_Height_cm")) |>
      filter(!is.na(Value))
  ),

  # make figure
  # trait mean figure
  tar_target(
    name = trait_mean_figure,
    command = make_trait_mean_figure(trait_results, traits)
  ),

  # analysis
  # trait analysis
  tar_target(
    name = trait_results,
    command = traits  |>
      # run model for treatment by site
      group_by(Trait) |>
      nest(data = -Trait) |>
      mutate(fit = map(data, ~ lm(Value ~ Treatment, data = .x))) |>
      # tidy results
      mutate(tidy_result = map(fit, tidy)) |>
      select(Trait, tidy_result) |>
      unnest(tidy_result)
  ),

  #render manuscript
  tar_quarto(name = ms, path = "manuscript/manuscript.qmd")

)
