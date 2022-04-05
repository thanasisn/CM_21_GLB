# /* !/usr/bin/env Rscript */
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */
#' ---
#' title:         "CM21 signal to radiation. **S1 -> L0**"
#' author:        "Natsis Athanasios"
#' institute:     "AUTH"
#' affiliation:   "Laboratory of Atmospheric Physics"
#' abstract:      "Read signal and dark correction and convert to global radiation."
#' documentclass: article
#' classoption:   a4paper,oneside
#' fontsize:      11pt
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
#'     fig_width:        7
#'     fig_height:       4.5
#'   html_document:
#'     toc:        true
#'     fig_width:  7.5
#'     fig_height: 5
#' date: "`r format(Sys.time(), '%F')`"
#' params:
#'    ALL_YEARS: TRUE
#' ---

#'
#' **S1 -> L0**
#'
#'
#' **Source code: [github.com/thanasisn/CM_21_GLB](https://github.com/thanasisn/CM_21_GLB)**
#'
#' **Data display: [thanasisn.netlify.app/3-data_display/2-cm21_global/](https://thanasisn.netlify.app/3-data_display/2-cm21_global/)**
#'
#' Convert CM21 signal $[V]$ to radiation $[W/m^2]$.
#'
#' - Apply proper gain by the acquisition system
#' - Use an interpolated sensitivity between calibrations.
#' - No filtering of data at this point.
#'
#+ echo=F, include=T


####_  Document options _####

#+ echo=F, include=F
knitr::opts_chunk$set(comment    = ""      )
# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"    )
knitr::opts_chunk$set(out.width  = "100%"   )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'    )





#+ include=F, echo=F
####  Set environment  ####
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n\n")
                            return("CM21_R50_") })
if(!interactive()) {
    pdf(  file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".pdf", Script.Name))))
    sink( file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".out", Script.Name))), split=TRUE)
    filelock::lock(sub("\\.R$",".lock", Script.Name), timeout = 0)
}


## FIXME this is for pdf output
# options(warn=-1) ## hide warnings
# options(warn=2)  ## stop on warnings

#+ echo=F, include=T
####  External code  ####
library(data.table, quietly = T, warn.conflicts = F)
library(pander,     quietly = T, warn.conflicts = F)
source("~/CM_21_GLB/Functions_CM21_factor.R")
source("~/CM_21_GLB/Functions_write_data.R")


####  Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")
panderOptions('table.alignment.default', 'right')
panderOptions('table.split.table',        120   )


## temp folder for daily plots
tmpfolder <- paste0("/dev/shm/", sub(pattern = "\\..*", "" , basename(Script.Name)))

elevlim   <- -5  ## elevation limit for scatter plots
wattlimit <- 50  ## radiation limit for histograms


####  Execution control  ####
ALL_YEARS = FALSE
if (!exists("params")){
    params <- list( ALL_YEARS = ALL_YEARS)
}

tag <- paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


## PATHS






####  Get data input files  ####
input_files <- list.files( path    = SIGNAL_DIR,
                           pattern = "LAP_CM21_H_S1_[0-9]{4}.Rds",
                           full.names = T )
input_years <- as.numeric(
    sub(".rds", "",
        sub(".*_S1_","",
            basename(input_files),),ignore.case = T))


## Get storage files
output_files <- list.files( path    = GLOBAL_DIR,
                            pattern = "LAP_CM21_H_L0_[0-9]{4}.Rds",
                            full.names = T )



if (!params$ALL_YEARS) {
    years_to_do <- c()
    for (ay in input_years) {
        inp <- grep(ay, input_files,  value = T)
        out <- grep(ay, output_files, value = T)
        if ( length(out) == 0 ) {
            ## do if not there
            years_to_do <- c(years_to_do,ay)
        } else {
            ## do if newer data
            if (file.mtime(inp) > file.mtime(out))
                years_to_do <- c(years_to_do,ay)
        }
        years_to_do <- sort(unique(years_to_do))
    }
} else {
    years_to_do <- sort(unique(input_years))
}


## Decide what to do
if (length(years_to_do) == 0 ) {
    stop("NO new data! NO need to parse!")
}




#'
#' ## CM21 conversion factor calculation
#'
#+ include=T, echo=F

pander(calibration_data, caption = "CM21 calibrations")


## create some plot data
dates <- seq(calibration_data$Date[1],Sys.time(),by="day")



plot(dates, sensitivity(dates),
     pch = 19, main = "CM21 Sensitivity",
     xlab = "", ylab = "", cex = .3)
points(calibration_data$Date, calibration_data$Sens, col = "green")
legend("bottomleft",
       legend = c("Sensitivity Interpolation", "Sensitivity calibration"),
       pch    = c( 19, 1 ),
       col    = c(  1, "green"),
       bty    = "n", cex = 0.8)
cat("\n\n")


plot(dates, gain(dates),
     pch = 19, main = "CM21 Acquisition gain",
     xlab = "", ylab = "", cex = .3)
