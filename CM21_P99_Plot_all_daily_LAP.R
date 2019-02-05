#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'
#' Read text files with CM_21 signal data
#'


####  Set environment  ####
closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_099")


library(data.table)


####  . . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")





####  Files for import  ####

sirena_files <- list.files( path        = SIRENA_DIR,
                            recursive   = TRUE,
                            pattern     = "[0-9]*06.LAP$",
                            ignore.case = TRUE,
                            full.names  = TRUE )
cat(paste(length(sirena_files), "files from Sirena\n"))



## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %10s %10s %25s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
