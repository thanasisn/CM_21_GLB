# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 dark trend reconstruction."
#' author: "Natsis Athanasios"
#' date: "`r format(Sys.time(), '%B %d, %Y')`"
#' keywords: "CM21, CM21 data validation, global irradiance, dark"
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
# knitr::opts_chunk$set(dev        = "png"   )

knitr::opts_chunk$set(fig.width  = 8       )
knitr::opts_chunk$set(fig.height = 4       )

knitr::opts_chunk$set(out.width  = "100%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )


####_ Notes _####

#
# this script substitutes 'CM_P02_missing_dark.R'
#
# Resolution method for missing dark signal
#






####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P40_missing_dark_reconstruction.R")


#+ echo=F, include=F
library(data.table, quietly = T)
library(pander,     quietly = T)
library(caTools,    quietly = T)
#'


####  . Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


## PATHS
daylystat = paste0(dirname(GLOBAL_DIR), "/CM21_P30_GHI_daily_filtered_stats.Rds")







## get first approximation statistics
statist <- readRDS(daylystat)



#'
#' ## Info
#'
#' We will use existing daily dark signal values, to infer the dark
#' signal when it can not be computed for a day.
#' This is a result of missing data before sunrise on/and after sunset.
#'
#'

#'
#' ## Dark calculated as `median` value.
#'
#' The median dark of a period before morning and after night is used as the
#' base of the dark signal correction.
#'


temp <- data.frame(statist$Mmed, statist$Emed)
Dmed <- rowMeans(temp, na.rm = TRUE)

darkmedian <- approxfun( statist$Date, Dmed )


par(mar = c(2,4,2,1))

plot(statist$Date, Dmed, pch = 19, cex = 0.2,
     main = "Median", xlab = "", ylab = "Daily dark values")


plot(statist$Date, darkmedian(statist$Date), pch = 19, cex = 0.2 ,col="red",
     main="Median reconstruction fill missing")
points(statist$Date, Dmed, pch = 19, cex = 0.2 )

legend("topleft",
       legend = c("Calculated Dark",
                  "Estimated Dark"),
       pch = 19,
       col = c("black","red"),
       bty = "n")




#'
#' ## Dark calculated as `mean` value.
#'
#' The mean dark of a period before morning and after night is used as the
#' base of the dark signal correction.
#'

temp <- data.frame(statist$Mavg, statist$Eavg)
Dmen <- rowMeans(temp, na.rm = TRUE)

darkmean <- approxfun( statist$Date, Dmed )



par(mar = c(2,4,2,1))

plot(statist$Date, Dmen, pch = 19, cex = 0.2,
     main = "Mean", xlab = "", ylab = "Daily dark values")


plot(statist$Date, darkmean(statist$Date), pch = 19, cex = 0.2 ,col="red",
     main = "Mean reconstruction fill missing")
points(statist$Date, Dmen, pch = 19, cex = 0.2 )

legend("topleft",
       legend = c("Calculated Dark",
                  "Estimated Dark"),
       pch = 19,
       col = c("black","red"),
       bty = "n")







#'
#' ## Mean Dark from first pass
#'
plot(statist$Date, statist$Dmean, pch = 19, cex = 0.2,
     main = "Average Dark Correction on first pass" )




##### remove zeros #####
statist$Dmean[ statist$Dmean == 0 ] <- NA


sel_1 <- statist$Date < BREAKDATE

scatter.smooth( x = statist$Date[sel_1],
                y = statist$Dmean[sel_1], pch = 19, cex = 0.2,
                xlab = "", xaxt='n', ylab = "Dark signal",
                main = "Mean Daily dark before break")
axis.POSIXct(1, statist$Date[sel_1])


sel_2 <- statist$Date >= BREAKDATE

scatter.smooth( x = statist$Date[sel_2],
                y = statist$Dmean[sel_2], pch = 19, cex = 0.2,
                xlab = "", xaxt = 'n', ylab = "Dark signal",
                main = "Mean Daily dark after break")
axis.POSIXct(1, statist$Date[sel_1])


#'
#' ## Dark calculated as `running mean` value.
#'



# show runmean for different window sizes
x <- statist$Date[  sel_1 ]
y <- statist$Dmean[ sel_1 ]

if ( length(y) > 0 ) {
    col = c("black", "green", "blue", "magenta", "cyan")
    plot(x,y, col=col[1], pch = 19, cex = 0.2, main = "Moving Window Means before break")
    # lines(x, runmean(y, 3), col=col[2], lwd=2)
    lines(x, runmean(y, 8), col = col[2], lwd = 2)
    lines(x, runmean(y,15), col = col[3], lwd = 2)
    lines(x, runmean(y,24), col = col[4], lwd = 2)
    lines(x, runmean(y,50), col = col[5], lwd = 2)
    lab = c("data",  "k=8", "k=15", "k=24", "k=50")
    legend("topright", lab, col = col, lty = 1 )
}

x <- statist$Date[  sel_2 ]
y <- statist$Dmean[ sel_2 ]

if ( length(y) > 0 ) {
    col = c("black", "green", "blue", "magenta", "cyan")
    plot(x,y, col=col[1], pch = 19, cex = 0.2, main = "Moving Window Means after break")
    # lines(x, runmean(y, 3), col=col[2], lwd=2)
    lines(x, runmean(y, 8), col = col[2], lwd = 2)
    lines(x, runmean(y,15), col = col[3], lwd = 2)
    lines(x, runmean(y,24), col = col[4], lwd = 2)
    lines(x, runmean(y,50), col = col[5], lwd = 2)
    lab = c("data",  "k=8", "k=15", "k=24", "k=50")
    legend("bottomleft", lab, col = col, lty = 1 )
}


## select running mean window to use
rmn  = 15


#'
#' **We will use running mean with a window of `r rmn` days**.
#'
#' **and interpolate to get a daily value to fill the gaps**
#'


## do running mean for two periods
rnmD        <- c(runmean( statist$Dmean[sel_1], rmn ), runmean( statist$Dmean[sel_2], rmn ) )
runningDark <- data.frame(Date = statist$Date, DARK = rnmD)


## create interpolated data to fill any gap in the running mean
runningDark_valid <- runningDark[!is.nan(runningDark$DARK),]


## use this function to fill the gaps
runningDark_valid_func <- approxfun(runningDark_valid$Date,runningDark_valid$DARK)

## gaps are NA
runningDark$DARK[is.nan(runningDark$DARK)] <- NA

#'
#' There are `r sum(is.na(runningDark$DARK))` missing dark cases to fill.
#'

## use function to fill gaps
runningDark$DARK[is.na(runningDark$DARK)]  <- runningDark_valid_func(runningDark$Date[is.na(runningDark$DARK)])

# rnmD = c(runmean( statist$Dmean[sel_1], rmn, endrule = "NA" ),
#          runmean( statist$Dmean[sel_2], rmn, endrule = "NA" ) )
plot(statist$Date, statist$Dmean, pch = 19, cex = 0.2, main = paste("Running mean of ", rmn, " days") )
lines(statist$Date, rnmD, "l", col = "red", lwd = 2 )



## keep dark constructed signal for reference when missing
save( darkmean, darkmedian, runningDark,
      file = DARKFILE, compress = TRUE)







## END ##
tac = Sys.time()
cat(sprintf("\n%s %s %s %s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
