#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()


library(data.table, quietly = T, warn.conflicts = F)



## Get shell arguments
args <- commandArgs( trailingOnly = TRUE )
## override test from shell
if ( length(args) > 0 ) {
    # if ( any(args == "NOTEST") ) { TEST      = FALSE }
    if ( any(args == "NOTALL") ) { ALL_YEARS = FALSE }
}


