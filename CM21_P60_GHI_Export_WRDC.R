# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 export GHI data for WRDC."
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

if (!exists("params")) {
    params <- list()
    params$CACHE <- TRUE }

####_  Document options _####

knitr::opts_chunk$set(echo       = FALSE     )
knitr::opts_chunk$set(cache      = params$CACHE    )
# knitr::opts_chunk$set(include    = FALSE   )
knitr::opts_chunk$set(include    = TRUE    )
knitr::opts_chunk$set(comment    = ""      )

# pdf output is huge too many point to plot
# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"   )

knitr::opts_chunk$set(fig.width  = 8       )
knitr::opts_chunk$set(fig.height = 6       )

knitr::opts_chunk$set(out.width  = "70%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )


####_ Notes _####

#
# this script substitutes CM_P04_Export_Data_v3.R
#



####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P60_GHI_Export.R")


#+ echo=F, include=F
library(data.table, quietly = T)
library(pander,     quietly = T)
#'

####  . Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))





#### .  . Export range  ####
yearstodo  <- seq( year(EXPORT_START), year(EXPORT_STOP) )





## . get data input files ####
input_files <- list.files( path       = GLOBAL_DIR,
                           pattern    = "LAP_CM21H_GHI_[0-9]{4}_L2.Rds",
                           full.names = T )
input_files <- sort(input_files)

## keep only input for desired output
input_files <- input_files[
    as.logical(
        rowSums(
            sapply(yearstodo, function(x) grepl(as.character(x), input_files ))
        )
    )]
stopifnot(length(input_files) == length(yearstodo))



#'
#' ## Info
#'
#' Apply data aggregation and export data for submission to WRDC.
#'
#' We calculate the mean global radiation for every quarter of the hour using all available data and ignoring missing values.
#'
#' The mean hourly values are produced only for the cases where all four of the quarters of each hour are present in the data set.
#' If there is any missing quarterly value the hourly value is not exported.
#'



## loop all input files

pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files) {

    #### Get raw data ####
    ayear        <- readRDS(afile)
    NR_loaded    <- ayear[ !is.na(CM21value), .N ]

    yyyy         <- year(ayear$Date[1])

    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))

    ## create all minutes
    allminutes <- seq( as.POSIXct( paste0(yyyy, "-01-01 00:00:30") ),
                       as.POSIXct( paste0(yyyy, "-12-31 23:59:30") ),
                       by = "mins" )
    allhours    <- seq(as.POSIXct( paste0(yyyy, "-01-01 00:00:30")),
                       as.POSIXct( paste0(yyyy, "-12-31 23:59:30") ), by = "hour")

    ayear <- merge( ayear,
                    data.frame(Date = allminutes),
                    by = "Date", all = T)

    ayear$day <- as.Date(ayear$Date)


    #### run on all quarter of the hour #####################################
    ayear$quarter <- ((as.numeric( ayear$Date ) %/% (3600/4) ) )
    qposic        <- as.POSIXct( ayear$quarter * (3600/4), origin = "1970-01-01" )

    # qDates     = aggregate(ayear$Date30, by = list(qposic), FUN = min)

    selectqua  <- list(ayear$quarter)

    qDates     <- aggregate(ayear$Date,   by = selectqua, FUN = min)

    qGlobal    <- aggregate(ayear$Global, by = selectqua, FUN = mean, na.rm = TRUE )
    qGlobalCNT <- aggregate(ayear$Global, by = selectqua, FUN = function(x) sum(!is.na(x)) )
    qGlobalSTD <- aggregate(ayear$Global, by = selectqua, FUN = sd,   na.rm = TRUE )

    qElevaMEAN <- aggregate(ayear$Eleva,  by = selectqua, FUN = mean, na.rm = TRUE )

    qGLstd     <- aggregate(ayear$GLstd,  by = selectqua, FUN = mean, na.rm = TRUE )
    qGLstdCNT  <- aggregate(ayear$GLstd,  by = selectqua, FUN = function(x) sum(!is.na(x)) )
    qGLstdSTD  <- aggregate(ayear$Global, by = selectqua, FUN = sd,   na.rm = TRUE )

    #### output of quarterly data #######################################
    ayearquarter <- data.frame( Dates      = qDates$x,
                                qGlobal    = qGlobal$x,
                                qGlobalCNT = qGlobalCNT$x,
                                qGlobalSTD = qGlobalSTD$x,
                                qElevaMEAN = qElevaMEAN$x,
                                qGLstd     = qGLstd$x,
                                qGLstdCNT  = qGLstdCNT$x,
                                qGLstdSTD  = qGLstdSTD$x)



    ## TODO do we need them?
    capture.output(
        RAerosols::write_RDS( ayearquarter, paste0(EXPORT_DIR, sub("_L2","_QRT",basename(afile))) ),
        file = "/dev/null")


    #### run on 4 quarters of every hour ################################
    ayearquarter$hourly <- as.numeric( ayearquarter$Dates ) %/% 3600
    hposic              <- as.POSIXct( ayearquarter$hourly * 3600, origin = "1970-01-01" )

    selecthour <- list(ayearquarter$hourly)

    hDates     <- aggregate( ayearquarter$Dates,   by = selecthour, FUN = min )

    hGlobal    <- aggregate( ayearquarter$qGlobal, by = selecthour, FUN = mean, na.rm = FALSE )  ## na.rm must be FALSE!
    hGlobalCNT <- aggregate( ayearquarter$qGlobal, by = selecthour, FUN = function(x) sum(!is.na(x)))


    ## check we don't want gaps in days
    alloutput <- data.frame( Dates  = hDates$x - 30,
                             Global = hGlobal$x  )
    allhours  <- data.frame( Dates = allhours - 30 )
    stopifnot( dim(alloutput)[1] == dim(allhours)[1] )

    ## output for all hours of the year
    test <- merge( x = alloutput,
                   y = allhours,
                   all.y = TRUE  )

    ## WRDC don't want negative values
    test$Global[ test$Global < 0 ] <- 0

    ## set NAs to -99 they are old school
    test$Global[ is.na( test$Global) ] <- -99
    test$Global[ is.nan(test$Global) ] <- -99

    ## create the format they like

    library(lubridate, quietly = T)
    hourlyoutput <- data.frame( year   = year(  test$Dates ),
                                month  = month( test$Dates ),
                                day    = day(   test$Dates ),
                                time   = hour(  test$Dates ) + 0.5,
                                global = test$Global)

    wrdcfile = paste0(EXPORT_DIR, "sumbit_to_WRDC_", yyyy, ".dat")

    ## add headers
    cat("#Thessaloníki global radiation\r\n" ,
        file = wrdcfile)
    cat("#year month day time(UTC)   global radiation (W/m2)\r\n" ,
        file = wrdcfile, append = TRUE)

    ## write output line by line
    for (i in 1:length(hourlyoutput$year)){
        cat(
            sprintf( "%4d  %2d  %2d  %4.1f %10.4f\r\n", hourlyoutput[i,1],
                     hourlyoutput[i,2],
                     hourlyoutput[i,3],
                     hourlyoutput[i,4],
                     hourlyoutput[i,5] ),
            file = wrdcfile,
            append = TRUE )
    }
    ## replace -99.000 to -99
    system(paste("sed -i 's/   -99.0000/   -99/g' ", wrdcfile))


    cat(paste("Data Exported to:", basename(wrdcfile),"\n"))

    panderOptions('table.alignment.default', 'right')
    panderOptions('table.split.table',        120   )


    cat('\\scriptsize\n')

    cat(pander( summary(hourlyoutput) ))

    cat('\\normalsize\n')

    cat('\n')


    plot(test$Dates, test$Global, ylab = "Hourly GHI", xlab = "", main = "Quarterly aggregated hourly GHI")

    hist(test$Global, xlab = "Hourly GHI", main = "Histogram of quarterly aggregated hourly GHI" )


} #END loop of years








