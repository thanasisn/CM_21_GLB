# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

#### Variables of this project.

#'
#' Here are some global or common variables for this project.
#' This variables define:
#'   - calculations parameters
#'   - data processing
#'   - data path locations
#'


####    Project root folder    #################################################
BASED      <- "~/CM_21_GLB/"



####    Process Range Control    ###############################################

## Date range to read raw data
START_DAY    <- as.POSIXct("1993-01-01 00:00:00 UTC")
# END_DAY      <- as.POSIXct("2022-03-31 00:00:00 UTC")
END_DAY      <- Sys.time()

## date range to export for TOT and WRDC
EXPORT_START <- as.POSIXct("2006-01-01 00:00:00 UTC")
EXPORT_STOP  <- as.POSIXct("2022-03-31 00:00:00 UTC")



####    Input paths    #########################################################
SUN_FOLDER <- "~/DATA_RAW/SUN/PySolar_LAP/"
SIRENA_DIR <- "~/DATA_RAW/Bband/AC21_LAP.GLB/"
RADMON_DIR <- "~/DATA_RAW/Raddata/6"



####    Output paths    ########################################################
DAILYgrDIR <- paste0(BASED, "/REPORTS/DAILY/")
REPORT_DIR <- paste0(BASED, "/REPORTS/")
SIGNAL_DIR <- "~/DATA/Broad_Band/CM21_H_signal/"
GLOBAL_DIR <- "~/DATA/Broad_Band/CM21_H_global/"
EXPORT_DIR <- "~/DATA/Broad_Band/CM21_H_exports/"
TOT_EXPORT <- "~/DATA/cm21_data_validation/AC21_lap.GLB_NEW/"


####    Parametric files    ####################################################

## Date ranges to exclude, after manual inspection
BAD_RANGES  <- paste0(BASED,      "/PARAMS/Skip_ranges_CM21.dat")
## Storage of dark signal details for all days
DARKSTORE   <- paste0(SIGNAL_DIR, "/LAP_CM21_Dark_data_S0.Rds")
## Dark signal details constructed for uncomputable days
DARKCONST   <- paste0(SIGNAL_DIR, "/LAP_CM21_Dark_construction_S0.Rds")
## Logging of missing lap input files
MISSING_INP <- paste0(BASED,      "/PARAMS/Missing_lap_files.dat")





####  Filtering Variables  ####

## break between 2014-02-04 and 2014-02-05
BREAKDATE  = as.POSIXct("2014-02-05 00:00:00")


## Lower global limit any Global value below this should be erroneous data
GLB_LOW_LIM_01  <- -15      ## before break-date
GLB_LOW_LIM_02  <- -7       ## after break-data






####   Dark Calculations and definitions    ####################################
DSTRETCH    <-  20 * 3600  ## Extend of dark signal for morning and evening of the same day (R30)
DCOUNTLIM   <-  10         ## Number of valid measurements to compute dark (R30)
DARK_ELEV   <- -10         ## Sun elevation limit to get dark signal (R20, R30)
MINLIMnight <- -15         ## Lower radiation limit  when dark       (R20) -> ToolowDark
MAXLIMnight <- +15         ## Higher radiation limit when dark       (R20) -> ToohigDark

####    Negative radiation when sun is up   ####################################
SUN_ELEV    <- +0         ## When sun is above that           (R50)
MINglbSUNup <- -0.3       ## Exclude signal values below that (R50) above that will set to zero

####    Positive radiation when sun is down   ##################################
SUN_TOO_LOW <- -5         ## When sun is down  (R50)
ERROR_GLOBA <-  5         ## Positive radiation in the night (R50)

####    Drop night time data    ################################################
NIGHT_DROP  <- -5         ## Drop when sun is below that (R60)

