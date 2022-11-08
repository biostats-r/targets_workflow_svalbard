#### TRAIT DATA ANALYSIS ####

#### TRAIT BOOTSTRAPPING ####

make_bootstrapping <- function(community, traits){

  #prepare community data
  comm <- community %>%
    filter(Year == 2015) %>%
    mutate(Site_trt = paste0(Site, Treatment))

  #prepare trait data
  trait <- traits %>%
    select(Treatment, Site, PlotID, Taxon, Trait, Value) %>%
    mutate(Site_trt = paste0(Site, Treatment))


  #set seed for bootstrapping repeatability
  set.seed(2525)
  trait_imp <- trait_impute(comm = comm,
                            traits = trait,
                            scale_hierarchy = c("Site", "Site_trt", "PlotID"),
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
    select(Site:mean)

  #prepare bootstrapped trait data for analyses
  trait_mean <- CWM_mean %>% ungroup() %>%
    mutate(Trait = plyr::mapvalues(Trait, from = c("P_percent", "dC13_permil", "dN15_permil"), to = c("P_Ave", "dC13_percent", "dN15_percent"))) %>%
    mutate(Treatment = substr(Site_trt, 3, 6)) %>%
    mutate(Site = factor(Site, levels = c("SB", "CH", "DH")))

}

