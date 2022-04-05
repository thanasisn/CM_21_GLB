# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */
#' ---
#' title:         "Read and export global radiation data from sirena"
#' author:        "Natsis Athanasios"
#' date:          "`r format(Sys.time(), '%B %d, %Y')`"
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
#'   bookdown::html_document2:
#'     keep_md:          yes
#'     out_width:        100%
#'     toc:              yes
#'     number_sections:  no
#'   bookdown::pdf_document2:
#'     fig_caption:      no
#'     keep_tex:         no
#'     latex_engine:     xelatex
#'     number_sections:  no
#'     toc:              yes
#'   odt_document:  default
#'   word_document: default
#' ---

#+ echo=F, include=T


####_  Document options _####

knitr::opts_chunk$set(echo       = FALSE   )
knitr::opts_chunk$set(cache      = FALSE   )
# knitr::opts_chunk$set(include    = FALSE   )
knitr::opts_chunk$set(include    = TRUE    )
knitr::opts_chunk$set(comment    = ""      )



# pdf output is huge too many point to plot
# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"   )
# knitr::opts_chunk$set(fig.width  = 8       )
# knitr::opts_chunk$set(fig.height = 6       )
# knitr::opts_chunk$set(out.width  =  "50%"       )
knitr::opts_chunk$set(fig.align  =  "center"       )

# knitr::opts_chunk$set(fig.pos    = '!h'     )


#+ echo=F, include=F
####  Set environment  ####
# rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n")
                            return("check_export_sirena.R") })
if(!interactive()) {
    pdf(file=sub("\\.R$",".pdf",Script.Name))
    sink(file=sub("\\.R$",".out",Script.Name,),split=TRUE)
}
Script.Base = sub("\\.R$","",Script.Name)


library(data.table)
library(pander)

#### read all tot files from sirena #####
rdsfile <- "~/DATA/cm21_data_validation/export_all_tot_dat.Rds"
datfile <- "~/DATA/cm21_data_validation/export_all_total.dat"
folder  <- "~/DATA/cm21_data_validation/AC21_lap.GLB_TOT"

files <- list.files(folder,
                     pattern     = "[0-9]*\\TOT.*.dat",
                     recursive   = T,
                     ignore.case = T,
                     full.names  = T)

## check if we have to read
if (!file.exists(rdsfile) |  max(file.mtime(files)) > file.mtime(rdsfile)) {
    DT <- data.table()
    for (af in files) {
        temp      <- fread(af)
        partdate  <- sub(".dat", "", sub(".*TOT","",af), ignore.case = T)
        date      <- as.POSIXct(strptime(partdate, "%j%y" ))
        temp$Date <- date
        temp$file <- af
        DT        <- rbind(DT, temp)
        print(date)
    }
    myRtools::writeDATA(DT, rdsfile)
} else {
    DT <- readRDS(rdsfile)
}

#+ echo=T, include=F
DT[ `[W.m-2]` < -8, `[W.m-2]` := NA ]
DT[  st.dev   < -8,  st.dev   := NA ]

stop()


#'
#' ## By year
#'
pander(
    DT[ , .(Files      = length(unique(file)),
            Datapoints = .N,
            Missing = sum(is.na(`[W.m-2]`))), by = year(Date)]
)
#'
#' Unique files: `r length(unique(DT$file))`
#'
#' Unique days:  `r length(unique(DT$Date))`
#'

missing <- DT[, .(Missing = sum(is.na(`[W.m-2]`))), by = as.Date(Date)]
missing[ Missing == 0, Missing := NA]
plot(missing$as.Date, missing$Missing,pch = 19, cex=0.5, main = "Missing data by day")

missing <- DT[, .(Missing = sum(is.na(`[W.m-2]`))), by = .(year(Date), month(Date)) ]
missing[, as.Date := as.Date(paste(year, month, "01"),"%Y %m %d")]
plot(missing$as.Date, missing$Missing,pch = 19, cex=0.5, main = "Missing data by month")



#'
#' ## Data points by hour
#'
#+ echo=T, include=T
pander(
    table(  DT$TIME_UT %/% 1 )
)
#'
# hist( DT$TIME_UT %/% 1, breaks = 25)


