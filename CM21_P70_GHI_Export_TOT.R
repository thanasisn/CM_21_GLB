# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 export GHI data for Sirena."
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
#' - \usepackage{multicol}
#' - \setlength{\columnsep}{1cm}
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
knitr::opts_chunk$set(cache      = FALSE    )
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
# this script substitutes CM_P04_Export_TOT.R
#



####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P70_GHI_Export_TOT.R")


#+ echo=F, include=F
library(data.table, quietly = T)
library(pander,     quietly = T)
#'

####  . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))






#### .  . Export range  ####
yearstodo   <- seq( year(EXPORT_START), year(EXPORT_STOP) )


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
#' Export GHI for sirena for the period `r year(EXPORT_START)` - `r year(EXPORT_STOP)`
#'
#' **Sun angles are calculated with other method than the rest of the broadband.**
#' This will change in the future.
#'
#' **We don't allow negative values on export.**
#' Negative GHI is set to zero and SD is set to NA (-9)
#'
#' All missing values (NA) are set to "-9".
#'



## loop all input files

pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files) {

    #### Get raw data ####
    ayear        <- readRDS(afile)
    NR_loaded    <- ayear[ !is.na(CM21value), .N ]
    yyyy         <- year(ayear$Date[1])

    cat('\\normalsize\n')

    cat(paste("\\newpage\n\n"))
    cat(paste("## ",yyyy,"\n\n"))

    cat('\\begin{multicols}{3}')
    cat('\\scriptsize\n')

    ## create all minutes
    allminutes <- seq( as.POSIXct( paste0(yyyy, "-01-01 00:00:30") ),
                       as.POSIXct( paste0(yyyy, "-12-31 23:59:30") ),
                       by = "mins" )

    ## be sure to have all minutes
    ayear <- merge( ayear,
                    data.frame(Date = allminutes),
                    by = "Date", all = T)

    ayear$day <- as.Date(ayear$Date)


    ## load SZA from first input
    temp_sun <- readRDS(list.files(path       = SIGNAL_DIR,
                                   pattern    = paste0("SIG_", yyyy,".Rds"),
                                   full.names = T)[1])
    temp_sun <- temp_sun[ , c("Date", "Azimuth", "Elevat") ]
    ## drop old sun positions
    ayear <- ayear[ , -c("Azimuth","Elevat")]
    ## replace with new sun positions
    ayear <- merge(ayear, temp_sun, by = "Date", all = T)


    ## don't allow negative values at the output
    ayear$Global[ ayear$Global < 0 ]    <- 0L
    ayear$GLstd[  ayear$Global < 0 ]    <- NA

    ## convert NA to -9
    ayear$Global[ is.na(ayear$Global) ] <- -9L
    ayear$GLstd[  is.na(ayear$GLstd ) ] <- -9L


    alldays <- sort(unique(ayear$day))

    ## create dir
    outputdir <- paste0(TOT_EXPORT, yyyy, "/")
    dir.create( outputdir, showWarnings = F )


    ## export each day
    for (dd in alldays) {
        dateD = as.Date(dd, origin = "1970-01-01")

        aday <- ayear[ day == dateD ]
        if (nrow(aday) != 1440 ) {
            stop("Day do not have 1440 minutes!!")
        }

        ## this day output file
        filename <- paste0(outputdir, strftime(dateD, format = "TOT%3j%y.DAT"))

        ## may skip output if day has no global data
        if (all(aday$Global == -9)) {
            cat("\\textbf{",paste0(dateD,": NO GHI DATA}\\\\\n"))
            # cat(paste(dateD,"\n"), file = missingday, append = T )
            ## skip output
            next()
        }


        ## calculate SZA for the output
        ## FIXME should use other algorithm for sza to be consistent with other instruments.
        SZA     <- -(aday$Eleva - 90)


        if (any(is.na(SZA))) {
            stop("SZA should be always defined for TOT output files (", dateD,") \nHave to correct this!!")
        }

        ## format time like the others
        TIME_UT <- as.numeric((aday$Date - as.POSIXct( dateD ) + 30) / 3600)
        SZA[ is.na(SZA) ] <- -999L


        ## data to export
        output <- data.frame( TIME_UT = TIME_UT,
                              SZA     = SZA,
                              Wm2     = round(aday$Global, digits = 3),
                              st.dev  = round(aday$GLstd,  digits = 3) )


        ## create the header of the daily file
        cat(" TIME_UT    SZA    [W.m-2]   st.dev",
            file = filename,
            eol = "\r\n")

        # write(" TIME_UT    SZA    [W.m-2]   st.dev",
        #       file = paste0(newtotdir,filename))

        write.table(format( output,
                            digits    = 3,
                            width     = 8,
                            row.names = FALSE,
                            scietific = FALSE,
                            nsmall    = 2 ),
                    file      = filename,
                    append    = TRUE,
                    quote     = FALSE,
                    col.names = FALSE,
                    row.names = FALSE,
                    eol = "\r\n")

        # cat(paste("Written: ", basename(filename), "\r"))
        cat(paste0(dateD, ": ", basename(filename), " \\\\\n"))
    } #END of days

    cat('\\end{multicols}')
} #END of years






## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %s %s %s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
