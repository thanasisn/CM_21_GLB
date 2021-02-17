#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'
#' Read text files with CM_21 signal data
#'   - from Sirena
#'   - from Radmon
#'   - add sun position
#'   - all minutes of year
#'   - NO FILTERING
#' Store as .Rds binaries files for further use
#' Works for a set date range
#' based on level_0_CM21_x8
#' Reads from Sirena only
#'


####  Set environment  ####
closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = funr::sys.script()
if(!interactive()) {
    pdf(file=sub("\\.R$",".pdf",Script.Name))
    sink(file=sub("\\.R$",".out",Script.Name),split=TRUE)
}


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


####  Read files of all years  ####

years_to_do <- format(seq(START_DAY, END_DAY, by = "year"), "%Y" )

## one output file per year
## we assume the files are in the correct folder

for ( YYYY in years_to_do ) {
    yy = substr(YYYY, 3,4)

    year_data    <- data.table()
    days_of_year <- seq.Date(as.Date(paste0(YYYY,"-01-01")),
                             as.Date(paste0(YYYY,"-12-31")), by = "day")

    for ( aday in days_of_year ) {
        aday  = as.Date(aday, origin = "1970-01-01")
        sunfl = paste0(SUN_FOLDER, "sun_path_", format(aday, "%F"), ".dat.gz")

        found = grep( paste0( "/",YYYY,"/", format(aday, "%d%m%y06") ), sirena_files, ignore.case = T )
        ## check file names
        if ( length(found) > 1 ) {
            stop("Found more file than we should") }
        if ( length(found) == 0 ) {
            cat(paste0("Missing file: ", YYYY,"/", format(aday, "%d%m%y06"), "\n"))
            cat(paste0(YYYY,"/", format(aday, "%d%m%y06")), sep = "\n", file = MISSING_INP, append = T )
            next()
        }

        suppressWarnings(rm(D_minutes))
        D_minutes <- seq(from = as.POSIXct(paste(aday,"00:00:30 UTC")), length.out = 1440, by = "min" )

        #### . . Read LAP file  ####
        lap <- fread( sirena_files[found], na.strings = "-9" )
        stopifnot( dim(lap)[1] == 1440 )

        #### . . Read SUN file  ####
        if ( !file.exists( sunfl ) ) stop(cat(paste("Missing:", sunfl, "\nRun:   Sun_vector_constraction_cron.py?\n")))
        sun_temp <- read.table( sunfl,
                                sep = ";",
                                header = TRUE,
                                na.strings = "None" ,strip.white = TRUE,  as.is = TRUE)

        #### . . Day table to save  ####
        day_data <- data.table( Date        = D_minutes,      # Date of the data point
                                CM21value   = lap$V1,         # Raw value for CM21
                                CM21sd      = lap$V2,         # Raw SD value for CM21
                                Azimuth     = sun_temp$AZIM,  # Azimuth sun angle
                                Elevat      = sun_temp$ELEV ) # Elevation sun angle

        #### . . Gather data  ####
        year_data <- rbind( year_data, day_data )

    }

    #### . . All the minutes of year ####
    all_min <- seq(as.POSIXct(paste0(YYYY,"-01-01 00:00:30")),
                   as.POSIXct(paste0(YYYY,"-12-31 23:59:30")), by = "mins")
    all_min <- data.frame(Date = all_min)

    year_data <- merge(year_data, all_min, all = T)


    ####  Save data to file  ####

    outfile = paste0(SIGNAL_DIR,"/LAP_CM21H_SIG_",YYYY,".Rds")

    RAerosols::write_RDS(year_data, outfile )

    system(paste("sort -u -o ", MISSING_INP, MISSING_INP ))
}




## END ##
tac = Sys.time()
cat(sprintf("\n%s %10s %10s %25s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
