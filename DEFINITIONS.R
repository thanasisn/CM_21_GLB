#'
#' Here are some global or common variables for this project.
#' This variables define:
#'   - calculations parameters
#'   - data processing
#'   - data path locations
#'


## Project root folder
BASED      = "~/CM_21_GLB/"


####  Data location  ####
SUN_FOLDER = "~/DATA_RAW/SUN/PySolar_LAP/"
SIRENA_DIR = "~/DATA_RAW/Bband/AC21_LAP.GLB/"
RADMON_DIR = "~/DATA_RAW/Raddata/6"
SIGNAL_DIR = "~/DATA/Broad_Band/CM21_H_signal/"
GLOBAL_DIR = "~/DATA/Broad_Band/CM21_H_global/"
EXPORT_DIR = "~/DATA/cm21_data_validation/CM21_exports/"
REPORT_DIR = "~/CM_21_GLB/REPORTS/"
TOT_EXPORT = "~/DATA/cm21_data_validation/AC21_lap.GLB_NEW/"
DAILYgrDIR = "~/CM_21_GLB/REPORTS/DAILY/"

####  Parametric files ####
BAD_RANGES = "~/CM_21_GLB/PARAMS/Skip_ranges_CM21.txt"

DARKFILE  = paste0(dirname(GLOBAL_DIR), "/Dark_functions.Rdata")

DARKSTORE <- paste0(SIGNAL_DIR, "/LAP_CM21_Dark_data_S0.Rds")
DARKCONST <- paste0(SIGNAL_DIR, "/LAP_CM21_Dark_construction_S0.Rds")


####  Log files  ####
MISSING_INP = paste0(BASED,"/LOGS/missing_input.dat")

####  Filtering Variables  ####

## break between 2014-02-04 and 2014-02-05
BREAKDATE  = as.POSIXct("2014-02-05 00:00:00")


## Lower global limit any Global value below this should be erroneous data
GLB_LOW_LIM_01   = -15      ## before break-date
GLB_LOW_LIM_02   = -7       ## after break-data


## Dark Calculations
DARK_ELEV     = -10         ## sun elevation limit
DSTRETCH      =  20 * 3600  ## time duration of dark signal for morning and evening of the same day
DCOUNTLIM     =  10         ## if dark signal has fewer valid measurements than these ignore it



####  Process Control  ####

## date range to process
START_DAY   <- as.POSIXct("1993-01-01 00:00:00 UTC")
# START_DAY   <- as.POSIXct("2006-01-01 00:00:00 UTC")
END_DAY     <- as.POSIXct("2022-01-01 00:00:00 UTC")

## date range to export for TOT and WRDC
EXPORT_START <- as.POSIXct("2006-01-01 00:00:00 UTC")
EXPORT_STOP  <- as.POSIXct("2022-01-01 00:00:00 UTC")



#### Signal to L0 variables  #####

## mark all data
MINsgLIM      = -0.06      ## Lower signal limit (CF~3344.482  0.03V~100watt)
MAXsgLIM      = +0.5       ## Higher signal limit (from hardware limitations)

## mark when dark (sun below DARK_ELEV )
DARK_ELEV     = -10        ## sun elevation limit
MINsgLIMnight = -0.02      ## Lower signal limit when dark
MAXsgLIMnight = +0.10      ## Higher signal limit when dark

MINLIMnight   = -15        ## Lower radiation limit  when dark
MAXLIMnight   = +15        ## Higher radiation limit when dark


## mark limit
SUN_ELEV      = +0         ## When sun is above that
MINglbSUNup   =  0         ## Exclude signal values below that

