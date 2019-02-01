# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 daily GHI filtering."
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
#'   html_document: default
#'   odt_document:  default
#'   word_document: default
#' ---

#+ echo=F, include=T


####_  Document options _####

knitr::opts_chunk$set(echo       = FALSE   )
knitr::opts_chunk$set(cache      = TRUE    )
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
#
#
# Read all yearly data and create
# database of all data
# pdf of all days
# pdf of suspects
# statistic on days
#



#'
#' -  FILTERING  std > value
#' -  CONVERT    total irradiance
#' -  FILTERING  too low global value
#'






####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P30_GHI_dailiy_filtered.R")


#+ echo=F, include=F
library(data.table, quietly = T)
library(pander,     quietly = T)
# library(RAerosols,  quietly = T)
source("/home/athan/CM_21_GLB/CM21_functions.R")
#'


####  . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))

## Standard deviation filter (apply after other filters)
STD_relMAX    =  1          ## Standard deviation can not be > STD_relMAX * MAX(daily value)

## Lower global limit
GLB_LOW_LIM   = -10         ## any Global value below this should be erroneous data (-7 older output)

## Dark Calculations
DARK_ELEV     = -10         ## sun elevation limit
DSTRETCH      =  20 * 3600  ## time duration of dark signal for morning and evening of the same day
DCOUNTLIM     =  10         ## if dark signal has fewer valid measurements than these ignore it


missfiles = paste0(BASED, "LOGS/", Script.Name ,"_missingfilelist.dat" )

## dir for pdfs
tmpfolder = tempdir()


PLOT_NORM = FALSE
WRITE_RDS = FALSE
TEST      = TRUE

PLOT_NORM = TRUE
WRITE_RDS = TRUE
# TEST      = FALSE


## append a list into list
list.append <- function (lst, ...){
    lst <- c(lst, list(...))
    return(lst)
}



## . get data input files ####
input_files <- list.files( path    = SIGNAL_DIR,
                           pattern = "LAP_CM21H_SIG_[0-9]{4}_L1.Rds",
                           full.names = T )
input_files <- sort(input_files)






#'
#' ## Info
#'
#' Apply filtering from measurements log files and
#' signal limitations.
#'
#' ### Apply variation filtering.
#'
#' Exclude from daily data valuew where signals standard deviation > `r STD_relMAX` * max(daily signal).
#'
#' ### Covert signal to global irradiance.
#'
#' The convertion is done with a factor which is interpolated between CM-21 callibrations.
#'
#' ### Filter minimum Global irradiance.
#'
#'



## loop all input files

statist <- data.table()
pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files[1]) {

    #### Get raw data ####
    rawdata        <- readRDS(afile)
    rawdata$Global <- NA
    rawdata$GLstd  <- NA
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


        ## get daily data
        daydata     <- rawdata[ day == as.Date(theday) ]
        ## add all minutes for nicer graphs
        daydata     <- merge(daydata, daymimutes, all = T)



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




        if (PLOT_NORM) {

            pdf(file = paste0(tmpfolder,"/daily_", sprintf("%05d.pdf", pbcount)))
                plot_norm2(daydata, test, tag)

                ## Dark signal plot
                plot(daydata$Date, todaysdark, "l",xlab = "UTC", ylab = "W/m^2")
                title(main = paste(test, format(daydata$Date[1] , format = "  %F")))
            dev.off()

        }




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

        # dur = as.numeric(difftime(Sys.time(), stime, units = "secs"))
        # eta = as.numeric(difftime(Sys.time(), stime, units = "secs"))*(totals/pbcount - 1)
        # cat( sprintf( "%6.2f%%   %s   %s   %4d/%4d", 100*(pbcount/totals),
        #               countdownS(eta, "h"),
        #               countdownS(dur, "h"),
        #               pbcount, totals ), sep = "\n" )



    } #END loop of days












    tempout <- data.frame()

    yyyy = year(globaldata$day[1])
    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))

    tempout <- rbind( tempout, data.frame(Name = "Initial data",      Data_points = NR_loaded) )
    tempout <- rbind( tempout, data.frame(Name = "SD limit",          Data_points = NR_extreme_SD) )
    tempout <- rbind( tempout, data.frame(Name = "Minumun GHI limit", Data_points = NR_min_global) )


    tempout <- rbind( tempout, data.frame(Name = "Remaining data",    Data_points = globaldata[ !is.na(CM21value), .N ]) )


    panderOptions('table.alignment.default', 'right')

    cat('\\scriptsize\n')

    # cat('\\footnotesize\n')

    cat(pander( tempout ))

    cat(pander( summary(globaldata[,!c("Date","Azimuth")]) ))

    cat('\\normalsize\n')

    cat('\n')

    hist(globaldata$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )

    hist(globaldata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )

    plot(globaldata$Elevat, globaldata$Global, pch = 19, cex = .8,
         main = paste("CM21 signal ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal" )

    plot(globaldata$Elevat, globaldata$GLstd,    pch = 19, cex = .8,
         main = paste("CM21 signal SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal Standard Deviations")

    cat('\n')
    cat('\n')

    # capture.output(
    #     write_RDS(rawdata, sub(".Rds", "_L1.Rds", afile)),
    #     file = "/dev/null" )

}
#'

paste0("pdftk " ,tmpfolder,"/daily*.pdf cat output /home/athan/CM_21_GLB/REPORTS/P30.pdf")


## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %10s %10s %25s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))

#
# num.plots <- 400
# my.plots  <- vector(num.plots, mode='list')
#
# for (i in 1:num.plots) {
#     plot(i)
#     my.plots[[i]] <- recordPlot()
# }
# graphics.off()
#
# pdf('myplots.pdf', onefile=TRUE)
# for (my.plot in my.plots) {
#     replayPlot(my.plot)
# }
# graphics.off()
