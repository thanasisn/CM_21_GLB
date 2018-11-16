#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'
#' Read text files with CM_21 data
#'   - from Sirena
#'   - from Radmon
#'   - add sun position
#'   - plot input data
#'   - NO FILTERING
#' Store as a binary file for further use
#' Works for a set date range
#' based on level_0_CM21_x8
#' Reads from Sirena only
#'


####  Set environment  ####
closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM_P00")


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


radmon_files <- list.files( path        = RADMON_DIR,
                            recursive   = TRUE,
                            pattern     = "[0-9]*06.LAP$",
                            ignore.case = TRUE,
                            full.names  = TRUE )
cat(paste(length(radmon_files), "files from Radmon\n"))


####  Check files between Radmon and Sirena  ####

sir_names <- basename(sirena_files)
rad_names <- basename(radmon_files)

missing_from_sir <- rad_names[ ! rad_names %in% sir_names ]

# sir_names[ ! sir_names %in% rad_names ]

cat(paste("There are ",
          length(missing_from_sir) ,
          " files on Radmon that are missing from Sirena\n"))
if ( length(missing_from_sir) > 0 ) {
    cat(paste(missing_from_sir),sep = "\n")
    warning(paste("There are ", length(missing_from_sir) , " files on Radmon that are missing from Sirena"))
}


####  Read files to data.table  ####

years_to_do <- format(seq(START_DAY, END_DAY, by = "year"), "%Y" )

## one output file per year
for ( YYYY in years_to_do ) {
    yy = substr(YYYY, 3,4)

    data_year    <- data.table()
    days_of_year <- seq.Date(as.Date(paste0(YYYY,"-01-01")),
                             as.Date(paste0(YYYY,"-12-31")), by = "day")

    for ( aday in days_of_year ) {
        paste0( SIRENA_DIR,"/",YYYY,"/" )
    }

    ## we assume the files are in the correct folder
    paste0( SIRENA_DIR )


    # theday  = as.POSIXct(dd, origin = "1970-01-01")
    # test    = format( theday, format = "%d%m%y06" )
    # afile   = all_files[grep(test, all_files)]
    # sunfl   = paste0(sunfolder,"sun_path_",format(theday, "%F"), ".dat.gz")


}






