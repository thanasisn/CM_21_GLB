# /* !/usr/bin/env Rscript */
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */
#' ---
#' title:         "CM21 signal filtering."
#' author:        "Natsis Athanasios"
#' institute:     "AUTH"
#' affiliation:   "Laboratory of Atmospheric Physics"
#' abstract:      "Read signal data and write level 0 data.
#'                 Marks or remove problematic data."
#' documentclass: article
#' classoption:   a4paper,oneside
#' fontsize:      11pt
#' geometry:      "left=0.5in,right=0.5in,top=0.5in,bottom=0.5in"
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
#'     fig_width:  8
#'     fig_height: 5
#'   html_document:
#'     toc:        true
#'     fig_width:  7.5
#'     fig_height: 5
#' date: "`r format(Sys.time(), '%F')`"
#' params:
#'    ALL_YEARS: TRUE
#' ---

#+ echo=F, include=T


####_  Document options _####

knitr::opts_chunk$set(comment    = ""      )

# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"   )
knitr::opts_chunk$set(out.width  = "100%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )


####_ Notes _####

#
#
# Read all yearly data and create
# database of all data
# pdf of all days
# pdf of suspects
# statistic on days
#
#
# -  FILTERING   std > value
# -  CONVERTING  total irradiance
# -  FILTERING   too low global value
#






####  Set environment  ####
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n\n")
                            return("CM21_R20_") })
if(!interactive()) {
    pdf(  file = paste0("~/CM_21_GLB/REPORTS/RUNTIME/", basename(sub("\\.R$",".pdf", Script.Name))))
    sink( file = paste0("~/CM_21_GLB/REPORTS/RUNTIME/", basename(sub("\\.R$",".out", Script.Name))), split=TRUE)
    filelock::lock(sub("\\.R$",".lock", Script.Name), timeout = 0)
}




## FIXME this is for pdf output
options(warn=-1)

#+ echo=F, include=F
library(RAerosols,  quietly = T, warn.conflicts = F)
library(data.table, quietly = T, warn.conflicts = F)
library(pander,     quietly = T, warn.conflicts = F)
library(myRtools,   quietly = T, warn.conflicts = F)
source("~/CM_21_GLB/CM21_functions.R")
#'

####  . . Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")


tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))

## Standard deviation filter (apply after other filters)
STD_ret_ap_for = 10   ## apply rule when there are enough data points
STD_relMAX     =  1   ## Standard deviation can not be > STD_relMAX * MAX(daily value)


## PATHS
missfiles  <- paste0(BASED, "LOGS/", basename(Script.Name),"_missingfilelist.dat" )
tmpfolder  <- paste0("/dev/shm/", sub(pattern = "\\..*", "" , basename(Script.Name)))
dailyplots <- paste0(BASED,"/REPORTS/", sub(pattern = "\\..*", "" , basename(Script.Name)), "_daily.pdf")
daylystat  <- paste0(dirname(GLOBAL_DIR), "/", sub(pattern = "\\..*", "", basename(Script.Name)), "_stats")



# datafile    = paste0(DATOUT, "/P02_allcm21data" )
# daylystat   = paste0(DATOUT, "/P02_allcm21stat" )




TEST      = TRUE
TEST      = FALSE



## . get data input files ####
input_files <- list.files( path    = SIGNAL_DIR,
                           pattern = "LAP_CM21_H_S0_[0-9]{4}.Rds",
                           full.names = T )
input_files <- sort(input_files)

## Keep record of dark signal
if (file.exists(DARKSTORE)) {
    darkDT <- readRDS(DARKSTORE)
} else {
    darkDT <- data.table()
}


#test
# input_files <- grep("2015",input_files, value = T)


#'
#' ## Info
#'
#' Apply more filtering on the data and do a first dark calculation.
#' Daily plot with GHI and dark signal are in the file: "`r basename(dailyplots)`" .
#'
#' ### Apply variation filtering.
#'
#' Exclude from daily data values where signals standard deviation > `r STD_relMAX` * max(daily signal).
#'
#' ### Covert signal to global irradiance.
#'
#' The conversion is done with a factor which is interpolated between CM-21 calibrations.
#'
#' ### Filter minimum Global irradiance.
#'
#' Reject data when GHI is below an acceptable limit.
#' Before `r BREAKDATE` we use `r GLB_LOW_LIM_01`,
#' after  `r BREAKDATE` we use `r GLB_LOW_LIM_02`.
#' This is due to changes in instrumentation.
#'



## loop all input files

