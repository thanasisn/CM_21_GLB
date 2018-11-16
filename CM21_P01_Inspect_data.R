#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'



####  Set environment  ####
closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P01_Inspect_data.R")


library(data.table)


####  . . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")



signal_files <- list.files(path        = SIGNAL_DIR,
                           pattern     = "LAP_CM21H_SIG.*.rds$",
                           ignore.case = T,
                           full.names  = T)


all_data <- data.table()

for (ff in signal_files) {
   dyear <- readRDS(ff)
   yyyy = format(dyear$Date[1], "%Y")

   hist(dyear$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )
   hist(dyear$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )

   plot(dyear$Elevat, dyear$CM21value, pch = 19, cex=.8,main = paste("CM21 signal ", yyyy )  )
   plot(dyear$Elevat, dyear$CM21sd,    pch = 19, cex=.8,main = paste("CM21 signal SD", yyyy )  )


   break()
}





## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %10s %10s %25s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
