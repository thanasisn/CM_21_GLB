#!/usr/bin/env Rscript
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic1 = Sys.time()


library(rmarkdown)
library(knitr)


setwd("/home/athan/CM_21_GLB/")


## environmental variables are killed by rm(ls) inside each script

OUTPUT_FORMAT = NULL

### html to keep md for language tool
### but will not have TOC


# system("/home/athan/Aerosols/BASH_help/update_data_from_sirena.sh")
#
# source("./CM21_P00_Read_LAP.R")
#
#
# render("./CM21_P01_Inspect_data.R",
#        output_format     = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")
#
# render("./CM21_P20_Import_Data_filtered.R",
#        output_format     = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")
#
# render("./CM21_P30_GHI_daily_filtered.R",
#        output_format     = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")
#
# render("./CM21_P40_missing_dark_reconstruction.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")
#
# render("./CM21_P50_GHI_dark_correction.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")
#
# render("./CM21_P60_GHI_Export_WRDC.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")

# render("./CM21_P70_GHI_Export_TOT.R",
#        output_format        = c("html_document", "pdf_document"),
#        params = list( CACHE = F ),
#        clean                = T  ,
#        output_dir           = "/home/athan/CM_21_GLB/REPORTS")



#### output only pdfs with TOC


system("/home/athan/Aerosols/BASH_help/update_data_from_sirena.sh")

source("./CM21_P00_Read_LAP.R")


render("./CM21_P01_Inspect_data.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")

render("./CM21_P20_Import_Data_filtered.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")

render("./CM21_P30_GHI_daily_filtered.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")

render("./CM21_P40_missing_dark_reconstruction.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")

render("./CM21_P50_GHI_dark_correction.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")

render("./CM21_P60_GHI_Export_WRDC.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")

render("./CM21_P70_GHI_Export_TOT.R",
       params = list( CACHE = F ),
       clean                = T  ,
       output_dir           = "/home/athan/CM_21_GLB/REPORTS")


