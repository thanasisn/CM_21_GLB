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
#'     fig_width:        6
#'     fig_height:       4
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
# options(warn=-1) ## hide warnigs
# options(warn=2)  ## stop on warnigs

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

####  Execution control  ####
ALL_YEARS = FALSE
ALL_YEARS = TRUE

if (!exists("params")){
    params <- list( ALL_YEARS = ALL_YEARS)
}

tag <- paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


## PATHS
tmpfolder  = paste0("/dev/shm/", sub(pattern = "\\..*", "" , basename(Script.Name)))
dailyplots = paste0(BASED,"/REPORTS/", sub(pattern = "\\..*", "" , basename(Script.Name)), "_daily.pdf")
daylystat  = paste0(dirname(GLOBAL_DIR), "/", sub(pattern = "\\..*", "" , basename(Script.Name)),"_stats")







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





## loop all input files

statist <- data.table()
pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for ( yyyy in years_to_do) {
    cat("\n\\FloatBarrier\n\n")
    cat("\\newpage\n\n")
    cat("\n## Year:", yyyy, "\n\n" )

    ####  Get raw data
    afile    <- grep(yyyy, input_files,  value = T)
    rawdata  <- readRDS(afile)

    ####  Generate conversion factor
    rawdata[ , CM21CF := cm21factor(Date) ]

    ####  Check dark conditions
    if (rawdata[ is.na(CM21valueWdark), .N ] != 0) {
        cat("\n**There are missing dark correction values!!!!**\n\n")
    }

    ####  Convert to physical values  ####
    rawdata[ , wattGLB    := CM21CF * CM21valueWdark ]
    rawdata[ , wattGLB_SD := CM21CF * CM21sd         ]




    ##TODO convert to watt
    ## same names as before
    ## dark and no dark
    ## drop data at next level
    ## see old files
    ## copy filters from here and Aerosols for level 1



    plot(rawdata$Date, rawdata$CM21CF,"l",
         xlab = "", ylab = "", main = paste("Conversion factor", yyyy))

    plot(rawdata$Date, rawdata$wattGLB, pch = 19, cex = 0.5,
         xlab = "", ylab = "", main = paste("Global radiation", yyyy))




#     daystodo    <- unique( rawdata$day )
#
#     ##TODO continue from here
#
#
#     ## init yearly calculations
#     globaldata    <- data.table()
#     NR_extreme_SD = 0
#     NR_min_global = 0
#
#


    # # # #    #' ### Covert signal to global irradiance.
    # # # #    #'
    # # # #    #' The conversion is done with a factor which is interpolated between CM-21 calibrations.
    # # # #    #'
    # # # #    #' ### Filter minimum Global irradiance.
    # # # #    #'
    # # # #    #' Reject data when GHI is below an acceptable limit.
    # # # #    #' Before `r BREAKDATE` we use `r GLB_LOW_LIM_01`,
    # # # #    #' after  `r BREAKDATE` we use `r GLB_LOW_LIM_02`.
    # # # #    #' This is due to changes in instrumentation.

    # # # #    ##TODO move that ####
    # # # #
    # # # #     ## choose GLB_LOW_LIM by date
    # # # #     if ( theday  < BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_01 }
    # # # #     if ( theday >= BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_02 }
    # # # #
    # # # #
    # # # #    ####  Convert to irradiance  ###########################################
    # # # #    daydata$Global <- daydata$CM21value * dayCMCF
    # # # #    daydata$GLstd  <- daydata$CM21sd    * dayCMCF
    # # # #    ########################################################################
    # # # #
    # # # #
    # # # #
    # # # #    #### Filter too low Global values  #####################################
    # # # #    pre_count     <- daydata[ !is.na(CM21value), .N ]
    # # # #    daydata       <- daydata[ Global >= GLB_LOW_LIM ]
    # # # #    NR_min_global <- NR_min_global + pre_count - daydata[ !is.na(CM21value), .N ]
    # # # #    ########################################################################



#
#     for (ddd in daystodo) {
#
#         theday      <- as.POSIXct( as.Date(ddd), origin = "1970-01-01")
#         test        <- format( theday, format = "%d%m%y06" )
#         dayCMCF     <- cm21factor(theday)
#
#         pbcount     <- pbcount + 1
#         day         <- data.frame()
#
#         daymimutes  <- data.frame(
#             Date = seq( as.POSIXct(paste(as.Date(ddd), "00:00:30")),
#                         as.POSIXct(paste(as.Date(ddd), "23:59:30")), by = "min"  )
#         )
#
#         ## choose GLB_LOW_LIM by date
#         if ( theday  < BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_01 }
#         if ( theday >= BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_02 }
#
#
#         ## get daily data
#         daydata     <- rawdata[ day == as.Date(theday) ]
#         ## add all minutes for nicer graphs
#         daydata     <- merge(daydata, daymimutes, all = T)
#         daydata$day <- as.Date(daydata$Date)
#
#
#
#         ####  Re-Convert to irradiance  ########################################
#         ## This will reset the previus dark correction
#         daydata$Global <- daydata$CM21value * dayCMCF
#         daydata$GLstd  <- daydata$CM21sd    * dayCMCF
#         ########################################################################
#
#
#
#         ####  Filter too low Global values  ####################################
#         pre_count     <- daydata[ !is.na(CM21value), .N ]
#         daydata       <- daydata[ Global >= GLB_LOW_LIM ]
#         NR_min_global <- NR_min_global + pre_count - daydata[ !is.na(CM21value), .N ]
#         ########################################################################
#
#
#
#
#
#
#
#
#
#         pdf(file = paste0(tmpfolder,"/daily_", sprintf("%05d.pdf", pbcount)))
#             plot_norm2(daydata, test, tag)
#
#
#         dev.off()
#
#
#
#         ## keep some statistics
#         day   <- data.frame(Date    = theday,
#                             CMCF    = dayCMCF,
#                             NAs     = sum(is.na(daydata$Global)),
#                             SunUP   = sum(  daydata$Eleva >= 0 ),
#                             MinVa   = min(  daydata$CM21value, na.rm = T),
#                             MaxVa   = max(  daydata$CM21value, na.rm = T),
#                             AvgVa   = mean( daydata$CM21value, na.rm = T),
#                             MinGL   = min(  daydata$Global,    na.rm = T),
#                             MaxGL   = max(  daydata$Global,    na.rm = T),
#                             AvgGL   = mean( daydata$Global,    na.rm = T),
#                             Dmean   = mean( todaysdark,        na.rm = T),
#                             sunMeas = sum(daydata$Eleva >= 0 & !is.na(daydata$Global)),
#                             Mavg    = dark_day$Mavg,
#                             Mmed    = dark_day$Mmed,
#                             Msta    = dark_day$Msta,
#                             Mend    = dark_day$Mend,
#                             Mcnt    = dark_day$Mcnt,
#                             Eavg    = dark_day$Eavg,
#                             Emed    = dark_day$Emed,
#                             Esta    = dark_day$Esta,
#                             Eend    = dark_day$Eend,
#                             Ecnt    = dark_day$Ecnt
#         )
#
#         ## gather data
#         globaldata <- rbind( globaldata, daydata )
#
#         ## gather day statistics
#         statist    <- rbind(statist, day )
#
#         rm( theday, dayCMCF, todaysdark, dark_line, day, daydata )
#
#     } #END loop of days
#
#
#     tempout <- data.frame()
#     yyyy    <- year(globaldata$day[1])
#
#     cat(paste("\\newpage\n\n"))
#     cat(paste("## ",yyyy,"\n\n"))
#
#     tempout <- rbind( tempout, data.frame(Name = "Initial data",      Data_points = NR_loaded) )
#     tempout <- rbind( tempout, data.frame(Name = "SD limit",          Data_points = NR_extreme_SD) )
#     tempout <- rbind( tempout, data.frame(Name = "Minimum GHI limit", Data_points = NR_min_global) )
#     tempout <- rbind( tempout, data.frame(Name = "Remaining data",    Data_points = globaldata[ !is.na(CM21value), .N ]) )
#
#     panderOptions('table.alignment.default', 'right')
#     panderOptions('table.split.table',        120   )
#
#     cat('\\scriptsize\n')
#
#     # cat('\\footnotesize\n')
#
#     cat(pander( tempout ))
#
#     cat(pander( summary(globaldata[,!c("Date","Azimuth")]) ))
#
#     cat('\\normalsize\n')
#
#     cat('\n')
#
#     hist(globaldata$CM21value, breaks = 50, main = paste("CM21 GHI ", yyyy ) )
#
#     hist(globaldata$CM21sd,    breaks = 50, main = paste("CM21 GHI SD", yyyy ) )
#
#     plot(globaldata$Elevat, globaldata$Global, pch = 19, cex = .8,
#          main = paste("CM21 GHI ", yyyy ),
#          xlab = "Elevation",
#          ylab = "CM21 GHI" )
#
#     plot(globaldata$Elevat, globaldata$GLstd,    pch = 19, cex = .8,
#          main = paste("CM21 GHI SD", yyyy ),
#          xlab = "Elevation",
#          ylab = "CM21 GHI Standard Deviations")
#
#     cat('\n')
#     cat('\n')
#
#     # write this years data
#     capture.output(
#         RAerosols::write_RDS(globaldata, paste0( GLOBAL_DIR , sub("_L1", "_L2", basename(afile)))),
#         file = "/dev/null" )

}
#'

