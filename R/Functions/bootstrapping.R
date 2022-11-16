#### TRAIT DATA ANALYSIS ####

#### TRAIT BOOTSTRAPPING ####

make_bootstrapping <- function(community, traits){

  #prepare community data
  comm <- community %>%
    filter(Year == 2015)

  #prepare trait data
  trait <- traits %>%
    select(Treatment, Site, PlotID, Taxon, Trait, Value)


  #set seed for bootstrapping repeatability
  set.seed(2525)
  trait_imp <- trait_impute(comm = comm,
                            traits = trait,
                            scale_hierarchy = c("Treatment", "PlotID"),
                            global = F,
                            taxon_col = "Taxon",
                            trait_col = "Trait",
                            value_col = "Value",
                            abundance_col = "Abundance",
                            min_n_in_sample = 2
  )

  #do the bootstrapping
  CWM <- trait_np_bootstrap(trait_imp, nrep = 100, sample_size = 200)

  CWM_mean <- trait_summarise_boot_moments(CWM) %>%
    select(Treatment:mean)

  #prepare bootstrapped trait data for analyses
  trait_mean <- CWM_mean %>%
    ungroup()

}

