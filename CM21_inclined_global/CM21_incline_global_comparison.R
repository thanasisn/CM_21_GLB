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
## - plot by date with free scale
## - define period of data to use
## - dark calculation????
##   - before analysis!
## - correlate




#'
#' # Data Overview
#'
#' Investigate data of horizontal and inclined CM-21.
#'
#' Data view is extended to:
#'
#' Start day: `r START_DAY`
#'
#' End day:   `r END_DAY`
#'
#+ include=T, echo=F

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


#'
#' ## Common measurements
#'
#' Only simultaneous measurements.
#'
#+ include=T, echo=F

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



#'
#' ## Daily plot
#'
#+ include=T, echo=F
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
         cex  = 0.4)

    par(new = T)
    plot(pp$Date,
         pp$INC_value,
         col  = col_inc,
         xlab = "",  ylab = "",
         yaxt = "n",
         xaxs = "i",
         pch  = 19,
         cex  = 0.3)


    par(new = T)
    plot(pp$Date,
         pp$INC_value / pp$wattGLB ,
         col  = "blue",
         xlab = "",  ylab = "",
         xaxs = "i",
         pch  = 19,
         log  = "y",
         cex  = 0.6)
    abline(h = 1, lty = 1 , col = "black")


    par(mar=c(0, 0, 0, 0))
    # c(bottom, left, top, right)
    plot.new()
    legend("center",
           legend = c("Global Horizontal [W/m^2]",
                      "Inclined Signal [V]",
                      "log(Inclined / Horizontal)"),
           col  = c(col_hor, col_inc,'blue'),
           pch  = 19,
           ncol = 3,
           bty = "n")

}


#'
#' # Process
#'
#+ include=T, echo=F




#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