# ## write statistics on data
# capture.output(
#     RAerosols::write_RDS(statist, daylystat),
#     file = "/dev/null" )
#
# ## create pdf with all daily plots
# # system( paste0("pdftk ", tmpfolder, "/daily*.pdf cat output ", dailyplots) )
#
#
#
# #'
# #' ## Summary of daily statistics.
# #'
#
#
# hist(statist$NAs,     main = "NAs",                  breaks = 50, xlab = "NA count"            )
# hist(statist$MinVa,   main = "Minimum Value",        breaks = 50, xlab = "Min daily signal"    )
# hist(statist$MaxVa,   main = "Maximum Value",        breaks = 50, xlab = "Max daily signal"    )
# hist(statist$AvgVa,   main = "Average Value",        breaks = 50, xlab = "Mean daily signal"   )
# hist(statist$MinGL,   main = "Minimum Global",       breaks = 50, xlab = "Min daily global"    )
# hist(statist$MaxGL,   main = "Maximum Global",       breaks = 50, xlab = "Max daily global"    )
# hist(statist$AvgGL,   main = "Average Global",       breaks = 50, xlab = "Mean daily global"     )
# hist(statist$sunMeas, main = "Sun measurements",     breaks = 50, xlab = "Data count with sun up"     )
# hist(statist$Mavg,    main = "Morning Average Dark", breaks = 50, xlab = "Morning mean dark"           )
# hist(statist$Mmed,    main = "Morning Median Dark",  breaks = 50, xlab = "Morning median dark"         )
# hist(statist$Mcnt,    main = "Morning count Dark",   breaks = 50, xlab = "Morning data count for dark" )
# hist(statist$Eavg,    main = "Evening Average Dark", breaks = 50, xlab = "Evening mean dark"           )
# hist(statist$Emed,    main = "Evening Median Dark",  breaks = 50, xlab = "Evening median dark"         )
# hist(statist$Ecnt,    main = "Evening count Dark",   breaks = 50, xlab = "Evening data count for dark" )
#
#
# plot(statist$Date, statist$CMCF,    "p", pch = 16, cex = .5, main = "Conversion factor"    , xlab = "" )
# plot(statist$Date, statist$NAs,     "p", pch = 16, cex = .5, main = "NA count"             , xlab = "" )
# plot(statist$Date, statist$MinVa,   "p", pch = 16, cex = .5, main = "Minimum Value"        , xlab = "" )
# plot(statist$Date, statist$MaxVa,   "p", pch = 16, cex = .5, main = "Maximum Value"        , xlab = "" )
# plot(statist$Date, statist$AvgVa,   "p", pch = 16, cex = .5, main = "Average Value"        , xlab = "" )
# plot(statist$Date, statist$MinGL,   "p", pch = 16, cex = .5, main = "Minimum Global"       , xlab = "" )
# plot(statist$Date, statist$MaxGL,   "p", pch = 16, cex = .5, main = "Maximum Global"       , xlab = "" )
# plot(statist$Date, statist$AvgGL,   "p", pch = 16, cex = .5, main = "Average Global"       , xlab = "" )
# plot(statist$Date, statist$sunMeas, "p", pch = 16, cex = .5, main = "Sun measurements"     , xlab = "" )
# plot(statist$Date, statist$Mavg,    "p", pch = 16, cex = .5, main = "Morning Average Dark" , xlab = "" )
# plot(statist$Date, statist$Mmed,    "p", pch = 16, cex = .5, main = "Morning Median Dark"  , xlab = "" )
# plot(statist$Date, statist$Mcnt,    "p", pch = 16, cex = .5, main = "Morning count Dark"   , xlab = "" )
# plot(statist$Date, statist$Eavg,    "p", pch = 16, cex = .5, main = "Evening Average Dark" , xlab = "" )
# plot(statist$Date, statist$Emed,    "p", pch = 16, cex = .5, main = "Evening Median Dark"  , xlab = "" )
# plot(statist$Date, statist$Ecnt,    "p", pch = 16, cex = .5, main = "Evening count Dark"   , xlab = "" )
# plot(statist$Date, statist$sunMeas/statist$SunUP , "p", pch=16,cex=.5, main = "Sun up measurements / Sun up count" , xlab = "" )
#
#
# #'
# #' ### Days with average global < -50 .
# #'
# unique( as.Date( statist$Date[ which(statist$AvgGL < -50 ) ] ) )
#
# #'
# #' ### Days with average global > 390 .
# #'
# unique( as.Date( statist$Date[ which(statist$AvgGL > 390 ) ] ) )
#
# # plot(statist$Date[statist$MaxGL<2000], statist$MaxGL[statist$MaxGL<2000], "p", pch=16,cex=.5 )
#
# #'
# #' ### Days with max global > 1500 .
# #'
# unique( as.Date( statist$Date[ which(statist$MaxGL > 1500 ) ] ) )
#
#
# # plot(statist$Date[statist$MinGL>-200], statist$MinGL[statist$MinGL>-200], "p", pch=16,cex=.5 )
# # plot(statist$Date[statist$MinGL<200], statist$MinGL[statist$MinGL<200], "p", pch=16,cex=.5 )
#
#
# #'
# #' ### Days with min global < -200 .
# #'
# unique( as.Date( statist$Date[ which(statist$MinGL < -200 ) ] ) )
#
# #'
# #' ### Days with min global > 200 .
# #'
# unique( as.Date( statist$Date[ which(statist$MinGL > 200 ) ] ) )
#
#
# # plot(statist$Date[statist$Ecnt>100], statist$Ecnt[statist$Ecnt>100] , "p", pch=16,cex=.5 )
#
#
# #'
# #' ### Days with Evening dark data points count < 100 .
# #'
# unique( as.Date( statist$Date[ which(statist$Ecnt < 100 ) ] ) )
#
# #'
# #' ### Days with Morning dark data points count < 50 .
# #'
# unique( as.Date( statist$Date[ which(statist$Mcnt < 50 ) ] ) )
#
#
# # plot(statist$Date[statist$sunMeas<100], statist$sunMeas[statist$sunMeas<100]  , "p", pch=16,cex=.5 )
#
#
# #'
# #' ### Days with ( sun  measurements / sun up ) < 0.2 .
# #'
# unique( as.Date( statist$Date[ which(statist$sunMeas/statist$SunUP < .20 ) ] ) )
#
#
# #'
# #' ### Day with the minimum morning median dark .
# #'
#
# statist$Date[ which.min( statist$Mmed ) ]
#
#
# yearlyplots <- list.files( path       = REPORT_DIR,
#                            pattern    = "Daily_GHI_[0-9]{4}.pdf",
#                            full.names = T)
# yearlyplots <- sort(yearlyplots)
#
# FirstYear   <- regmatches(yearlyplots[1], regexpr( "[0-9]{4}", yearlyplots[1] ))
# CurrentYe   <- year(Sys.Date())
# ## ignore current year
# yearlyplots <- grep(paste0("_",CurrentYe,".pdf"), yearlyplots, value = T , invert = T)
# LastYear    <- regmatches(yearlyplots[length(yearlyplots)], regexpr( "[0-9]{4}", yearlyplots[length(yearlyplots)] ))
#
# ## collate pdfs
# system(
#     paste0("pdftk ",
#            paste(yearlyplots, collapse = " "),
#            " cat output ",
#            REPORT_DIR, "Daily_GHI_",FirstYear,"-",LastYear,".pdf" )
# )
# #'


#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