# ooooo      <- read.table("output3.dat" )
# ooooo$date <- as.POSIXct(paste0(ooooo$V1,"-",ooooo$V2,"-",ooooo$V3," ",ooooo$V4-0.5,":00") )
#
#
# kkkk       <- read.table("~/Aerosols/CM21datavalidation/fwdatasubmissionthessaloniki/wrdc_lap_2017.dat")
# kkkk$date  <- as.POSIXct(paste0(kkkk$V1,"-",kkkk$V2,"-",kkkk$V3," ",kkkk$V4-0.5,":00") )
#
#
#
#
# (kkkk$V5[kkkk$V5<0 & kkkk$V5>-99])
#
# ayearquarter$day     = as.Date(ayearquarter$Dates)
#
# ## sequence of all days to try
# daystodo = unique( ayearquarter$day )
#
# #### PLOT NORMAL #########################
# totals  = length(daystodo)
# statist = data.frame()
# pbcount = 0
# stime = Sys.time()
# par( mar = c(4,4,3,1) )
# pdf( pdfgraphs, onefile = TRUE)
# for (ddd in daystodo) {
#
#     theday      = as.POSIXct( as.Date(ddd), origin = "1970-01-01")
#     test        = format( theday, format = "%d%m%y06" )
#     dayCMCF     = cm21factor(theday)
#
#     pbcount     = pbcount + 1
#     day         = data.frame()
#     dailyselect = ayearquarter$day == as.Date(theday)
#
#     daydata = ayearquarter[dailyselect,]
#
#     names(daydata) <-  c("Date30", "Global","qGlobalCNT", "qGlobalSTD", "qElevaMEAN", "GLstd", "qGLstdCNT", "qGLstdSTD", "day")
#
#
#     plot_norm(daydata, test, tag)
#
#
# }
# dev.off()
#
#
#
# suspecdates = suspecdates[is.element(suspecdates,as.POSIXct(daystodo))]
#
# totals  = length(suspecdates)
# statist = data.frame()
# pbcount = 0
# stime = Sys.time()
# par( mar = c(4,4,3,1) )
# pdf( suspects, onefile = TRUE)
# for (ddd in suspecdates) {
#
#     theday      = as.POSIXct( ddd, origin = "1970-01-01")
#     test        = format( theday, format = "%d%m%y06" )
#     dayCMCF     = cm21factor(theday)
#
#     pbcount     = pbcount + 1
#     day         = data.frame()
#     dailyselect = ayearquarter$day == as.Date(theday)
#
#     daydata = ayearquarter[dailyselect,]
#
#     names(daydata) <-  c("Date30", "Global","qGlobalCNT", "qGlobalSTD", "qElevaMEAN", "GLstd", "qGLstdCNT", "qGLstdSTD", "day")
#
#
#     plot_norm(daydata, test, tag)
#
#
# }
# dev.off()



## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %s %s %s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
