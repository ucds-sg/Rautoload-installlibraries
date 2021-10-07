## Functions to facilitate smooth installation of R packages
#list of packages required to run the script
packages <- c("ggplot2", "tidyverse","readxl")

#Install packages that are not installed
install.packages(setdiff(packages, rownames(installed.packages())))

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))