points(calibration_data$Date, calibration_data$Gain,  col = "cyan")
legend("right",
       legend = c("Acquisition gain Constant", "Acquisition gain data"),
       pch    = c( 19, 1 ),
       col    = c(  1, "cyan"),
       bty    = "n", cex = 0.8)
cat("\n\n")



plot(dates, cm21factor(dates),
     pch = 19, main = "CM21 convertion factor",
     xlab = "", ylab = "", cex = .3)
points(calibration_data$Date, calibration_data$Gain / calibration_data$Sensitivity,
       col = "orange" )
legend("right",
       legend = c("Convertion factor interpolated", "Convertion factor calibrated"),
       pch    = c( 19, 1 ),
       col    = c(  1, "orange"),
       bty    = "n", cex = 0.8)
cat("\n\n")


plot(calibration_data$Date, 100*c(NA, diff(calibration_data$Sensitivity))/calibration_data$Sensitivity ,
     main = "CM21 Sensitivity change %",
     xlab = "", ylab = "%", col = "blue")
cat("\n\n")





#'
#' ### Check for minimum Global irradiance.
#'
#' Reject data when GHI is below an acceptable limit.
#'
#' **Before `r BREAKDATE` we use `r GLB_LOW_LIM_01`,**
#'
#' **after  `r BREAKDATE` we use `r GLB_LOW_LIM_02`.**
#'
#' This is due to changes in instrumentation.
#'
#+ include=T, echo=F



