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
SIGNAL_DIR = "~/DATA/cm21_data_validation/CM21_signal/"
GLOBAL_DIR = "~/DATA/cm21_data_validation/CM21_global/"
EXPORT_DIR = "~/DATA/cm21_data_validation/CM21_exports/"
REPORT_DIR = "~/CM_21_GLB/REPORTS/"
TOT_EXPORT = "~/DATA/cm21_data_validation/AC21_lap.GLB_NEW/"


####  Parametric files ####
TOO_BAD    = "~/CM_21_GLB/PARAMS/Too_bad_dates.dat"
BAD_RANGES = "~/CM_21_GLB/PARAMS/Skip_ranges_CM21.txt"

DARKFILE  = paste0(dirname(GLOBAL_DIR), "/Dark_functions.Rdata")



####  Log files  ####
MISSING_INP = paste0(BASED,"/LOGS/missing_input.dat")

####  Filtering Variables  ####

## break between 2014-02-04 and 2014-02-05
BREAKDATE  = as.POSIXct("2014-02-05 00:00:00")


## Lower global limit any Global value below this should be erroneous data
GLB_LOW_LIM_01   = -15      ## before breakdate
GLB_LOW_LIM_02   = -7       ## after breakdata


## Dark Calculations
DARK_ELEV     = -10         ## sun elevation limit
DSTRETCH      =  20 * 3600  ## time duration of dark signal for morning and evening of the same day
DCOUNTLIM     =  10         ## if dark signal has fewer valid measurements than these ignore it



####  Process Control  ####

## date range to process
START_DAY  = as.POSIXct("2006-01-01 00:00:00 UTC")
END_DAY    = as.POSIXct("2021-01-01 00:00:00 UTC")

## date range to export for TOT and WRDC
EXPORT_START = as.POSIXct("2006-01-01 00:00:00 UTC")
EXPORT_START = as.POSIXct("2019-01-01 00:00:00 UTC")
EXPORT_STOP  = as.POSIXct("2021-01-01 00:00:00 UTC")

