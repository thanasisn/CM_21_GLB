#!/usr/bin/env Rscript
# /* Copyright (C) 2019 Athanasios Natsis <natsisphysicist@gmail.com> */

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
system("./get_data_from_sirena.sh")


## render all in list
source_list <- c(
    # "./CM21_R10_Read_raw_LAP.R",                    ## Deprecated by BBand_LAP
    # "./CM21_R20_Parse_Data.R",                      ## Deprecated by BBand_LAP
    # "~/BBand_LAP/process/Legacy_CM21_R20_export.R", ## Deprecated by BBand_LAP can not render in R 4.0.4
    # "./CM21_R30_Compute_dark.R",                    ## Deprecated by BBand_LAP
    # "./CM21_R40_Missing_dark_construct.R",          ## Deprecated by BBand_LAP
    # "./CM21_R50_Signal_to_GHI.R",                   ## Deprecated by BBand_LAP
    "./CM21_R60_GHI_output.R",
    # "./CM21_T70_GHI_Export_WRDC.R",
    "./CM21_T71_GHI_Export_TOT.R",
    "./CM21_T80_check_sirena_export.R",
    "./CM21_T81_check_wrdc_output.R",
    NULL
)

cat("\n\nWill do:\n")
cat(source_list,sep = "\n")




for (as in source_list) {
    cat("\n\n===============================================================\n")
    cat(format(Sys.time()),"\n")
    cat("START:", as, "\n")

    render(as,
           params = list( ALL_YEARS = TRUE ),
           clean                = T  ,
           output_dir           = "~/CM_21_GLB/REPORTS/REPORTS/")

}


cat("Run manually to create the graphs if everything seems good:\n")
cat("./CM21_P98_Plot_all_years_LAP.R\n")
cat("./CM21_P99_Plot_all_daily_LAP.R\n")

# ## some more nice plots for sirena display
# source("./CM21_P98_Plot_all_years_LAP.R")
# source("./CM21_P99_Plot_all_daily_LAP.R")


cat(paste("\n\n IS YOU SEE THIS: \n", Script.Name," GOT TO THE END!! \n"))
cat(paste("\n EVERYTHING SHOULD BE FINE \n"))

## END ##
tac = Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