#+ include=TRUE, echo=F, results="asis"
for ( yyyy in years_to_do) {
    cat("\n\\FloatBarrier\n\n")
    cat("\\newpage\n\n")
    cat("\n## Year:", yyyy, "\n\n" )

    ####  Get raw data
    afile    <- grep(yyyy, input_files,  value = T)
    rawdata  <- readRDS(afile)
    gather   <- data.table()


    ## create a new temp dir for each years plots
    unlink(tmpfolder, recursive = TRUE)
    dir.create(tmpfolder)
    pbcount  <- 0

    ####  Generate conversion factor
    rawdata[ , CM21CF := cm21factor(Date) ]

    ####  Check dark conditions
    if (rawdata[!is.na(CM21valueWdark) & is.na(CM21valueWdark), .N ] != 0) {
        cat("\n**There are missing dark correction values!!!!**\n\n")
    }


    ####  Convert to physical values  ####
    rawdata[ , wattGLB    := CM21CF * CM21valueWdark ]
    rawdata[ , wattGLB_SD := CM21CF * CM21sd         ]
    rawdata[ , SZA        := 90     - Elevat         ]



    # ##TODO move
    # ## Init another flag
    # rawdata[, QFlag_2 := as.factor(NA)]
    #
    # ####   Mark too low Global values    #######################################
    # rawdata[ Date  < BREAKDATE & wattGLB < GLB_LOW_LIM_01, QFlag_2 := "TooLowGlobal"  ]
    # rawdata[ Date >= BREAKDATE & wattGLB < GLB_LOW_LIM_02, QFlag_2 := "TooLowGlobal"  ]
    #
    # testlow <- rawdata[ QFlag_2 == "TooLowGlobal"]
    # if ( nrow(testlow)>0 ) {
    #     cat("\n**Marked too low Global records on:**\n\n")
    #     cat(pander(testlow[ ,.N,by = .(Date=as.Date(Date)) ]))
    #     cat("\n\n")
    # }
    # ############################################################################



    ##  Get only days with valid data to loop
    daystodo <- rawdata[ , .(N = sum(!is.na(CM21value))), by = .(Days <- as.Date(Date)) ]
    daystodo <- daystodo[ N > 0, Days ]

    for (aday in sort(daystodo)) {

        theday      <- as.Date( aday, origin = "1970-01-01")
        test        <- format( theday, format = "%d%m%y06" )
        daymimutes  <- data.frame(
            Date = seq( as.POSIXct(paste(as.Date(theday), "00:00:30")),
                        as.POSIXct(paste(as.Date(theday), "23:59:30")), by = "min"  )
        )
        daydata     <- rawdata[ as.Date(Date) == as.Date(theday) ]
        daydata     <- merge(daydata, daymimutes, all = T)
        pbcount     <- pbcount + 1

        ## break morning-evening
        maxElev         <- max( daydata$Elevat, na.rm = T)
        day_noon        <- daydata$Date[ daydata$Elevat == maxElev ]
        daydata$preNoon <- daydata$Date <= day_noon

        ## gather all data!!
        gather          <- rbind(gather, daydata)


        ####    Normal plots    ################################################
        pdf(file = paste0(tmpfolder,"/daily_", sprintf("%05d.pdf", pbcount)), )
            ## fix plot range
            withdark <- daydata$CM21value * daydata$CM21CF
            dddd = min(daydata$wattGLB, daydata$wattGLB_SD, withdark , na.rm = TRUE)
            uuuu = max(daydata$wattGLB, daydata$wattGLB_SD, withdark , na.rm = TRUE)
            if (dddd > -5  ) { dddd = 0  }
            if (uuuu < 190 ) { uuuu = 200}
            ylim = c(dddd , uuuu)

            plot(daydata$Date, withdark,
                 "l", xlab = "UTC", ylab = expression(W / m^2),
                 col  = "darkgreen", lwd = 1.1, lty = 1, xaxt = "n", ylim = ylim, xaxs = "i" )

            lines(daydata$Date, daydata$wattGLB, col = "green", lwd = 2)

            abline(h = 0, col = "gray60")
            abline(v   = axis.POSIXct(1, at = pretty(daydata$Date, n = 12, min.n = 8 ), format = "%H:%M" ),
                   col = "lightgray", lty = "dotted", lwd = par("lwd"))
            points(daydata$Date, daydata$wattGLB_SD, pch = ".", cex = 2, col = "red" )
            title( main = paste(test, format(daydata$Date[1] , format = "  %F")))
            text(daydata$Date[1], uuuu, labels = tag, pos = 4, cex =.8 )

            legend("topright", bty = "n",
                   legend = c("Global Irradiance no dark corr.",
                              "Global Irradiance with dark cor.",
                              "Standard Deviation"),
                   lty = c(1,1,NA), pch = c(NA,NA,"."),
                   col = c("darkgreen", "green", "red"), cex = 0.8,)

        dev.off()

    }##END loop of days


    ####    Save data for this year    #########################################
    write_RDS(object = gather,
              file   = paste0(GLOBAL_DIR,"/LAP_CM21_H_L0_", yyyy, ".Rds"))


    ## create pdf with all daily plots
    system(paste0("pdftk ", tmpfolder, "/daily*.pdf cat output ",
                  paste0(DAILYgrDIR,"Daily_GHI_L0_",yyyy,".pdf")),
           ignore.stderr = T )


    ####    Yearly plots    ####################################################

    ##  Add time column (same date with original times)
    dummytimes     <-  strftime(   gather$Date, format = "%H:%M:%S")
    gather$Times   <-  as.POSIXct( dummytimes,  format = "%H:%M:%S")

    par(mar = c(2,4,2,1))
    plot(gather$Times, gather$wattGLB,
         pch = ".", cex = 1.5, ylab = expression(W / m^2) , xlab = "",
         main = paste(yyyy, "Global" ))
    cat("\n\n")


    plot(gather$Date, gather$wattGLB, pch = 19, cex = 0.5,
         xlab = "", ylab = expression(W / m^2),
         main = paste("Global radiation", yyyy))
    cat("\n\n")


    plot(gather$Elevat, gather$wattGLB, pch = 19, cex = 0.5,
         xlab = "", ylab = expression(W / m^2),
         main = paste("Global radiation", yyyy))
    cat("\n\n")


    plot(gather$Azimuth, gather$wattGLB, pch = 19, cex = 0.5,
         xlab = "", ylab = expression(W / m^2),
         main = paste("Global radiation", yyyy))
    cat("\n\n")


    par(mar = c(4,4,2,1))
    morning  <-   gather$preNoon & gather$Elevat > elevlim
    evening  <- ! gather$preNoon & gather$Elevat > elevlim

    plot(  gather$Elevat[morning], gather$wattGLB[morning], pch = ".", cex = 1.5, col = "blue",
           main = paste(yyyy, "Global " ), ylab = expression(W / m^2), xlab = expression("Elevation [°]"))
    points(gather$Elevat[evening], gather$wattGLB[evening], pch = ".", cex = 1.5,  col = "green")
    legend("topleft", legend = c("Before noon", "After noon"),
           bty="n" ,text.col = c("blue", "green"), cex = 1)
    cat("\n\n")


    hist(gather$wattGLB[ gather$wattGLB > wattlimit],
         main = paste(yyyy, "Global ", "radiation > ",wattlimit),
         breaks = 40 , las=1, probability =  T, xlab = expression(W / m^2))
    lines(density(gather$wattGLB, na.rm = T) , col ="green" , lwd = 2)
    cat("\n\n")


    hist(gather$wattGLB_SD,
         main = paste(yyyy, "Global standard deviation "),
         breaks = 40 , las=1, probability =  T, xlab = expression(W / m^2))
    # lines(density(gather$wattGLB_SD, na.rm = T) , col ="green" , lwd = 2)
    cat("\n\n")



    par(mar = c(2,4,2,1))
    week_vec = strftime(  gather$Date , format = "%W")
    sunnupp = gather$Elevat >= 0


    boxplot(gather$wattGLB[sunnupp] ~ week_vec[sunnupp] )
    title(main = paste(yyyy, "Global irradiance (Elevation > 0)"))
    cat("\n\n")


    boxplot(gather$wattGLB_SD[sunnupp] ~ week_vec[sunnupp] )
    title(main = paste(yyyy, "Global standard deviation (Elevation > 0)"))
    cat("\n\n")


    boxplot(gather[sunnupp, CM21value - CM21valueWdark  ] ~ week_vec[sunnupp],
            ylab = "")
    title(main = paste(yyyy, "CM21 dark offset (Elevation > 0)"))
    cat("\n\n")



}
#+ include=T, echo=F


##TODO
## drop data at next level
## copy filters from here and Aerosols for level 1




#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
