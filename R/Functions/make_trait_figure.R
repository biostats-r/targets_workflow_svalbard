#### TRAIT FIGURES ####

## Figure 1 trait mean ##
make_trait_mean_figure <- function(trait_results, traits){

  anova_text_trait <- fancy_trait_name_dictionary(trait_results) |>
    ungroup() |>
    filter(term != "(Intercept)") |>
    # make results pretty
    mutate(term = "Treatment",
           test = if_else(p.value <= 0.05, "**", "")) |>
    select(Trait, Trait_fancy, test)

  trait_mean_plot <- fancy_trait_name_dictionary(traits) %>%
    group_by(Trait_fancy) %>%
    mutate(y_max = max(Value), y_min = min(Value)) %>%
    # sort treatments
    mutate(Treatment = recode(Treatment, CTL = "Control", OTC = "Warming"))  %>%
    ggplot() +
    geom_boxplot(aes(x = Treatment, y = Value, fill = Treatment)) +
    #geom_text(aes(label = text, x = 1, y = Inf), vjust = 1.2, size = 3.5, color = "black",  data = anova_text_trait) +
    scale_fill_manual(values = c("darkgray", "red")) +
    #scale_y_continuous(expand = expansion(mult = c(0, 0.35))) +
    labs(y = "CWM trait value",
         x = "") +
    facet_wrap(~Trait_fancy, scales = "free_y", labeller = label_parsed) +
    theme(legend.position = "none")

}


make_density_figure <- function(traits){

  fancy_trait_name_dictionary(traits) |>
    mutate(Treatment = recode(Treatment, CTL = "Control", OTC = "Warming"))  %>%
    ggplot(aes(x = Value, fill = Treatment)) +
    geom_density(alpha = 0.5) +
    scale_fill_manual(values = c("darkgray", "red")) +
    facet_wrap(~Trait_fancy, scales = "free", labeller = label_parsed)

}




