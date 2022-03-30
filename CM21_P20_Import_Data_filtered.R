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

#'
#' Read all yearly **signal** data and create **Level 0** data
#'
#'  - REMOVE data for bad time ranges
#'  - MARKS  positive signal limits
#'  - MARKS  negative signal limits
#'  - MARKS  positive night signal limits
#'  - MARKS  negative night signal limits
#'
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
library(RAerosols,  quietly = T, warn.conflicts = F)
library(data.table, quietly = T, warn.conflicts = F)
library(pander,     quietly = T, warn.conflicts = F)
library(myRtools,   quietly = T, warn.conflicts = F)

# source("~/CM_21_GLB/CM21_functions.R")

ALL_YEARS = FALSE
if (!exists("params")){
    params <- list( ALL_YEARS = ALL_YEARS)
}


####  . Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")




#'
#' ## Check bad ranges input
#'
#+ include=T, echo=F

## . load exclusion list ####

ranges       <- read.table( BAD_RANGES,
                            sep         = ";",
                            colClasses  = "character",
                            strip.white = TRUE,
                            header      = TRUE,
                            comment.char = "#" )
ranges$From  <- strptime(ranges$From,  format = "%F %H:%M", tz = "UTC")
ranges$Until <- strptime(ranges$Until, format = "%F %H:%M", tz = "UTC")

#'
#' Check inverted time ranges
#'
#+ include=T, echo=F
pander(
    ranges[ ranges$From > ranges$Until, ]
)
stopifnot(!all(ranges$From < ranges$Until))

#'
#' Check time ranges span in hours
#'
#+ include=T, echo=F
hist(as.numeric(ranges$Until - ranges$From)/3600)
cat('\n')
temp <- ranges[ ranges$Until - ranges$From > 24*3600 , ]
row.names(temp) <- NULL
pander( temp )
cat('\n')





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
#' ## Process CM21 data
#'
#' Apply filtering from measurements log files and
#' signal limitations.
#'
#' #### Drop any data with NA signal.
#'
#' #### Bad day ranges.
#'
#' Exclude date ranges from file '`r basename(BAD_RANGES)`'.
#' These were determined with manual inspection and logging.
#'
#' #### Filter of possible signal values.
#'
#' Only signal of range `r paste0("[",MINsgLIM,", " ,MAXsgLIM,"]")` Volts is possible to be recorded normaly.
#'
#' #### Filter of possible night signal.
#'
#' During night (sun elevation `r paste("<",DARK_ELEV)`) we allow a signal range of `r paste0("[",MINsgLIMnight,", " ,MAXsgLIMnight,"]")` to remove various inconsistencies.
#'
#' #### Filter negative signal when sun is up.
#'
#' When sun elevation `r paste(">",SUN_ELEV)` ignore CM-21 signal `r paste("<",MINsunup)`.
#'
#+ include=T, echo=F



#'
#' Allowed years to do: `r input_years`
#'
#'
#' Years to do: `r years_to_do`
#'
#+ include=T, echo=F



## loop all input files

