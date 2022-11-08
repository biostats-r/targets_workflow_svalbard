#rename traits to fancy names for figures

fancy_trait_name_dictionary <- function(dat){

  dat <- dat %>%

    # rename
   mutate(Trait = factor(Trait,
                         levels = c("Plant_Height_cm", "Dry_Mass_g", "Leaf_Area_cm2", "SLA_cm2_g", "Leaf_Thickness_mm", "LDMC")),
          Trait_fancy = fct_recode(Trait,
                          "SLA~(cm^2*g^{-1})" = "SLA_cm2_g",
                          "LDMC~(gg^{-1})" = "LDMC",
                          "Leaf~Area~(cm^2)" = "Leaf_Area_cm2",
                          "Leaf~Thickness~(mm)" = "Leaf_Thickness_mm",
                          "Dry~Mass~(g)" = "Dry_Mass_g",
                          "Plant~Height~(cm)" = "Plant_Height_cm")
          )


  return(dat)
}

