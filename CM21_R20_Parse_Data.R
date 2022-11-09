# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */
#' ---
#' title:         "CM21 signal filtering. **SIG -> S0** "
#' author:        "Natsis Athanasios"
#' institute:     "AUTH"
#' affiliation:   "Laboratory of Atmospheric Physics"
#' abstract:      "Read signal data and write level 0 data.
#'                 Marks or remove problematic data."
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
#' date: "`r format(Sys.time(), '%F')`"
#' params:
#'    ALL_YEARS: TRUE
#' ---

#'
#' **SIG -> S0**
#'
#' **Source code: [github.com/thanasisn/CM_21_GLB](https://github.com/thanasisn/CM_21_GLB)**
#'
#' **Data display: [thanasisn.netlify.app/3-data_display/2-cm21_global/](https://thanasisn.netlify.app/3-data_display/2-cm21_global/)**
#'
#' Read **raw signal** data and create **Signal 0** data
#'
#'  - REMOVE data for bad time ranges
#'  - MARK   positive signal limits
#'  - MARK   negative signal limits
#'  - MARK   positive night signal limits
#'  - MARK   negative night signal limits
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
                            return("CM21_R20_") })
if (!interactive()) {
    pdf(    file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".pdf",  Script.Name))))
    sink(   file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".out",  Script.Name))), split = TRUE)
    filelock::lock(paste0("~/CM_21_GLB/LOGs/",    basename(sub("\\.R$",".lock", Script.Name))), timeout = 0)
}


#+ echo=F, include=F
####  External code  ####
library(data.table, quietly = T, warn.conflicts = F)
library(pander,     quietly = T, warn.conflicts = F)
source("~/CM_21_GLB/Functions_write_data.R")
source("~/CM_21_GLB/Functions_CM21_factor.R")


####  Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")
panderOptions('table.alignment.default', 'right')
panderOptions('table.split.table',        120   )

OutliersPlot <- 5

####  Execution control  ####
ALL_YEARS <- FALSE
## When knitting
if (!exists("params")){
    params <- list( ALL_YEARS = ALL_YEARS)
}
## When executing
args <- commandArgs( trailingOnly = TRUE )
if ( length(args) > 0 ) {
    if ( any(args == "ALL")      ) { ALL_YEARS <- TRUE }
    if ( any(args == "ALLYEARS") ) { ALL_YEARS <- TRUE }
}
params <- list( ALL_YEARS = ALL_YEARS)



#'
#' ## Check bad ranges input
#'
#+ include=T, echo=F

####  Load exclusion list  ####

ranges       <- read.table( BAD_RANGES,
                            sep         = ";",
                            colClasses  = "character",
                            strip.white = TRUE,
                            header      = TRUE,
                            comment.char = "#" )
ranges$From     <- strptime(ranges$From,  format = "%F %H:%M", tz = "UTC")
ranges$Until    <- strptime(ranges$Until, format = "%F %H:%M", tz = "UTC")
ranges$HourSpan <- as.numeric(ranges$Until - ranges$From) / 3600

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
hist(ranges$HourSpan)
cat('\n\n')
temp <- ranges[ ranges$HourSpan > 12 , ]
row.names(temp) <- NULL
pander( temp )
cat('\n\n')
pander(data.table(table(ranges$Comment)))
cat('\n\n')




####  Get data input files  ####
input_files <- list.files( path    = SIGNAL_DIR,
                           pattern = "LAP_CM21_H_SIG_[0-9]{4}.Rds",
                           full.names = T )
input_years <- as.numeric(
    sub(".rds", "",
        sub(".*_SIG_","",
            basename(input_files),),ignore.case = T))


