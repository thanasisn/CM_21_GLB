# /* Copyright (C) 2022 Athanasios Natsis <natsisphysicist@gmail.com> */
#' ---
#' title:         "Correlate Horizontal and Inclined CM21 signal **INC ~ HOR**."
#' author:        "Natsis Athanasios"
#' institute:     "AUTH"
#' affiliation:   "Laboratory of Atmospheric Physics"
#' documentclass: article
#' classoption:   a4paper,oneside
#' fontsize:      10pt
#' geometry:      "left=0.5in,right=0.5in,top=0.5in,bottom=0.5in"
#'
#' link-citations:  yes
#' colorlinks:      yes
#'
#' header-includes:
#' - \usepackage{caption}
#' - \usepackage{placeins}
#' - \captionsetup{font=small}
#'
#' output:
#'   bookdown::pdf_document2:
#'     number_sections:  no
#'     fig_caption:      no
#'     keep_tex:         no
#'     latex_engine:     xelatex
#'     toc:              yes
#'     fig_width:        8
#'     fig_height:       5
#'   html_document:
#'     toc:        true
#'     fig_width:  7.5
#'     fig_height: 5
#'
#' date: "`r format(Sys.time(), '%F')`"
#' params:
#'    ALL_YEARS: TRUE
#' ---

#'
#' Compare Inclined CM21 with Global CM21 to produce a calibration factor
#'
#+ echo=F, include=T


##__  Document Options  --------------------------------------------------------

#+ echo=F, include=F
knitr::opts_chunk$set(comment    = ""      )
knitr::opts_chunk$set(dev        = "pdf"   )
# knitr::opts_chunk$set(dev        = "png"    )
knitr::opts_chunk$set(out.width  = "100%"   )
knitr::opts_chunk$set(fig.align  = "center" )
knitr::opts_chunk$set(fig.pos    = '!h'     )



#+ include=F, echo=F
##__  Run Environment  ---------------------------------------------------------
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n\n")
                            return("CM21_R20_") })
if (!interactive()) {
    pdf( file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".pdf", Script.Name))))
    sink(file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".out", Script.Name))), split = TRUE)
    filelock::lock(paste0("~/CM_21_GLB/LOGs/", basename(sub("\\.R$",".lock", Script.Name))), timeout = 0)
}


#+ echo=F, include=F
##  External code  -------------------------------------------------------------
library(data.table, quietly = TRUE, warn.conflicts = FALSE)
library(pander,     quietly = TRUE, warn.conflicts = FALSE)
source("~/CM_21_GLB/Functions_write_data.R")
source("~/CM_21_GLB/Functions_CM21_factor.R")
source("~/CM_21_GLB/Functions_dark_calculation.R")

##  Use the same definitions as horizontal CM-21 -------------------------------

## Standard deviation filter (apply after other filters)
STD_ret_ap_for = 10   ## apply rule when there are enough data points
STD_relMAX     =  1   ## Standard deviation can not be > STD_relMAX * MAX(daily value)


##  Variables  -----------------------------------------------------------------
tag <- paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


## Bais doy 53:178
START_DAY <- "2022-02-22"
END_DAY   <- "2022-06-27"

## extend
START_DAY <- "2022-02-20"
END_DAY   <- "2022-07-01"


## color values
col_hor <- "green"
col_inc <- "magenta"



##  Load HOR_CM21  -------------------------------------------------------------
HORIZ <- readRDS("~/DATA/Broad_Band/CM21_H_global/LAP_CM21_H_L1_2022.Rds")




##  Load INC_CM  ---------------------------------------------------------------
INCLI <- data.table()

incfiles <- list.files(path        = "~/DATA_RAW/Bband/CM21_LAP.INC",
                       pattern     = "[0-9]{6}01.LAP",
                       full.names  = TRUE,
                       ignore.case = TRUE,
                       recursive   = TRUE)


dayswecare <- seq.Date(as.Date(START_DAY),
                       as.Date(END_DAY), by = "day")
