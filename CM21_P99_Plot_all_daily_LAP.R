#!/usr/bin/env Rscript
#' Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com>
#'
#' Read text files with CM_21 signal data
#'


####  Set environment  ####
closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = funr::sys.script()
#~ if(!interactive()) {
#~     pdf(file=sub("\\.R$",".pdf",Script.Name))
#~     sink(file=sub("\\.R$",".out",Script.Name),split=TRUE)
#~ }


library(data.table)


####  . . Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")

source("~/CM_21_GLB/CM21_functions.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


####  Files for import  ####
## . get data input files ####
input_files <- list.files( path       = GLOBAL_DIR,
                           pattern    = "LAP_CM21H_GHI_[0-9]{4}_L2.Rds",
                           full.names = T )
input_files <- sort(input_files)



for (afile in input_files) {

    #### Get raw data ####
    ayear        <- readRDS(afile)
    NR_loaded    <- ayear[ !is.na(CM21value), .N ]
    yyyy         <- year(ayear$Date[1])

    ## create all minutes
    allminutes <- seq( as.POSIXct( paste0(yyyy, "-01-01 00:00:30") ),
                       as.POSIXct( paste0(yyyy, "-12-31 23:59:30") ),
                       by = "mins" )

    ayear     <- merge( ayear,
                    data.frame(Date = allminutes),
                    by = "Date", all = T)

    ayear$day <- as.Date(ayear$Date)


    daystodo  <- unique( ayear$day )

    pdffile = paste0(REPORT_DIR, "Daily_GHI_", yyyy, ".pdf")
    pdf(pdffile)

    par(mar = c(4,4,2,1))
    par(mgp = c(2.2,1,0))

    for (ddd in daystodo) {

        aday    <- as.Date(ddd, origin = "1970-01-01")
        test    <- format( aday, format = "%d%m%y06" )

        ## get daily data
        daydata <- ayear[ day == as.Date(aday) ]

        ## it can plot even the all day NA
        plot_norm2(daydata, test, tag)

    }
    dev.off()

}


paste("pdftk fdsf.pdf cat output fdsfss.pdf")


## END ##
tac = Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
