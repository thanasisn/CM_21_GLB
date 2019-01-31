#'
#' Here are some global or common variables for this project.
#' This variables define:
#'   - calculations parameters
#'   - data processing
#'   - data path locations
#'
#'
#'


## Project root folder
BASED     = "/home/athan/CM_21_GLB/"


####  Data location  ####
SUN_FOLDER = "/home/athan/DATA_RAW/SUN/PySolar_LAP/"
SIRENA_DIR = "/home/athan/DATA_RAW/Bband/AC21_LAP.GLB/"
RADMON_DIR = "/home/athan/DATA_RAW/Raddata/6"
SIGNAL_DIR = "/home/athan/DATA/cm21_data_validation/CM21_signal/"

####  Parametric files ####
TOO_BAD    = "/home/athan/CM_21_GLB/PARAMS/Too_bad_dates.dat"
BAD_RANGES = "/home/athan/CM_21_GLB/PARAMS/Skip_ranges_CM21.txt"

####  Log files  ####
MISSING_INP = paste0(BASED,"/LOGS/missing_input.dat")

####  Variables  ####

## date range to process
START_DAY = as.POSIXct("2006-01-01 00:00:00 UTC")
END_DAY   = as.POSIXct("2019-01-01 00:00:00 UTC")



#### Plot files ####