#' ## Data points by minute
#'
hist(round( ( DT$TIME_UT %% 1 ) * 60 ), breaks = -1:61)

#+ echo=F, include=F
# DT[ TIME_UT %/% 1 == 24, unique(file)]

count <- DT[, .N, by = file]
#' Do all files has 1440 records: `r all(count$N == 1440)`
pander(table(count$N))


## add nice date
dateess   <- paste( DT$Date, DT$TIME_UT %/% 1, round((DT$TIME_UT %% 1) * 60) )
DT$Date <- as.POSIXct( strptime(dateess, "%F %H %M") )
setorder(DT,Date)


#' ## Drop some data
#+ echo=T, include=T
DT <- DT[ !is.na(`[W.m-2]`), ]
DT <- DT[ `[W.m-2]` > -5   , ]
#'


#+ echo=F
#' ## Inspect all data
pander(summary(DT))
plot(DT$Date, DT$`[W.m-2]`)
hist(DT$`[W.m-2]`)


# ## apply exclusions this have been done for almost all data  me
# ranges       <- read.table( "~/Aerosols/source_R/PARAMETRICkip_date_ranges_CM21.txt",
#                             sep = ";",
#                             colClasses = "character",
#                             header = TRUE, comment.char = " )
# ranges$From  <- strptime(ranges$From,  format = "%F %H:%M",  = "UTC")
# ranges$Until <- strptime(ranges$Until, format = "%F %H:%M",  = "UTC")
#
# for ( i in 1:nrow(ranges) ) {
#     lower <- ranges$From[  i ]
#     upper <- ranges$Until[ i ]
#     ## select to remove
#     select  <- DT$Date >= lower & DT$Date <= upper
#     DT  <- DT[ ! select ]
#     rm(select)
# }


#' ## Monthly values
#+ echo=F
temp <- DT[ , .( Mean   = mean(`[W.m-2]`,   na.rm = T),
                 Max    = max(`[W.m-2]`,    na.rm = T),
                 Min    = min(`[W.m-2]`,    na.rm = T),
                 Median = median(`[W.m-2]`, na.rm = T)),
            by = .(year(Date),month(Date)) ]
temp$Date <- as.POSIXct(strptime( paste( temp$year, temp$month, "1"), "%Y %m %d" ))


plot(temp$Date, temp$Mean,   "l", main = "Monthly Mean")
plot(temp$Date, temp$Max,    "l", main = "Monthly Max")
# plot(temp$Date, temp$Min,    "l", main = "Monthly Min")
plot(temp$Date, temp$Median, "l", main = "Monthly Median")


#+ echo=F
DT$file    <- NULL
DT$TIME_UT <- NULL
names(DT)[names(DT) == "[W.m-2]"] <- "wattGLB"


perc    <- 0.99999
uplim   <- quantile(DT$wattGLB, na.rm = T, probs = perc)
datespp <- DT[wattGLB > uplim, unique(as.Date(Date)) ]


#' ## Extreme values
#+ echo=F, include=T, results='asis'
options(digits = 6)
cat(paste("There are", length(datespp),
    "days with more than", uplim,
    "watts, representing", (1-perc) * 100,
    "% of the data.\n"))
#'
#'
#' ## Plot all extreme days
#'
for (ad in datespp ) {
    pp <- DT[ as.Date(Date) == ad ]
    plot(  pp$Date, pp$wattGLB, "l", col = "green")
    points(pp$Date, pp$st.dev, col = "blue", pch=19, cex=.2)
    title(as.Date(ad, origin = "1970-01-01"))
}
#'
#'
#' ## Plot all extreme days in time series
#'
pp <- DT[ as.Date(Date) %in% datespp ]
plot(pp$Date, pp$wattGLB, "l", col = "green")
points(pp$Date, pp$st.dev, col = "blue", pch=19, cex=.2)



# myRtools::writeDATA(data,
#                     datfile,
#                     contact = "natsisthanasis@gmail.com",
#                     type = "dat")


#' **END**
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