missing_files <- c()
for (aday in dayswecare) {
    aday  <- as.Date(aday, origin = "1970-01-01")
    found <- grep(paste0(format(aday, "%d%m%y01")), incfiles, ignore.case = T )

    ## check file names
    if (length(found) > 1) {
        stop("Found more file than we should") }
    if (length(found) == 0) {
        missing_files <- c(missing_files, paste0( format(aday, "%d%m%y01")))
        cat("Missing inclined for", format(aday), paste0( format(aday, "%d%m%y01")),"\n")
        next()
    }

    ##  Recreate time stamp for all minutes of day
    D_minutes <- seq(from       = as.POSIXct(paste(aday, "00:00:30 UTC")),
                     length.out = 1440,
                     by         = "min" )

    ##  Read LAP file
    lap <- fread( incfiles[found], na.strings = "-9" )
    lap[ V1 < -8, V1 := NA ]
    lap[ V2 < -8, V2 := NA ]
    stopifnot( dim(lap)[1] == 1440 )

    sunfl <- paste0(SUN_FOLDER, "sun_path_", format(aday, "%F"), ".dat.gz")
    #### . . Read SUN file  ####
    if (!file.exists(sunfl)) stop(cat(paste("Missing:", sunfl, "\nRUN! Sun_vector_construction_cron.py\n")))
    sun_temp <- read.table( sunfl,
                            sep         = ";",
                            header      = TRUE,
                            na.strings  = "None",
                            strip.white = TRUE,
                            as.is       = TRUE)


    ##  Day table to save
    day_data <- data.table( Date        = D_minutes, # Date of the data point
                            INC_value   = lap$V1,    # Raw value for CM21
                            INC_sd      = lap$V2)    # Raw SD value for CM21

    ##  Gather data
    INCLI <- rbind(INCLI, day_data)
}

##  Complete data set
DATA <- merge(HORIZ, INCLI, all = TRUE)
# DATA[, HOR_value := wattGLB / cm21factor(Date) ]

##  USE common data for analysis
DT <- DATA[ !is.na(INC_value) & !is.na(wattGLB), ]



## TODO
## - define period of data to use
## - dark calculation????
##   - before analysis!
## - correlate





#'
#' # Data Overview
#'
#' Investigate data of horizontal and inclined CM-21.
#'
#' Inclined data are read from "sirena" directly.
#'
#' Global data are produced by me.
#'
#' Data view is extended to:
#'
#' Start day: `r START_DAY`
#'
#' End day:   `r END_DAY`
#'
#+ include=T, echo=F

if (!interactive()) {  # workaround plot setup

plot(DATA$Date,
     DATA$wattGLB,
     xlim = c(as.POSIXct(START_DAY), as.POSIXct(END_DAY)),
     col  = col_hor,
     pch  = ".",
     xlab = "",
     main = "Global radiation")

plot(DATA$Date,
     DATA$INC_value,
     xlim = c(as.POSIXct(START_DAY), as.POSIXct(END_DAY)),
     col  = col_inc,
     pch  = ".",
     xlab = "",
     main = "Inclined CM21 signal")

} # workaround plot setup


#'
#' ## Common measurements
#'
#' Only simultaneous measurements.
#'
#+ include=T, echo=F

if (!interactive()) {  # workaround plot setup

plot(DT$wattGLB, DT$INC_value,
     pch  = ".",
     xlab = "",
     main = "Common values")


plot(DT$Date,
     DT$wattGLB,
     col  = col_hor,
     pch  = ".",
     xlab = "",
     main = "Global radiation")

plot(DT$Date,
     DT$INC_value,
     col  = col_inc,
     pch  = ".",
     xlab = "",
     main = "Inclined CM21 signal")

} # workaround plot setup