#+ include=TRUE, echo=F, results="asis"
panderOptions('table.alignment.default', 'right')
panderOptions('table.split.table',        120   )
for ( yyyy in years_to_do) {

    #### Get raw data ####
    afile <- grep(yyyy, input_files,  value = T)
    rawdata        <- readRDS(afile)
    rawdata[ , day := as.Date(Date) ]

    cat("\\newpage\n\n")
    cat("\n## Year:", yyyy, "\n" )

    NR_loaded      <- rawdata[ !is.na(CM21value), .N ]

    ## drop NA signal
    rawdata <- rawdata[ !is.na(CM21value) ]

    ####    Mark bad date ranges    ############################################
    rawdata[ , Bad_ranges := "" ]
    ## loop only relevant
    rangestemp <- ranges
    rangestemp <- rangestemp[ year(rangestemp$From)  >= yyyy &
                                  year(rangestemp$Until) <= yyyy, ]
    for ( i in 1:nrow(rangestemp) ) {
        lower <- rangestemp$From[    i ]
        upper <- rangestemp$Until[   i ]
        comme <- rangestemp$Comment[ i ]
        ## mark bad regions of data
        rawdata[ Date >= lower & Date <= upper, Bad_ranges := comme ]
    }
    NR_bad_ranges <- rawdata[ Bad_ranges != "", .N ]

    ## remove bad ranges data
    write_dat( object = rawdata[ Bad_ranges != "",  ],
               file   = paste0(SIGNAL_DIR,"/LAP_CM21_H_SIG_",yyyy,"_bad_ranges"),
               clean  = TRUE)

    rawdata <- rawdata[ Bad_ranges == "",  ]
    rawdata[, Bad_ranges := NULL ]
    ############################################################################


    ## Plot with some checks after bad regions
    yearlims <- data.table()
    for (an in grep("CM21",names(rawdata),value = T)){
        daily <- rawdata[ , .( dmin =  min(get(an),na.rm = T),
                               dmax =  max(get(an),na.rm = T) )  , by = as.Date(Date) ]
        low <- daily[ !is.infinite(dmin) , mean(dmin) - 5 * sd(dmin)]
        upe <- daily[ !is.infinite(dmax) , mean(dmax) + 5 * sd(dmax)]

        yearlims <- rbind(yearlims,  data.table(an = an,low = low, upe = upe))

        test <- data.table(day = paste(rawdata[ get(an) > upe | get(an) < low , unique(day) ]))
        if ( nrow(test) > 0 ) {
            cat('\n\n')
            cat(paste("#### Remaining Suspects after removing bad data from log.\n\n"))
            cat('\n\n')
            cat(pander(test))
            cat('\n\n')
        }
    }

    cat('\n\n')

    hist(rawdata$CM21value, breaks = 50, main = paste("CM21 signal ",  yyyy ) )
    cat('\n\n')

    hist(rawdata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )
    cat('\n\n')

    plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex = .5,
         main = paste("CM21 signal ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal" )
    abline( h = yearlims[ an == "CM21value", low], col = "red")
    abline( h = yearlims[ an == "CM21value", upe], col = "red")
    cat('\n\n')

    plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex = .5,
         main = paste("CM21 signal SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal Standard Deviations")
    abline( h = yearlims[ an == "CM21sd", low], col = "red")
    abline( h = yearlims[ an == "CM21sd", upe], col = "red")
    cat('\n\n')


    par(mar = c(2,4,2,1))
    month_vec <- strftime(  rawdata$Date30 , format = "%m")
    dd        <- aggregate( rawdata[,c("CM21value", "CM21sd", "Elevat", "Azimuth")],
                            list(month_vec), FUN = summary, digits = 6 )

    boxplot(rawdata$CM21value ~ month_vec )
    title(main = paste("CM21value by month", yyyy) )
    cat('\n\n')

    boxplot(rawdata$CM21sd ~ month_vec )
    title(main = paste("CM21sd by month", yyyy) )
    cat('\n\n')


    rawdata[, FlagP20 := "" ]



    ####    Mark signal physical limits    #####################################
    rawdata[ CM21value <  MINsgLIM, FlagP20 := "sgLIM_hit" ]
    rawdata[ CM21value >  MAXsgLIM, FlagP20 := "sgLIM_hit" ]
    NR_signal_limit    <- rawdata[ FlagP20 == "sgLIM_hit", .N ]
    ############################################################################



    ####    Mark night signal possible limits    ###############################
    getnight  <- rawdata$Elevat < DARK_ELEV
    ## mark too negative signal values
    rawdata[ CM21value < MINsgLIMnight & Elevat < DARK_ELEV, FlagP20 := "ToolowDark" ]
    ## drop too positive signal values
    rawdata[ CM21value > MAXsgLIMnight & Elevat < DARK_ELEV, FlagP20 := "ToohigDark" ]
    NR_signal_night_limit <- rawdata[FlagP20 %in% c("ToolowDark","ToohigDark"), .N ]
    ############################################################################



# #    ####    Mark negative values when sun is up    #############################
# #    neg_sun   <- rawdata$Eleva > SUN_ELEV & rawdata$CM21value < MINsunup
# #    rawdata$CM21value[ neg_sun ]  <- NA
# #    rawdata$CM21sd[    neg_sun ]  <- NA
# #
# #    rawdata[ Elevat <= SUN_ELEV & CM21value > MINsunup ]
# #    hist (rawdata[ Elevat <= SUN_ELEV & CM21value < 0 , CM21value])
# #    rm( neg_sun )
# #    NR_negative_daytime <- pre_count - rawdata[ !is.na(CM21value), .N ]
# #    ############################################################################


    cat(paste0( "**",
                NR_loaded, "** non NA data points loaded\n\n" ))
    cat(paste0( "**",
                NR_bad_ranges, "** points markded as bad data ranges\n\n" ))
    cat(paste0( "**",
                NR_signal_limit, "** posisble singal error\n\n" ))
    cat(paste0( "**",
                NR_signal_night_limit, "** posible extreme night values\n\n" ))
# #     cat(paste0( "\"Negative daytime\" removed *",
# #             NR_negative_daytime, "* data points\n\n" ))
    cat(paste0( "**",
                rawdata[ !is.na(CM21value), .N ], "** non NA data points loaded remaining\n\n" ))



#     cat('\\scriptsize\n')
#     # cat('\\footnotesize\n')
#     cat('\\normalsize\n')
#
#     cat('\n')
#
#     hist(rawdata$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )
#
#     hist(rawdata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )
#
#     plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex = .8,
#          main = paste("CM21 signal ", yyyy ),
#          xlab = "Elevation",
#          ylab = "CM21 signal" )
#
#     plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex = .8,
#          main = paste("CM21 signal SD", yyyy ),
#          xlab = "Elevation",
#          ylab = "CM21 signal Standard Deviations")
#
#     cat('\n')
#
#         myRtools::write_RDS(rawdata, sub(".Rds", "_L1.Rds", afile)),
#         file = "/dev/null" )


    ####  Save signal data to file  ####
    write_RDS(object = rawdata,
              file   = paste0(SIGNAL_DIR,"/LAP_CM21_H_L0_",yyyy,".Rds") )

}
#'



#' **END**
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
