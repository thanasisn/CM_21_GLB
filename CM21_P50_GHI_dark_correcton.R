# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 daily GHI complete dark correction."
#' author: "Natsis Athanasios"
#' date: "`r format(Sys.time(), '%B %d, %Y')`"
#' keywords: "CM21, CM21 data validation, global irradiance"
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
#'   html_document:
#'     keep_md:          yes
#'   odt_document:  default
#'   word_document: default
#'
#' params:
#'   CACHE: true
#' ---

#+ echo=F, include=T


####_  Document options _####

knitr::opts_chunk$set(echo       = FALSE     )
# knitr::opts_chunk$set(cache      = params$CACHE    )
# knitr::opts_chunk$set(include    = FALSE   )
knitr::opts_chunk$set(include    = TRUE    )
knitr::opts_chunk$set(comment    = ""      )

# pdf output is huge too many point to plot
# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"   )

knitr::opts_chunk$set(fig.width  = 8       )
knitr::opts_chunk$set(fig.height = 6       )

knitr::opts_chunk$set(out.width  = "60%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )


####_ Notes _####

#
# this script substitutes 'CM_P02_Import_Data_wo_bad_days_v3.R'
# and some functionality of 'CM_P02_Explore_Data.R'
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
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P50_GHI_dark_correcton.R")

## FIXME this is for pdf output
# options(warn=-1)

#+ echo=F, include=F
library(data.table, quietly = T)
library(pander,     quietly = T)
# library(RAerosols,  quietly = T)
source("/home/athan/CM_21_GLB/CM21_functions.R")
#'

####  . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")


tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))




## Dark Calculations
DARK_ELEV     = -10         ## sun elevation limit
DSTRETCH      =  20 * 3600  ## time duration of dark signal for morning and evening of the same day
DCOUNTLIM     =  10         ## if dark signal has fewer valid measurements than these ignore it

## PATHS
missfiles  = paste0(BASED, "LOGS/", Script.Name ,"_missingfilelist.dat" )
tmpfolder  = paste0("/dev/shm/", sub(pattern = "\\..*", "" , Script.Name))
dailyplots = paste0(BASED,"/REPORTS/", sub(pattern = "\\..*", "" , Script.Name), "_daily.pdf")
daylystat  = paste0(dirname(GLOBAL_DIR), "/", sub(pattern = "\\..*", "" , Script.Name),"_stats")



# datafile    = paste0(DATOUT, "/P02_allcm21data" )
# daylystat   = paste0(DATOUT, "/P02_allcm21stat" )

## create a new temp dir
unlink(tmpfolder, recursive = TRUE)
dir.create(tmpfolder, showWarnings = FALSE)



TEST      = TRUE
# TEST      = FALSE



## . get data input files ####

input_files <- list.files( path       = GLOBAL_DIR,
                           pattern    = "LAP_CM21H_GHI_[0-9]{4}_L1.Rds",
                           full.names = T )
input_files <- sort(input_files)






#'
#' ## Info
#'
#' Apply dark correction on days with missing dark.
#'



## loop all input files

