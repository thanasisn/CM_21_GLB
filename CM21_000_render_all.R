#!/usr/bin/env Rscript
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic1 = Sys.time()
Script.Name = funr::sys.script()


library(rmarkdown)
library(knitr)


setwd("~/CM_21_GLB/")


## environmental variables are killed by rm(ls) inside each script

OUTPUT_FORMAT = NULL


## 1 update raw data ####
# system("~/Aerosols/BASH_help/update_data_from_sirena.sh")


## 2 read data into R
# source("./CM21_P00_Read_LAP.R")




### html to keep md for language tool
### but will not have TOC

#
# render("./CM21_P01_Inspect_data.R",
#        output_format     = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")
#
# render("./CM21_P20_Import_Data_filtered.R",
#        output_format     = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")
#
# render("./CM21_P30_GHI_daily_filtered.R",
#        output_format     = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")
#
# render("./CM21_P40_missing_dark_reconstruction.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")
#
# render("./CM21_P50_GHI_dark_correction.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")
#
# render("./CM21_P60_GHI_Export_WRDC.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")

# render("./CM21_P70_GHI_Export_TOT.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "~/CM_21_GLB/REPORTS")






#### output only pdfs with TOC

render("./CM21_P01_Inspect_data.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

render("./CM21_P20_Import_Data_filtered.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

render("./CM21_P30_GHI_daily_filtered.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

render("./CM21_P40_missing_dark_reconstruction.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "~/CM_21_GLB/REPORTS")

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
