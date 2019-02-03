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


### Read sourse data

# source("./CM21_P00_Read_LAP.R")
#
#
# render("./CM21_P01_Inspect_data.R",
#        output_format     = NULL,
#        clean             = F )
#
# render("./CM21_P20_Import_Data_filtered.R",
#        output_format     = NULL,
#        clean             = F )

render("./CM21_P30_GHI_daily_filtered.R",
       output_format     = NULL,
       clean             = F )

render("./CM21_P40_missing_dark_reconstruction.R",
       output_format     = NULL,
       clean             = F )


# render(run_script,
#        output_format     = "html_document",
#        clean             = T )

# render(run_script,
#        output_format     = "pdf_document",
#        clean             = T )