#'
#' ## Daily plot
#'
#+ include=T, echo=F
if (!interactive()) {  # workaround plot setup

for (ad in unique(as.Date(DT$Date))) {
    pp <- DT[ as.Date(Date) == ad ]
    ad <- as.Date(ad, origin = "1970-01-01")

    par(mar = c(2,2,2,1))

    layout(rbind(1,2), heights=c(7,1))  # put legend on bottom 1/8th of the chart

    plot.new()

    title(main = paste0(ad, " d:", yday(ad), " " ), cex.main = .8)
    par(new = T)
    plot(pp$Date,
         pp$wattGLB,
         col  = col_hor,
         xlab = "",  ylab = "",
         yaxt = "n",
         xaxs = "i",
         pch  = 19,
         cex  = 0.3)

    par(new = T)
    plot(pp$Date,
         pp$INC_value,
         col  = col_inc,
         xlab = "",  ylab = "",
         yaxt = "n",
         xaxs = "i",
         pch  = 19,
         cex  = 0.2)


    vec <- pp$INC_value / pp$wattGLB
    vec[!is.finite(vec)] <- NA

    range <- diff(range(vec, na.rm = T))
    range <- range * 0.01
    mean  <- mean(vec, na.rm = T)
    ylim  <- c(mean - range, mean + range)


    vec[vec > ylim[2]] <- NA
    vec[vec < ylim[1]] <- NA


    par(new = T)
    plot(pp$Date,
         vec ,
         col  = "blue",
         xlab = "",  ylab = "",
         xaxs = "i",
         pch  = 19,
         log  = "y",
         cex  = 0.4)
    # abline(h = 1, lty = 1 , col = "black")

    par(new = T)
    plot(pp$Date,
         vec ,
         ylim = ylim,
         col  = "cyan",
         xlab = "",  ylab = "",
         xaxs = "i",
         pch  = 19,
         cex  = 0.4)


    par(mar=c(0, 0, 0, 0))
    # c(bottom, left, top, right)
    plot.new()
    legend("center",
           legend = c("Global Horizontal [W/m^2]",
                      "Inclined Signal [V]",
                      "log(Inclined / Horizontal)",
                      "Inclined / Horizontal"),
           col  = c(col_hor, col_inc,'blue', "cyan"),
           pch  = 19,
           ncol = 2,
           bty = "n")

}

} # workaround plot setup

#'
#' # Process
#'
#+ include=T, echo=F



##  Init yearly calculations
globaldata    <- data.table()
NR_extreme_SD <- 0

daystodo      <- unique(as.Date(DATA[!is.na(INC_value), Date]))
pbcount       <- 0

