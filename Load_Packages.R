  ######################################################################################################################
## R Version 3.4.4
## This file downloads, installs or updates required libraries based on R version given above 
## Author: Utkarsh Chaturvedi
## General Instruction: If prompted to restart R during installation, say 'NO' and wait for all the packages to install
######################################################################################################################

## 1st time USE only (next section can be used anywhere)

#### Installing and loading packages ####

#updating rlang package to the latest one - necessary for devtools below
install.packages("rlang", type = 'source')
library(rlang)

# Devtools is necessary - download and install Rtools35 here (https://cran.r-project.org/bin/windows/Rtools/history.html)

install.packages('devtools', type = 'binary')
library(devtools)

# Since We are working on R3.4.x; older versions of some packages are required (e.g. ROCR, Lattice etc. - these will require Rtools)
devtools::install_github('goldingn/versions')
library(versions)

###########################################################################################################################

# The function below checks for the list of packages, simply loading them if they are present or downloading them if they are not

#Old_packages <- old.packages(checkBuilt = T)
#Old_packages <- Old_packages


listOfPackages <- c("versions",
                    #"devtools",                       
                    "tibble",
                    "zoo",
                    "xts",
                    "TTR",
                    "rticles",
                    "plyr",
                    "reshape",
                    "quantmod",
                    "nnet",
                    "matrixStats",
                    "lubridate",
                    "recipes",
                    "tseries",
                    "ggplot2",
                    "urca",
                    "tree",
                    "forecast",
                    "fpp",
                    "caret",
                    "timeSeries",
                    "randomForest",
                    "gbm",
                    "e1071",
                    "prophet",
                    "MLmetrics",
                    "dplyr",
                    "numbers",
                    "gtools",
                    "assertive",
                    "Hmisc",
                    "rccdates",
                    'reshape2', 'rccdates', 'trend', 
                    'DescTools', 'tcltk')

VersionControlPackages <- function(package){  
  
  ## load the package based on it's dependency of R 3.4
  ## @param package: package name
  
  tryCatch({
  install.packages(package, dependencies = T ,type = 'binary') #Install the latest version of the package, if dependency criteria is met 
  library(package, character.only = T)
  message("Using an older version as latest is not compatiable")
}, error = function(cond) {
  install.dates(package, dates = '2020-01-01', type = 'binary') #for R3.6 was released # Set it to '2020-01-01' if using R3.6.0 or '2019-04-26' if using R3.4.4
  library(package, character.only = T)
}
)}

loadPackages <- lapply(listOfPackages, function(x){  
  
  ## upgrade old packages if necessary
  ## @param pkg: character vector containing library names
  
  l <- require(x, character.only = T)
 #print(l)
  if(l){
    tryCatch({ #introduced so that if there is any package being detached which has dependency on another package, it will NOT detach it
      detach_obj <- paste("package",x, sep = ":")
      detach(detach_obj, unload = T, character.only = T)
      update.packages(checkBuilt = T,ask = FALSE,  oldPkgs = x , type = 'binary', dependencies = T) #update the package if a newer version is present
      message("Package updated")
    }, error = function(e){
      message("Unable to detach package or error while updating!")
      return(NULL)
    })
    library(x,  character.only = T)
  }
  if(!l){
    VersionControlPackages(x)
  }
  return(l)
})

#install.packages("forecast", dependencies = T)