statist <- data.table()
pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files) {

    ## create a new temp dir
    unlink(tmpfolder, recursive = TRUE)
    dir.create(tmpfolder)


    #### Get raw data ####
    rawdata        <- readRDS(afile)
    rawdata$day    <- as.Date(rawdata$Date)
    NR_loaded      <- rawdata[ !is.na(CM21value), .N ]

    ## drop NA signal
    rawdata        <- rawdata[ !is.na(CM21value) ]

    daystodo <- unique( rawdata$day )

    if (TEST) { daystodo <- sort(sample(daystodo,20)) }

    ## init yearly calculations
    globaldata    <- data.table()
    NR_extreme_SD = 0
    NR_min_global = 0


    yyyy    <- year(rawdata$day[1])
    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))




    for (ddd in daystodo) {

        theday      <- as.POSIXct( as.Date(ddd, origin = "1970-01-01"))
        test        <- format( theday, format = "%d%m%y06" )
        dayCMCF     <- cm21factor(theday)

        pbcount     <- pbcount + 1
        day         <- data.frame()

        daymimutes  <- data.frame(
            Date = seq( as.POSIXct(paste(as.Date(theday), "00:00:30")),
                        as.POSIXct(paste(as.Date(theday), "23:59:30")), by = "min"  )
        )

        ## choose GLB_LOW_LIM by date
        if ( theday  < BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_01 }
        if ( theday >= BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_02 }


        ## get valid day data

        ## all vars
        wholeday    <- rawdata[ day == as.Date(theday) ]
        ## only valid data
        daydata     <- rawdata[ day == as.Date(theday) & is.na(QFlag_1) ]


        # stopifnot(wholeday[! is.na(QFlag_1), .N ]==0)


        ## fill all minutes for nicer graphs
        daydata     <- merge(daydata, daymimutes, all = T)
        daydata$day <- as.Date(daydata$Date)


        ####  Filter Standard deviation extremes  ##############################
        ## SD can not be greater than the signal
        pre_count     <- daydata[ !is.na(CM21value), .N ]
        ## apply rule if there are enough data
        if (pre_count > STD_ret_ap_for) {
            daydata       <- daydata[ CM21sd < STD_relMAX * max(CM21value, na.rm = T) ]
            NR_extreme_SD <- NR_extreme_SD + pre_count - daydata[ !is.na(CM21value), .N ]
            if (nrow(daydata[ !is.na(CM21value) ]) < 1) {
                cat('\n')
                cat(paste(theday, "SKIP DAY: No data after extreme SD filtering!!"),"\n")
                next()
            }
        }
        ########################################################################




        ####    Calculate Dark signal   ########################################
        dark_day <- dark_calculations( dates      = daydata$Date,
                                       values     = daydata$CM21value,
                                       elevatio   = daydata$Eleva,
                                       nightlimit = DARK_ELEV,
                                       dstretch   = DSTRETCH)

        if ( is.na(dark_day$Mmed) & is.na(dark_day$Emed) ) {
            # cat("Can not apply dark\n")
            todays_dark_correction <- NA
            dark_day <- NA
        } else {

            ####    Dark Correction function   #####################################
            dark_generator <- dark_function(dark_day    = dark_day,
                                            DCOUNTLIM   = DCOUNTLIM,
                                            type        = "median",
                                            adate       = theday ,
                                            test        = test,
                                            missfiles   = missfiles,
                                            missingdark = NA )


            ####    Create dark signal for correction    ###########################
            todays_dark_correction <- dark_generator(daydata$Date)


            ####    Apply dark correction    #######################################
            daydata[, CM21valueWdark := CM21value  -  todays_dark_correction ]



            # # # #        ##TODO move that ####
            # # # #
            # # # #        ####  Convert to irradiance  ###########################################
            # # # #        daydata$Global <- daydata$CM21value * dayCMCF
            # # # #        daydata$GLstd  <- daydata$CM21sd    * dayCMCF
            # # # #        ########################################################################
            # # # #
            # # # #
            # # # #
            # # # #        #### Filter too low Global values  #####################################
            # # # #        pre_count     <- daydata[ !is.na(CM21value), .N ]
            # # # #        daydata       <- daydata[ Global >= GLB_LOW_LIM ]
            # # # #        NR_min_global <- NR_min_global + pre_count - daydata[ !is.na(CM21value), .N ]
            # # # #        ########################################################################




            ## plot to external pdf
            pdf(file = paste0(tmpfolder,"/daily_", sprintf("%05d.pdf", pbcount)), )
            if (any(grepl( "CM21valueWdark", names(daydata)))) {
                somedata <- daydata[ Elevat < 1 ]
                ylim <- range(somedata$CM21valueWdark, somedata$CM21value)
                plot(  somedata$Date, somedata$CM21value,     pch=19,cex=0.5,
                       ylab = "CHP1 Signal V", xlab = "", ylim = ylim)
                points(somedata$Date, somedata$CM21valueWdark,pch=19,cex=0.5, col = "blue")
                abline(h=0,col="orange")
                title(main = paste(test, format(daydata$Date[1] , format = "  %F")))
            }
            dev.off()

        }

        ####    Day stats    ###################################################
        day = data.frame(Date    = theday,
                         CMCF    = dayCMCF,
                         NAs     = sum(is.na(daydata$CM21value)),
                         SunUP   = sum(      daydata$Eleva >= 0 ),
                         Dmean   = mean(     todays_dark_correction,na.rm = T),
                         sunMeas = sum(      daydata$Eleva >= 0 &
                                                 !is.na(daydata$CM21value)),
                         CalcDate = Sys.time()
        )
        darkDT <- rbind( darkDT, cbind(day, dark_day), fill=T)



        ####    Get processed and unprocessed data    ##########################
        daydata   <- merge( daydata, wholeday,
                            by = intersect(names(daydata),names(wholeday)), all = T)

        globaldata <- rbind( globaldata, daydata, fill = TRUE )


        rm( theday, dayCMCF, todays_dark_correction, dark_line, day, daydata )

    } #END loop of days

    ## write this years data
    write_RDS(object = globaldata,
              file   = paste0(SIGNAL_DIR,"/LAP_CM21_H_S1_",yyyy,".Rds") )




    ## create pdf with all daily plots
    system( paste0("pdftk ", tmpfolder, "/daily*.pdf cat output ", paste0(DAILYgrDIR,"CM21_dark_daily_",yyyy,".pdf")) )


