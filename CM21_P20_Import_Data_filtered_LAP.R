# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 signal filtering."
#' author: "Natsis Ath."
#' date: "`r format(Sys.time(), '%B %d, %Y')`"
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
#  - IGNORING   too bad days
#  - FILTERING  date ranges
#
#


#'
#' -  CONVERT    total irradiance
#' -  FILTERING  positive signal
#' -  FILTERING  negative signal
#' -  FILTERING  positive night signal
#' -  FILTERING  negative night signal
#' -
#' -  FILTERING  std > value
#' -  FILTERING  too low global value
#' -
#'






####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P20_Import_Data_filtered_LAP.R")


library(data.table, quietly = T)
source("/home/athan/CM_21_GLB/CM21_functions.R")


####  . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")

## Filter all data
MINsgLIM      = -0.06      ## Lower signal limit (CF~3344.482  0.03V~100watt)
MAXsgLIM      = +0.5       ## Higher signal limit (from hardware limitations)

## Filter when dark (sun below DARK_ELEV )
MINsgLIMnight = -0.02      ## Lower signal limit when dark
MAXsgLIMnight = +0.10      ## Higher signal limit when dark

## Negative limit
SUN_ELEV      = +5         ## When sun is above that
MINsunup      =  0          ## Exclude signal values below that

## Standard deviation filter (apply after other filters)
STD_relMAX    =  1          ## Standard deviation can not be > STD_relMAX * MAX(daily value)

## Lower global limit
GLB_LOW_LIM   = -7         ## any Global value below this should be erroneous data

## Dark Calculations
DARK_ELEV     = -10        ## sun elevation limit
DSTRETCH      =  20 * 3600  ## time duration of dark signal for morning and evening of the same day
DCOUNTLIM     =  10         ## if dark signal has fewer valid measurements than these ignore it


PLOT_NORM = FALSE
WRITE_RDS = FALSE
TEST      = TRUE

PLOT_NORM = TRUE
WRITE_RDS = TRUE
TEST      = FALSE



## . get data input files ####
input_files <- list.files( path    = SIGNAL_DIR,
                           pattern = "LAP_CM21H_SIG_[0-9]{4}.Rds",
                           full.names = T )
input_files <- sort(input_files)





## . load exclusion list ####

too_bad_days <- read.table( TOO_BAD, as.is = TRUE, comment.char = "#" )
too_bad_days <- as.Date(too_bad_days$V1, format = "%Y-%m-%d")

ranges       <- read.table( BAD_RANGES,
                            sep = ";",
                            colClasses = "character",
                            header = TRUE, comment.char = "#" )
ranges$From  <- strptime(ranges$From,  format = "%F %H:%M", tz = "UTC")
ranges$Until <- strptime(ranges$Until, format = "%F %H:%M", tz = "UTC")



#'
#' ## Info
#'
#' Apply filtering from measurments log files and
#' signal limitations.
#'
#' ### Too bad days.
#'
#' Exclude days from file '`r basename(TOO_BAD)`'.
#' These were determind with manual inspection and logging.
#'
#' ### Bad day ranges.
#'
#' Exclude date ranges from file '`r basename(BAD_RANGES)`'.
#' These were determind with manual inspection and logging.
#'
#' ### Filter of posible signal values.
#'
#' Only signal of range `r paste0("[",MINsgLIM,", " ,MAXsgLIM,"]")` is posible to be recorded normaly.
#'
#' ### Filter of posible night signal.
#'
#'
#'






## loop all input files

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files) {

    #### Get raw data ####
    rawdata        <- readRDS(afile)
    rawdata$Global <- NA
    rawdata$GLstd  <- NA
    rawdata$day    <- as.Date(rawdata$Date)
    NR_loaded      <- rawdata[ !is.na(CM21value), .N ]


    ####  Filter too bad days  ###########################################
    NR_too_bad_days <- rawdata[ day %in% too_bad_days & !is.na(CM21value), .N ]
    rawdata <- rawdata[ ! day %in% too_bad_days ]
    ######################################################################



    ####  Filter bad date ranges  ########################################
    pre_count <- rawdata[ !is.na(CM21value), .N ]
    for ( i in 1:nrow(ranges) ) {
        lower <- ranges$From[  i ]
        upper <- ranges$Until[ i ]
        ## select to remove
        select  <- rawdata$Date >= lower & rawdata$Date <= upper
        rawdata <- rawdata[ ! select ]
        rm(select)
    }
    NR_bad_ranges <- pre_count - rawdata[ !is.na(CM21value), .N ]
    ######################################################################



    ####  Filter signal physical limits  #################################
    pre_count <- rawdata[ !is.na(CM21value), .N ]
    rawdata <- rawdata[ CM21value >= MINsgLIM ]
    rawdata <- rawdata[ CM21value <= MAXsgLIM ]
    NR_signal_limit <- pre_count - rawdata[ !is.na(CM21value), .N ]
    ######################################################################



    ####  Filter night signal possible limits  ###########################
    pre_count <- rawdata[ !is.na(CM21value), .N ]
    getnight  <- rawdata$Eleva < DARK_ELEV
    ## drop too negative signal values
    toolowsgDark <- rawdata$CM21value < MINsgLIMnight & getnight
    rawdata$CM21value[ toolowsgDark ]  <- NA
    rawdata$CM21sd[    toolowsgDark ]  <- NA
    ## drop too positive signal values
    toohighsgDark <- rawdata$CM21value > MAXsgLIMnight & getnight
    rawdata$CM21value[ toohighsgDark ] <- NA
    rawdata$CM21sd[    toohighsgDark ] <- NA
    rm(toohighsgDark,toolowsgDark,getnight)
    NR_signal_night_limit <- pre_count - rawdata[ !is.na(CM21value), .N ]
    ######################################################################



    ####  Filter negative values when sun is up  #########################
    pre_count <- rawdata[ !is.na(CM21value), .N ]
    neg_sun   <- rawdata$Eleva > SUN_ELEV & rawdata$CM21value < MINsunup
    rawdata$CM21value[ neg_sun ]  <- NA
    rawdata$CM21sd[    neg_sun ]  <- NA
    rm( neg_sun )
    NR_negative_daytime <- pre_count - rawdata[ !is.na(CM21value), .N ]
    ######################################################################





    yyyy = year(rawdata$day[1])
    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))

    cat(paste0( "Initial **",
                NR_loaded, "** data points loaded\n\n" ))

    cat(paste0( "\"Too bad days\" removed *",
                NR_too_bad_days, "* data points\n\n" ))

    cat(paste0( "\"Bad date ranges\" removed *",
                NR_bad_ranges, "* data points\n\n" ))

    cat(paste0( "\"Signal physical limits\" removed *",
                NR_signal_limit, "* data points\n\n" ))

    cat(paste0( "\"Signal night limits\" removed *",
                NR_signal_night_limit, "* data points\n\n" ))

    cat(paste0( "\"Negative daytime\" removed *",
                NR_negative_daytime, "* data points\n\n" ))


    cat(paste0( "Remaining **",
                rawdata[ !is.na(CM21value), .N ], "** data points\n\n" ))


    cat(pander::pander( summary(rawdata) ))

    cat('\n')

    hist(rawdata$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )

    hist(rawdata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )

    plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex=.8,main = paste("CM21 signal ", yyyy )  )

    plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex=.8,main = paste("CM21 signal SD", yyyy )  )
    cat('\n')
    cat('\n')



    RAerosols::write_RDS(rawdata,
                         sub(".Rds", "_L1.Rds", afile))


}
#'














## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %10s %10s %25s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