statist <- data.table()
pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files) {


    #### Get raw data ####
    rawdata     <- readRDS(afile)
    NR_loaded   <- rawdata[ !is.na(CM21value), .N ]

    daystodo    <- unique( rawdata$day )

    ##TODO continue from here
    stop("jjjj")

    if (TEST) { daystodo <- sort(sample(daystodo,20)) }

    ## init yearly calculations
    globaldata    <- data.table()
    NR_extreme_SD = 0
    NR_min_global = 0

    for (ddd in daystodo) {

        theday      <- as.POSIXct( as.Date(ddd), origin = "1970-01-01")
        test        <- format( theday, format = "%d%m%y06" )
        dayCMCF     <- cm21factor(theday)

        pbcount     <- pbcount + 1
        day         <- data.frame()

        daymimutes  <- data.frame(
            Date = seq( as.POSIXct(paste(as.Date(ddd), "00:00:30")),
                        as.POSIXct(paste(as.Date(ddd), "23:59:30")), by = "min"  )
        )

        ## choose GLB_LOW_LIM by date
        if ( theday  < BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_01 }
        if ( theday >= BREAKDATE ) { GLB_LOW_LIM <- GLB_LOW_LIM_02 }


        ## get daily data
        daydata     <- rawdata[ day == as.Date(theday) ]
        ## add all minutes for nicer graphs
        daydata     <- merge(daydata, daymimutes, all = T)
        daydata$day <- as.Date(daydata$Date)



        ####  Filter Standard deviation extremes  ##############################
        pre_count     <- daydata[ !is.na(CM21value), .N ]
        daydata       <- daydata[ CM21sd < STD_relMAX * max(CM21value, na.rm = T) ]
        NR_extreme_SD <- NR_extreme_SD + pre_count - daydata[ !is.na(CM21value), .N ]
        ########################################################################



        ####  Convert to irradiance  ###########################################
        daydata$Global <- daydata$CM21value * dayCMCF
        daydata$GLstd  <- daydata$CM21sd    * dayCMCF
        ########################################################################



        #### Filter too low Global values  #####################################
        pre_count     <- daydata[ !is.na(CM21value), .N ]
        daydata       <- daydata[ Global >= GLB_LOW_LIM ]
        NR_min_global <- NR_min_global + pre_count - daydata[ !is.na(CM21value), .N ]
        ########################################################################



        ####    Calculate Dark    ##################################################
        dark_day <- dark_calculations( dates    = daydata$Date,
                                       values   = daydata$Global,
                                       elevatio = daydata$Eleva,
                                       darklim  = DARK_ELEV,
                                       dstretch = DSTRETCH)

        ####    Dark Correction    #################################################
        dark_line <-  dark_correction(dark_day    = dark_day,
                                      DCOUNTLIM   = DCOUNTLIM,
                                      type        = "median",
                                      dd          = theday ,
                                      test        = test,
                                      missfiles   = missfiles,
                                      missingdark = 0 )

        ####    Create dark signal for correction    ###############################
        todaysdark <- dark_line(daydata$Date)

        ####    Apply dark correction    ###########################################
        daydata$Global  <-  daydata$Global  -  todaysdark




        pdf(file = paste0(tmpfolder,"/daily_", sprintf("%05d.pdf", pbcount)))
            plot_norm2(daydata, test, tag)

            ## Dark signal plot
            if (all(is.na(todaysdark))) {
                ## empty plot when no data
                plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
            } else {
                plot(daydata$Date, todaysdark, "l",xlab = "UTC", ylab = "Dark W/m^2")
                title(main = paste(test, format(daydata$Date[1] , format = "  %F")))
            }
        dev.off()



        ## keep some statistics
        day    = data.frame(Date    = theday,
                            CMCF    = dayCMCF,
                            NAs     = sum(is.na(daydata$Global)),
                            SunUP   = sum(  daydata$Eleva >= 0 ),
                            MinVa   = min(  daydata$CM21value, na.rm = T),
                            MaxVa   = max(  daydata$CM21value, na.rm = T),
                            AvgVa   = mean( daydata$CM21value, na.rm = T),
                            MinGL   = min(  daydata$Global,    na.rm = T),
                            MaxGL   = max(  daydata$Global,    na.rm = T),
                            AvgGL   = mean( daydata$Global,    na.rm = T),
                            Dmean   = mean( todaysdark,        na.rm = T),
                            sunMeas = sum(daydata$Eleva >= 0 & !is.na(daydata$Global)),
                            Mavg    = dark_day$Mavg,
                            Mmed    = dark_day$Mmed,
                            Msta    = dark_day$Msta,
                            Mend    = dark_day$Mend,
                            Mcnt    = dark_day$Mcnt,
                            Eavg    = dark_day$Eavg,
                            Emed    = dark_day$Emed,
                            Esta    = dark_day$Esta,
                            Eend    = dark_day$Eend,
                            Ecnt    = dark_day$Ecnt
        )

        ## gather data
        globaldata <- rbind( globaldata, daydata )

        ## gather day statistics
        statist    <- rbind(statist, day )

        rm( theday, dayCMCF, todaysdark, dark_line, day, daydata )

    } #END loop of days


    tempout <- data.frame()
    yyyy    <- year(globaldata$day[1])

    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))

    tempout <- rbind( tempout, data.frame(Name = "Initial data",      Data_points = NR_loaded) )
    tempout <- rbind( tempout, data.frame(Name = "SD limit",          Data_points = NR_extreme_SD) )
    tempout <- rbind( tempout, data.frame(Name = "Minimum GHI limit", Data_points = NR_min_global) )
    tempout <- rbind( tempout, data.frame(Name = "Remaining data",    Data_points = globaldata[ !is.na(CM21value), .N ]) )

    panderOptions('table.alignment.default', 'right')

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

    ## write this years data
    # capture.output(
    #     RAerosols::write_RDS(globaldata, paste0(GLOBAL_DIR ,sub("SIG", "GHI", basename(afile)))),
    #     file = "/dev/null" )

}
#'

## write statistics on data
capture.output(
    RAerosols::write_RDS(statist, daylystat),
    file = "/dev/null" )

## create pdf with all daily plots
system( paste0("pdftk ", tmpfolder, "/daily*.pdf cat output ", dailyplots) )



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






## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %s %s %s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
