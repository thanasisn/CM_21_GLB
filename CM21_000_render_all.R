#!/usr/bin/env Rscript
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n")
                            return("CM21_000_") })

library(rmarkdown)
library(knitr)


setwd("~/CM_21_GLB/")


## environmental variables are killed by rm(ls) inside each script

OUTPUT_FORMAT = NULL


####  update raw data  ####
system("~/Aerosols/BASH_help/update_data_from_sirena.sh")



render("./CM21_R10_Read_raw_LAP.R",
       params = list( ALL_YEARS = TRUE ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS/REPORTS/")


render("./CM21_R20_Parse_Data.R",
       params = list( ALL_YEARS = TRUE ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS/REPORTS/")


render("./CM21_R30_Compute_dark.R",
       params = list(  ALL_YEARS = TRUE ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS/REPORTS/")


render("./CM21_R40_Missing_dark_construct.R",
       params = list(  ALL_YEARS = TRUE ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS/REPORTS/")


stop()



render("./CM21_P50_GHI_dark_correction.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

render("./CM21_P60_GHI_Export_WRDC.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

render("./CM21_P70_GHI_Export_TOT.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

render("./check_export_sirena.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_format        = NULL,
       output_dir           = "~/CM_21_GLB/REPORTS")




## some more nice plots

source("./CM21_P98_Plot_all_years_LAP.R")

source("./CM21_P99_Plot_all_daily_LAP.R")



cat(paste("\n\n IS YOU SEE THIS: \n", Script.Name," GOT TO THE END!! \n"))
cat(paste("\n EVERYTHING SHOULD BE FINE \n"))

## END ##
tac = Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
