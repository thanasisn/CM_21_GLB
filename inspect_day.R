#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()


library(data.table, quietly = T, warn.conflicts = F)
library(optparse)


## Data folder
# FOLDER <- "/home/athan/DATA_RAW/Raddata"
FOLDER <- "/home/athan/DATA_RAW/Bband"


####   Get input    ############################################################
MINDATE <- as.Date("1993-01-01")
MAXDATE <- as.Date(Sys.Date())
MINSTEP <- 1
MAXSTEP <- 400

option_list <-  list(
    make_option(c("-d", "--day"),
                type    = "character",
                default = paste0(year(Sys.Date()), "-01-01"),
                help    = paste0("Start day of ploting yyyy-mm-dd, [",MINDATE,", ",MAXDATE,"]"),
                metavar = "yyyy-mm-dd"),
    make_option(c("-s", "--step"),
                type    = "integer",
                default = 3,
                help    = paste0("Step width in days, [",MINSTEP,", ",MAXSTEP,"]"),
                metavar = "integer")
)
opt_parser <- OptionParser(option_list = option_list)
args       <- parse_args(opt_parser)

STARTDAY <- args$day
STARTDAY <- as.Date(STARTDAY)
STEP     <- args$step

cat("Start day:", paste(STARTDAY),"\n")
cat("Step     :", STEP, "\n")

if ( ! (MINDATE <= STARTDAY & STARTDAY <= MAXDATE)) {
    stop(STARTDAY, " is invalid date")
}

if ( ! (MINSTEP <= STEP & STEP <= MAXSTEP)) {
    stop(STEP, " is invalid step")
}



####    Init    ################################################################

globalfiles <- list.files(path        = FOLDER,
                          recursive   = TRUE,
                          pattern     = "[0-9]*06.LAP$",
                          ignore.case = TRUE,
                          full.names  = TRUE)

directfiles <- list.files(path        = FOLDER,
                          recursive   = TRUE,
                          pattern     = "[0-9]*03.LAP$",
                          ignore.case = TRUE,
                          full.names  = TRUE)

if (STEP == 1) {
    MOVE <- 1
} else {
    MOVE <- STEP - 1
}

daystodo <- seq(STARTDAY, MAXDATE, by = MOVE)

for (ap in daystodo) {
    toplot <- as.Date(ap:(ap+STEP), origin = "1970-01-01")
    gather <- data.table()

    for (ad in toplot) {
        theday <- as.Date(ad, origin = "1970-01-01")
        format(theday,"%d%m%y")




    }

}


