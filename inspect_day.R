#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()


library(data.table, quietly = T, warn.conflicts = F)
library(optparse)
source("~/CM_21_GLB/Functions_CM21_factor.R")
source("~/CHP_1_DIR/Functions_CHP1.R")


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

## loop plots
for (ap in daystodo) {
    toplot <- as.Date(ap:(ap+STEP), origin = "1970-01-01")
    gather <- data.table()

    ## loop days to plot with step
    for (ad in toplot) {
        theday    <- as.Date(ad, origin = "1970-01-01")
        strday    <- format(theday,"%d%m%y")

        glbfile   <- grep( strday, globalfiles, value = T )[1]
        dirfile   <- grep( strday, directfiles, value = T )[1]

        D_minutes <- seq(from       = as.POSIXct(paste(theday,"00:00:30 UTC")),
                         length.out = 1440,
                         by         = "min" )

        if (file.exists(glbfile)) {
            glb <- fread(glbfile)
            names(glb) <- c("GLBsig", "GLBsd")
            glb[ GLBsig < -8, GLBsig := NA ]
            glb[ GLBsd  < -8, GLBsd  := NA ]
        } else {
            cat(paste0("Missing global : ", strday,"06"),"\n")
            glb        <- data.table()
            glb$GLBsig <- rep(NA, 1440)
            glb$GLBsd  <- rep(NA, 1440)
        }
        if (file.exists(dirfile)){
            dir <- fread(dirfile)
            names(dir) <- c("DIRsig", "DIRsd")
            dir[ DIRsig < -8, DIRsig := NA ]
            dir[ DIRsd  < -8, DIRsd  := NA ]
        } else {
            cat(paste0("Missing direct : ", strday,"03"),"\n")
            dir        <- data.table()
            dir$DIRsig <- rep(NA, 1440)
            dir$DIRsd  <- rep(NA, 1440)
        }

        daydt  <- cbind(Date = D_minutes,glb, dir)
        gather <- rbind(gather, daydt)
    }

    ## convert to radiation
    gather$GLBsig <- gather$GLBsig * cm21factor(gather$Date)
    gather$GLBsd  <- gather$GLBsd  * cm21factor(gather$Date)
    gather$DIRsig <- gather$DIRsig * chp1factor(gather$Date)
    gather$DIRsd  <- gather$DIRsd  * chp1factor(gather$Date)

    stop()

}


