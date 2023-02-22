#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisphysicist@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()


## TODO 
## similar to inspect_days_Lap.R
## read from rds files
## select to plot SNG, S0, S1, L1, L2


library(data.table, quietly = T, warn.conflicts = F)
library(optparse,   quietly = T, warn.conflicts = F)
library(plotly,     quietly = T, warn.conflicts = F)


