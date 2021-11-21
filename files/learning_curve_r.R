library(tidyverse)

spss_curve <- function(x) sqrt(x*200)
r_curve <- function(x) sqrt(x*30)

ggplot(data = data.frame(x = 0), mapping = aes(x = x)) + 
  stat_function(fun = spss_curve, aes(color = "SPSS"), size = 1.5) +
  stat_function(fun = r_curve, aes(color = "R"), size = 1.5) +
  xlim(0, 100) +
  ylim(0, 100) +
  cowplot::theme_minimal_grid() +
  xlab("ORE TOTALI") +
  ylab("SKILLS") +
  theme(axis.text.x = element_blank(),
        legend.title = element_blank(),
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Apprendimento iniziale") -> learning_r_plot


after_spss <- function(x) sqrt(x*5)

ggplot(data = data.frame(x = 0), mapping = aes(x = x)) + 
  stat_function(fun = function(x) sqrt(x*150), aes(color = "After SPSS"), size = 1.5) +
  stat_function(fun = after_spss, aes(color = "After R"), size = 1.5) +
  xlim(0, 100) +
  ylim(0, 100) +
  cowplot::theme_minimal_grid() +
  xlab("ORE TOTALI") +
  ylab("SKILLS") +
  theme(axis.text.x = element_blank(),
        legend.title = element_blank(),
        aspect.ratio = 1,
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Apprendimento di altri linguaggi") -> after_r_plot
