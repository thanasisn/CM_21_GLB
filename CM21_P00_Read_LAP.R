#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'
#' Read text files with CM_21 data
#'   - from Sirena
#'   - from Radmon
#' Store as a binary file for further use
#'


closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM_P00")


source("/home/athan/CM_21_GLB/DEFINITIONS.R")