## Get storage files
output_files <- list.files( path    = SIGNAL_DIR,
                            pattern = "LAP_CM21_H_S0_[0-9]{4}.Rds",
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

# years_to_do <- 1993

## Decide what to do
if (length(years_to_do) == 0 ) {
    stop("NO new data! NO need to parse!")
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
#'
#' Allowed signal of ranges that are possible to be recorded normally.
#'
#'
#+ include=T, echo=F
pander(signal_physical_limits)
#'
#'
#'
#' #### Mark of possible night signal.
#'
#'
#' During night (sun elevation `r paste("<",DARK_ELEV)`) we allow a radiation range of `r paste0("[",MINLIMnight,", " ,MAXLIMnight,"]")` to remove various inconsistencies.
#'
#'
#' #### Filter negative signal when sun is up.
#'
#'
#'
#' Allowed years to do: `r input_years`
#'
#'
#' Years to do: `r years_to_do`
#'
#+ include=T, echo=F



####  Loop all years  ####

#+ include=TRUE, echo=F, results="asis"
for (yyyy in years_to_do) {

    #### Get raw data ####
    afile   <- grep(yyyy, input_files,  value = T)
    rawdata <- readRDS(afile)

    cat("\\FloatBarrier\n\n")
    cat("\\newpage\n\n")
    cat("\n## Year:", yyyy, "\n\n" )

    NR_loaded <- rawdata[ !is.na(CM21value), .N ]


    ####    Mark bad date ranges    ############################################
    rawdata[ , Bad_ranges := "" ]
    ## loop only relevant
    rangestemp <- ranges
    rangestemp <- rangestemp[year(rangestemp$From)  >= yyyy - 1 &
                             year(rangestemp$Until) <= yyyy + 1, ]
    if (nrow(rangestemp) > 0) stop("jjjj")
    for (i in 1:nrow(rangestemp) ) {
        lower <- rangestemp$From[   i]
        upper <- rangestemp$Until[  i]
        comme <- rangestemp$Comment[i]
        ## mark bad regions of data
        rawdata[Date >= lower & Date <= upper, Bad_ranges := comme]
    }
    NR_bad_ranges <- rawdata[Bad_ranges != "", .N]

    ## remove and store bad ranges data
    myRtools::write_dat( object = rawdata[ Bad_ranges != "", ],
                         file   = paste0(SIGNAL_DIR,
                                         "/LAP_CM21_H_SIG_", yyyy, "_bad_ranges"),
                         clean  = TRUE)

    rawdata[ Bad_ranges != "", CM21value := NA ]
    rawdata[ Bad_ranges != "", CM21sd    := NA ]
    rawdata[ , Bad_ranges := NULL ]
    ############################################################################


    cat('\n\n')
    cat(paste("### Remaining Suspects after removing bad data from log.\n\n"))

    ## Plot with some checks after bad regions
    yearlims <- data.table()
    for (an in grep("CM21", names(rawdata), value = T)){
        suppressWarnings({
            daily <- rawdata[ , .( dmin =  min(get(an),na.rm = T),
                                   dmax =  max(get(an),na.rm = T))  , by = as.Date(Date) ]
            low <- daily[ !is.infinite(dmin) , mean(dmin) - OutliersPlot * sd(dmin)]
            upe <- daily[ !is.infinite(dmax) , mean(dmax) + OutliersPlot * sd(dmax)]
        })

        ## check if we can decide
        if (is.na(low) | is.na(upe)) next()
        yearlims <- rbind(yearlims,  data.table(an = an,low = low, upe = upe))

        test <- data.table(day = paste(rawdata[ get(an) > upe | get(an) < low , unique(as.Date(Date)) ]))
        if ( nrow(test) > 0 ) {
            cat('\n\n')
            cat(pander(test))
            cat('\n\n')
        }
    }

    cat('\n\n')

    rawdata[!is.na(CM21value)]
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
    month_vec <- strftime( rawdata$Date, format = "%m")
    dd        <- aggregate(rawdata[,c("CM21value", "CM21sd", "Elevat", "Azimuth")],
                           list(month_vec), FUN = summary, digits = 6 )

    boxplot(rawdata$CM21value ~ month_vec )
    title(main = paste("CM21value by month", yyyy) )
    cat('\n\n')

    boxplot(rawdata$CM21sd ~ month_vec )
    title(main = paste("CM21sd by month", yyyy) )
    cat('\n\n')


    ## start flags columns
    rawdata[, QFlag_1 := as.factor(NA)]



    ####    Mark signal physical limits    #####################################
    rawdata[ CM21value <  sig_lowlim, QFlag_1 := "sgLIM_hit" ]
    rawdata[ CM21value >  sig_upplim, QFlag_1 := "sgLIM_hit" ]
    NR_signal_limit    <-   rawdata[  QFlag_1 == "sgLIM_hit", .N ]
    ############################################################################



    ####    Mark night signal possible limits    ###############################
    getnight  <- rawdata$Elevat < DARK_ELEV
    ## mark too negative signal values
    rawdata[ CM21value * cm21factor(Date) < MINLIMnight & Elevat < DARK_ELEV, QFlag_1 := "ToolowDark" ]
    ## drop too positive signal values
    rawdata[ CM21value * cm21factor(Date) > MAXLIMnight & Elevat < DARK_ELEV, QFlag_1 := "ToohigDark" ]
    NR_signal_night_limit <- rawdata[QFlag_1 %in% c("ToolowDark","ToohigDark"), .N ]
    ############################################################################


    cat(paste0( "**",
                NR_loaded, "** non NA data points loaded\n\n" ))
    cat(paste0( "**",
                NR_bad_ranges, "** points marked as bad data ranges\n\n" ))
    cat(paste0( "**",
                NR_signal_limit, "** possible signal error\n\n" ))
    # cat(paste0( "**",
    #             NR_signal_night_limit, "** possible extreme night values\n\n" ))
    # #     cat(paste0( "\"Negative daytime\" removed *",
    # #             NR_negative_daytime, "* data points\n\n" ))
    cat(paste0( "**",
                rawdata[ !is.na(CM21value), .N ], "** non NA data points loaded remaining\n\n" ))

    if (!all(is.na(rawdata$QFlag_1))) {
        cat('\\scriptsize\n')
        cat(pander(table(rawdata$QFlag_1)))
        cat("\n\n")
        cat('\\normalsize\n')
    }

    # cat('\\footnotesize\n')
    # cat('\\normalsize\n')
    # cat('\n')
    #
    # hist(rawdata$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )
    # hist(rawdata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )
    # cat('\n')
    #
    # plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex = .8,
    #      main = paste("CM21 signal ", yyyy ),
    #      xlab = "Elevation",
    #      ylab = "CM21 signal" )
    # cat('\n')
    # plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex = .8,
    #      main = paste("CM21 signal SD", yyyy ),
    #      xlab = "Elevation",
    #      ylab = "CM21 signal Standard Deviations")
    # cat('\n')


    ####  Save signal data to file  ####
    write_RDS(object = rawdata,
              file   = paste0(SIGNAL_DIR,"/LAP_CM21_H_S0_",yyyy,".Rds") )



    cat("\\FloatBarrier\n\n")
    cat('\n\n')
    cat(paste("### Only non flagged data.\n\n"))
    cat('\n\n')



    rawdata <- rawdata[ is.na(QFlag_1) ]

    ## Plot with some checks after bad regions
    yearlims <- data.table()
    for (an in grep("CM21",names(rawdata),value = T)){
        suppressWarnings({
            daily <- rawdata[ , .( dmin =  min(get(an),na.rm = T),
                                   dmax =  max(get(an),na.rm = T) )  , by = as.Date(Date) ]
            low <- daily[ !is.infinite(dmin) , mean(dmin) - OutliersPlot * sd(dmin)]
            upe <- daily[ !is.infinite(dmax) , mean(dmax) + OutliersPlot * sd(dmax)]
        })
        yearlims <- rbind(yearlims,  data.table(an = an,low = low, upe = upe))

        test <- data.table(day = paste(rawdata[ get(an) > upe | get(an) < low , unique(as.Date(Date)) ]))
    }

    cat('\n\n')

    hist(rawdata$CM21value, breaks = 50, main = paste("CM21 signal ",  yyyy ) )
    abline(v = yearlims[ an == "CM21value", low], col = "cyan")
    abline(v = yearlims[ an == "CM21value", upe], col = "cyan")
    abline(v = unique(signal_lower_limit(rawdata$Date)), col = "red")
    abline(v = unique(signal_upper_limit(rawdata$Date)), col = "red")


    cat('\n\n')

    hist(rawdata$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )
    cat('\n\n')

    plot(rawdata$Elevat, rawdata$CM21value, pch = 19, cex = .5,
         main = paste("CM21 signal ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal" )
    abline(h = yearlims[ an == "CM21value", low], col = "cyan")
    abline(h = yearlims[ an == "CM21value", upe], col = "cyan")
    abline(h = unique(signal_lower_limit(rawdata$Date)), col = "red")
    abline(h = unique(signal_upper_limit(rawdata$Date)), col = "red")


    cat('\n\n')

    plot(rawdata$Elevat, rawdata$CM21sd,    pch = 19, cex = .5,
         main = paste("CM21 signal SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal Standard Deviations")
    abline( h = yearlims[ an == "CM21sd", low], col = "red")
    abline( h = yearlims[ an == "CM21sd", upe], col = "red")
    cat('\n\n')


    par(mar = c(2,4,2,1))
    month_vec <- strftime(  rawdata$Date, format = "%m")
    dd        <- aggregate( rawdata[,c("CM21value", "CM21sd", "Elevat", "Azimuth")],
                            list(month_vec), FUN = summary, digits = 6 )

    boxplot(rawdata$CM21value ~ month_vec )
    title(main = paste("CM21value by month", yyyy) )
    cat('\n\n')

    boxplot(rawdata$CM21sd ~ month_vec )
    title(main = paste("CM21sd by month", yyyy) )
    cat('\n\n')

}
#'


#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
