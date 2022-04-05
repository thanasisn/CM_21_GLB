# /* !/usr/bin/env Rscript */
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */
#' ---
#' title: "CM21 signal filtering."
#' author: "Natsis Athanasios"
#' institute: "AUTH"
#' affiliation: "Laboratory of Atmospheric Physics"
#' abstract: "Combine raw data from CM21 to yearly data sets.
#'            Problematic data are filter out the output is written
#'            as R binary (.Rds) file."
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
#'   html_document:
#'     toc:        true
#'     fig_width:  9
#'     fig_height: 6
#'   bookdown::pdf_document2:
#'     number_sections:  no
#'     fig_caption:      no
#'     keep_tex:         no
#'     latex_engine:     xelatex
#'     toc:              yes
#' date: "`r format(Sys.time(), '%F')`"
#' params:
#'    ALL_YEARS: TRUE
#' ---


#` Read all yearly data and create
#` database of all data
#` pdf of all days
#` pdf of suspects
#` statistic on days
#`
#` - IGNORING   too bad days
#`  - FILTERING  date ranges
#`  - FILTERING  positive signal limits
#`  - FILTERING  negative signal limits
#`  - FILTERING  positive night signal limits
#`  - FILTERING  negative night signal limits
#`


#+ echo=F, include=T


####_  Document options _####

knitr::opts_chunk$set(comment    = ""      )
# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"   )
knitr::opts_chunk$set(out.width  = "70%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )



####  Set environment  ####
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n\n")
                            return("CM21_P20_") })
if(!interactive()) {
    pdf(  file = paste0("~/CM_21_GLB/REPORTS/RUNTIME/", basename(sub("\\.R$",".pdf", Script.Name))))
    sink( file = paste0("~/CM_21_GLB/REPORTS/RUNTIME/", basename(sub("\\.R$",".out", Script.Name))), split=TRUE)
    filelock::lock(sub("\\.R$",".lock", Script.Name), timeout = 0)
}


#+ echo=F, include=F
library(data.table, quietly = T, warn.conflicts = F)
library(pander,     quietly = T, warn.conflicts = F)
library(RAerosols,  quietly = T, warn.conflicts = F)
source("~/CM_21_GLB/CM21_functions.R")

ALL_YEARS = FALSE
if (!exists("params")){
    params <- list( ALL_YEARS = ALL_YEARS)
}


####  . Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")

## Filter all data
MINsgLIM      = -0.06      ## Lower signal limit (CF~3344.482  0.03V~100watt)
MAXsgLIM      = +0.5       ## Higher signal limit (from hardware limitations)

## Filter when dark (sun below DARK_ELEV )
DARK_ELEV     = -10        ## sun elevation limit
MINsgLIMnight = -0.02      ## Lower signal limit when dark
MAXsgLIMnight = +0.10      ## Higher signal limit when dark

## Negative limit
SUN_ELEV      = +5         ## When sun is above that
MINsunup      =  0         ## Exclude signal values below that







## . load exclusion list ####

ranges       <- read.table( BAD_RANGES,
                            sep = ";",
                            colClasses = "character",
                            header = TRUE, comment.char = "#" )
ranges$From  <- strptime(ranges$From,  format = "%F %H:%M", tz = "UTC")
ranges$Until <- strptime(ranges$Until, format = "%F %H:%M", tz = "UTC")

## test valid ranges
ranges[ ranges$From > ranges$Until, ]
stopifnot(!all(ranges$From < ranges$Until))
hist(as.numeric(ranges$Until - ranges$From)/3600)
ranges[ ranges$Until - ranges$From > 24*3600 , ]







## . get data input files ####
input_files <- list.files( path    = SIGNAL_DIR,
                           pattern = "LAP_CM21_H_SIG_[0-9]{4}.Rds",
                           full.names = T )
input_years <- as.numeric(
    sub(".rds", "",
        sub(".*_SIG_","",
            basename(input_files),),ignore.case = T))


## . get storage files ####
output_files <- list.files( path    = SIGNAL_DIR,
                            pattern = "LAP_CM21_H_L0_[0-9]{4}.Rds",
                            full.names = T )



#'
#' Allowed years to do: `r input_years`
#'
#+ include=TRUE, echo=FALSE

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


#'
#' Years to do: `r years_to_do`
#'
#+ include=TRUE, echo=FALSE, results="asis"





#'
#' ## Info
#'
#' Apply filtering from measurements log files and
#' signal limitations.
#'
#' ### Too bad days.
#'
#' Exclude days from file '`r basename(TOO_BAD)`'.
#' These were determined with manual inspection and logging.
#'
#' ### Bad day ranges.
#'
#' Exclude date ranges from file '`r basename(BAD_RANGES)`'.
#' These were determined with manual inspection and logging.
#'
#' ### Filter of possible signal values.
#'
#' Only signal of range `r paste0("[",MINsgLIM,", " ,MAXsgLIM,"]")` Volts is possible to be recorded normaly.
#'
#' ### Filter of possible night signal.
#'
#' During night (sun elevation `r paste("<",DARK_ELEV)`) we allow a signal range of `r paste0("[",MINsgLIMnight,", " ,MAXsgLIMnight,"]")` to remove various inconsistencies.
#'
#' ### Filter negative signal when sun is up.
#'
#' When sun elevation `r paste(">",SUN_ELEV)` ignore CM-21 signal `r paste("<",MINsunup)`.
#'