for (ddd in daystodo) {

    theday      <- as.POSIXct( as.Date(ddd, origin = "1970-01-01"))
    test        <- format( theday, format = "%d%m%y06" )
    pbcount     <- pbcount + 1

    daymimutes  <- data.frame(
        Date = seq( as.POSIXct(paste(as.Date(theday), "00:00:30")),
                    as.POSIXct(paste(as.Date(theday), "23:59:30")), by = "min"  )
    )


    ## get all day
    wholeday    <- DATA[as.Date(Date) == as.Date(theday), ]
    ## use only valid data for dark
    daydata     <- DATA[as.Date(Date) == as.Date(theday) & !is.na(INC_value), ]

    ## fill all minutes for nicer graphs
    daydata     <- merge(daydata, daymimutes, all = T)
    daydata$day <- as.Date(daydata$Date)



    ####  Filter Standard deviation extremes  ##############################
    ## SD can not be greater than the signal
    pre_count     <- daydata[ !is.na(INC_value), .N ]
    ## apply rule if there are enough data
    if (pre_count > STD_ret_ap_for) {
        ## filter sd relative to the signal
        vec <- daydata[, INC_sd < STD_relMAX * max(INC_value, na.rm = T) ]
        if (sum(!vec, na.rm = T) > 0) {
            cat("Extreme sd values detected N:",sum(!vec, na.rm = T) ,"\n" )
            cat("Will be ignored from dark calculation\n" )
        }
        daydata        <- daydata[ vec ]

        NR_extreme_SD <- NR_extreme_SD + pre_count - daydata[ !is.na(INC_value), .N ]
        if (nrow(daydata[!is.na(INC_value)]) < 1) {
            cat('\n')
            cat(paste(theday, "SKIP DAY: No data after extreme SD filtering!!"),"\n\n")
            next()
        }
    }
    ########################################################################








    daydata[is.na(Elevat) ]

        dates      <- daydata$Date
        values     <- daydata$INC_value
        elevatio   <- daydata$Elevat
        nightlimit <- DARK_ELEV
        dstretch   <- DSTRETCH

        require(zoo,   quietly = TRUE, warn.conflicts = FALSE)

        ### suppress warnings zoo::index
        suppressWarnings({
            ## find local noun
            nounindex    <- match( max(elevatio), elevatio )
            ## split day in half
            selectmorn   <- elevatio < nightlimit & index(elevatio) < nounindex
            selecteven   <- elevatio < nightlimit & index(elevatio) > nounindex
            ## all morning and evening dates
            morning      <- dates[selectmorn]
            evening      <- dates[selecteven]

            ## morning selection with time limit
            mornigend    <- morning[max(index(morning))]
            mornigstart  <- mornigend - dstretch
            ## selection for morning dark
            morningdark  <- selectmorn & dates <= mornigend & mornigstart < dates

            ## evening selection with time limit
            eveningstart <- evening[min(index(evening))]
            eveningend   <- eveningstart + dstretch
            ## selection for evening dark
            eveningdark  <- selecteven & dates >= eveningstart & dates < eveningend
        })

        return(
            data.frame(
                Mavg = mean(      values[morningdark],  na.rm = TRUE ),
                Mmed = median(    values[morningdark],  na.rm = TRUE ),
                Msta = max(       dates[ morningdark],  na.rm = TRUE ),
                Mend = min(       dates[ morningdark],  na.rm = TRUE ),
                Mcnt = sum(!is.na(values[morningdark])),
                Eavg = mean(      values[eveningdark],  na.rm = TRUE ),
                Emed = median(    values[eveningdark],  na.rm = TRUE ),
                Esta = min(       dates[ eveningdark],  na.rm = TRUE ),
                Eend = max(       dates[ eveningdark],  na.rm = TRUE ),
                Ecnt = sum(!is.na(values[eveningdark]))
            )
        )

















    ####    Calculate Dark signal   ########################################
    dark_day <- dark_calculations( dates      = daydata$Date,
                                   values     = daydata$INC_value,
                                   elevatio   = daydata$Elevat,
                                   nightlimit = DARK_ELEV,
                                   dstretch   = DSTRETCH)







    cat(paste(dark_day),"\n")



}





# # if ( is.na(dark_day$Mmed) & is.na(dark_day$Emed) ) {
# if ( ! ((!is.na(dark_day$Mmed) & dark_day$Mcnt >= DCOUNTLIM) |
#         (!is.na(dark_day$Emed) & dark_day$Ecnt >= DCOUNTLIM)) ) {
#     # cat("Can not apply dark\n")
#     todays_dark_correction <- NA
#     dark_flag              <- "MISSING"
#     missingdark            <- NA
#
#     ## get dark from pre-computed file
#     if (exists("construct")) {
#         ## can not find date
#         if (! theday %in% construct$Date) {
#             todays_dark_correction <- NA
#             dark_flag              <- "MISSING"
#             missingdark            <- NA
#         } else {
#             ## get data from recomputed dark database
#             todays_dark_correction <- construct[ Date == theday, DARK]
#             dark_flag              <- "CONSTRUCTED"
#         }
#     }
# } else {
#     ####    Dark Correction function   #################################
#     dark_generator <- dark_function(dark_day    = dark_day,
#                                     DCOUNTLIM   = DCOUNTLIM,
#                                     type        = "median",
#                                     adate       = theday ,
#                                     test        = test,
#                                     missfiles   = missfiles,
#                                     missingdark = missingdark )
#
#     ####    Create dark signal for correction    #######################
#     todays_dark_correction <- dark_generator(daydata$Date)
#     dark_flag              <- "COMPUTED"
# }
#
# ####    Apply dark correction    #######################################
# daydata[, CM21valueWdark := CM21value - todays_dark_correction ]








#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