if(FALSE){
    tempout <- data.frame()

    tempout <- rbind( tempout, data.frame(Name = "Initial data",      Data_points = NR_loaded) )
    tempout <- rbind( tempout, data.frame(Name = "SD limit",          Data_points = NR_extreme_SD) )
    tempout <- rbind( tempout, data.frame(Name = "Minimum GHI limit", Data_points = NR_min_global) )
    tempout <- rbind( tempout, data.frame(Name = "Remaining data",    Data_points = globaldata[ !is.na(CM21value), .N ]) )

    panderOptions('table.alignment.default', 'right')
    panderOptions('table.split.table',        120   )

    cat('\\scriptsize\n')

    # cat('\\footnotesize\n')

    cat(pander( tempout ))

    cat(pander( summary(globaldata[,!c("Date","Azimuth")]) ))

    cat('\\normalsize\n')

    cat('\n')

    hist(globaldata$CM21value, breaks = 50, main = paste("CM21 GHI ", yyyy ) )

    hist(globaldata$CM21sd,    breaks = 50, main = paste("CM21 GHI SD", yyyy ) )

    plot(globaldata$Elevat, globaldata$Global, pch = 19, cex = .8,
         main = paste("CM21 GHI ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 GHI" )

    plot(globaldata$Elevat, globaldata$GLstd,    pch = 19, cex = .8,
         main = paste("CM21 GHI SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 GHI Standard Deviations")

    cat('\n')
    cat('\n')
}





}
#'


stop()
## write statistics on data
# capture.output(
#     myRtools::write_RDS(statist, daylystat),
#     file = "/dev/null" )




#'
#' ## Summary of daily statistics.
#'


hist(statist$NAs,     main = "NAs",                  breaks = 50, xlab = "NA count" )
hist(statist$MinVa,   main = "Minimum Value",        breaks = 50, xlab = "Min daily signal"  )
hist(statist$MaxVa,   main = "Maximum Value",        breaks = 50, xlab = "Max daily signal"  )
hist(statist$AvgVa,   main = "Average Value",        breaks = 50, xlab = "Mean daily signal"  )
hist(statist$MinGL,   main = "Minimum Global",       breaks = 50, xlab = "Min daily global" )
hist(statist$MaxGL,   main = "Maximum Global",       breaks = 50, xlab = "Max daily global" )
hist(statist$AvgGL,   main = "Average Global",       breaks = 50, xlab = "Mean daily global" )
hist(statist$sunMeas, main = "Sun measurements",     breaks = 50, xlab = "Data count with sun up"  )
hist(statist$Mavg,    main = "Morning Average Dark", breaks = 50, xlab = "Morning mean dark"           )
hist(statist$Mmed,    main = "Morning Median Dark",  breaks = 50, xlab = "Morning median dark"         )
hist(statist$Mcnt,    main = "Morning count Dark",   breaks = 50, xlab = "Morning data count for dark" )
hist(statist$Eavg,    main = "Evening Average Dark", breaks = 50, xlab = "Evening mean dark"           )
hist(statist$Emed,    main = "Evening Median Dark",  breaks = 50, xlab = "Evening median dark"         )
hist(statist$Ecnt,    main = "Evening count Dark",   breaks = 50, xlab = "Evening data count for dark" )


plot(statist$Date, statist$CMCF,    "p", pch = 16, cex = .5, main = "Conversion factor"    , xlab = "" )
plot(statist$Date, statist$NAs,     "p", pch = 16, cex = .5, main = "NA count"             , xlab = "" )
plot(statist$Date, statist$MinVa,   "p", pch = 16, cex = .5, main = "Minimum Value"        , xlab = "" )
plot(statist$Date, statist$MaxVa,   "p", pch = 16, cex = .5, main = "Maximum Value"        , xlab = "" )
plot(statist$Date, statist$AvgVa,   "p", pch = 16, cex = .5, main = "Average Value"        , xlab = "" )
plot(statist$Date, statist$MinGL,   "p", pch = 16, cex = .5, main = "Minimum Global"       , xlab = "" )
plot(statist$Date, statist$MaxGL,   "p", pch = 16, cex = .5, main = "Maximum Global"       , xlab = "" )
plot(statist$Date, statist$AvgGL,   "p", pch = 16, cex = .5, main = "Average Global"       , xlab = "" )
plot(statist$Date, statist$sunMeas, "p", pch = 16, cex = .5, main = "Sun measurements"     , xlab = "" )
plot(statist$Date, statist$Mavg,    "p", pch = 16, cex = .5, main = "Morning Average Dark" , xlab = "" )
plot(statist$Date, statist$Mmed,    "p", pch = 16, cex = .5, main = "Morning Median Dark"  , xlab = "" )
plot(statist$Date, statist$Mcnt,    "p", pch = 16, cex = .5, main = "Morning count Dark"   , xlab = "" )
plot(statist$Date, statist$Eavg,    "p", pch = 16, cex = .5, main = "Evening Average Dark" , xlab = "" )
plot(statist$Date, statist$Emed,    "p", pch = 16, cex = .5, main = "Evening Median Dark"  , xlab = "" )
plot(statist$Date, statist$Ecnt,    "p", pch = 16, cex = .5, main = "Evening count Dark"   , xlab = "" )
plot(statist$Date, statist$sunMeas/statist$SunUP , "p", pch=16,cex=.5, main = "Sun up measurements / Sun up count" , xlab = "" )


#'
#' ### Days with average global < -50 .
#'
unique( as.Date( statist$Date[ which(statist$AvgGL < -50 ) ] ) )

#'
#' ### Days with average global > 390 .
#'
unique( as.Date( statist$Date[ which(statist$AvgGL > 390 ) ] ) )

# plot(statist$Date[statist$MaxGL<2000], statist$MaxGL[statist$MaxGL<2000], "p", pch=16,cex=.5 )

#'
#' ### Days with max global > 1500 .
#'
unique( as.Date( statist$Date[ which(statist$MaxGL > 1500 ) ] ) )


# plot(statist$Date[statist$MinGL>-200], statist$MinGL[statist$MinGL>-200], "p", pch=16,cex=.5 )
# plot(statist$Date[statist$MinGL<200], statist$MinGL[statist$MinGL<200], "p", pch=16,cex=.5 )


#'
#' ### Days with min global < -200 .
#'
unique( as.Date( statist$Date[ which(statist$MinGL < -200 ) ] ) )

#'
#' ### Days with min global > 200 .
#'
unique( as.Date( statist$Date[ which(statist$MinGL > 200 ) ] ) )


# plot(statist$Date[statist$Ecnt>100], statist$Ecnt[statist$Ecnt>100] , "p", pch=16,cex=.5 )


#'
#' ### Days with Evening dark data points count < 100 .
#'
unique( as.Date( statist$Date[ which(statist$Ecnt < 100 ) ] ) )

#'
#' ### Days with Morning dark data points count < 50 .
#'
unique( as.Date( statist$Date[ which(statist$Mcnt < 50 ) ] ) )


# plot(statist$Date[statist$sunMeas<100], statist$sunMeas[statist$sunMeas<100]  , "p", pch=16,cex=.5 )


#'
#' ### Days with ( sun  measurements / sun up ) < 0.2 .
#'
unique( as.Date( statist$Date[ which(statist$sunMeas/statist$SunUP < .20 ) ] ) )


#'
#' ### Day with the minimum morning median dark .
#'

statist$Date[ which.min( statist$Mmed ) ]



#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
