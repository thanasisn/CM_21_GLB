#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'
#' Read text files with CM_21 data
#'   - from Sirena
#'   - from Radmon
#' Store as a binary file for further use
#'


####  Set environment  ####
closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM_P00")

####  . . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")





####  Data input  ####

sirena_files <- list.files( path        = SIRENA_DIR,
                            recursive   = TRUE,
                            pattern     = "[0-9]*06.LAP",
                            ignore.case = TRUE,
                            full.names  = TRUE )
cat(paste(length(sirena_files), "files from Sirena\n"))


radmon_files <- list.files( path        = RADMON_DIR,
                            recursive   = TRUE,
                            pattern     = "[0-9]*06.LAP",
                            ignore.case = TRUE,
                            full.names  = TRUE )
cat(paste(length(radmon_files), "files from Radmon\n"))


sir_names <- basename(sirena_files)
rad_names <- basename(radmon_files)

# sir_names[ ! sir_names %in% rad_names]