#+ include=TRUE, echo=F, results="asis"
panderOptions('table.alignment.default', 'right')
panderOptions('table.split.table',        120   )
for (afile in input_files) {

    #### Get raw data ####
    rawdata        <- readRDS(afile)
    rawdata$day    <- as.Date(rawdata$Date)
    NR_loaded      <- rawdata[ !is.na(CM21value), .N ]
    yyyy           <- year(rawdata$day[1])

    ## drop NA signal
    rawdata <- rawdata[ !is.na(CM21value) ]



    ####  Filter bad date ranges  ########################################
    pre_count <- rawdata[ !is.na(CM21value), .N ]
    for ( i in 1:nrow(ranges) ) {
        lower <- ranges$From[  i ]
        upper <- ranges$Until[ i ]
        ## remove bad regions of data
        select  <- rawdata$Date >= lower & rawdata$Date <= upper
        rawdata <- rawdata[ ! select ]
        rm(select)
    }
    NR_bad_ranges <- pre_count - rawdata[ !is.na(CM21value), .N ]
    ######################################################################


    cat('\n')

    yearlims <- data.table()
    for (an in grep("CM21",names(rawdata),value = T)){
        daily <- rawdata[ , .( dmin =  min(get(an),na.rm = T),
                               dmax =  max(get(an),na.rm = T) )  , by = as.Date(Date) ]
        low <- daily[ !is.infinite(dmin) , mean(dmin) - 4 * sd(dmin)]
        upe <- daily[ !is.infinite(dmax) , mean(dmax) + 4 * sd(dmax)]

        yearlims <- rbind(yearlims,  data.table(an = an,low = low, upe = upe))

        test <- data.table(day = paste(rawdata[ get(an) > upe | get(an) < low , unique(day) ]))
        if ( nrow(test) > 0 ) {
            cat('\n')
            cat(paste("### Suspects after removing bad data from log.\n\n"))
            cat('\n')
            cat(pander(test))
        }
    }

    cat('\n')


    plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex = .8,
         main = paste("CM21 signal ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal" )
    abline( h = yearlims[ an == "CM21value", low], col = "red")
    abline( h = yearlims[ an == "CM21value", upe], col = "red")

    plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex = .8,
         main = paste("CM21 signal SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal Standard Deviations")
    abline( h = yearlims[ an == "CM21sd", low], col = "red")
    abline( h = yearlims[ an == "CM21sd", upe], col = "red")


    cat('\n')
    cat('\n')



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



    tempout <- data.frame()


    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))

    tempout <- rbind( tempout, data.frame(Name = "Initial data",           Data_points = NR_loaded) )
    tempout <- rbind( tempout, data.frame(Name = "Too bad days",           Data_points = NR_too_bad_days) )
    tempout <- rbind( tempout, data.frame(Name = "Bad date ranges",        Data_points = NR_bad_ranges) )
    tempout <- rbind( tempout, data.frame(Name = "Signal physical limits", Data_points = NR_signal_limit) )
    tempout <- rbind( tempout, data.frame(Name = "Signal night limits",    Data_points = NR_signal_night_limit) )
    tempout <- rbind( tempout, data.frame(Name = "Negative daytime",       Data_points = NR_negative_daytime) )
    tempout <- rbind( tempout, data.frame(Name = "Remaining data",         Data_points = rawdata[ !is.na(CM21value), .N ]) )


    # cat(paste0( "Initial **",
    #             NR_loaded, "** data points loaded\n\n" ))
    # cat(paste0( "\"Too bad days\" removed *",
    #             NR_too_bad_days, "* data points\n\n" ))
    # cat(paste0( "\"Bad date ranges\" removed *",
    #             NR_bad_ranges, "* data points\n\n" ))
    # cat(paste0( "\"Signal physical limits\" removed *",
    #             NR_signal_limit, "* data points\n\n" ))
    # cat(paste0( "\"Signal night limits\" removed *",
    #             NR_signal_night_limit, "* data points\n\n" ))
    # cat(paste0( "\"Negative daytime\" removed *",
    #             NR_negative_daytime, "* data points\n\n" ))
    # cat(paste0( "Remaining **",
    #             rawdata[ !is.na(CM21value), .N ], "** data points\n\n" ))



    cat('\\scriptsize\n')

    # cat('\\footnotesize\n')

    cat(pander( tempout ))

    cat(pander( summary(rawdata[,!c("Date","Azimuth")]) ))

    cat('\\normalsize\n')

    cat('\n')

    hist(rawdata$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )

    hist(rawdata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )

    plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex = .8,
         main = paste("CM21 signal ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal" )

    plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex = .8,
         main = paste("CM21 signal SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal Standard Deviations")

    cat('\n')
    cat('\n')

    capture.output(
        myRtools::write_RDS(rawdata, sub(".Rds", "_L1.Rds", afile)),
        file = "/dev/null" )

}
#'



## END ##
tac = Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
