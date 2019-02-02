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
#'   html_document: default
#'   odt_document:  default
#'   word_document: default
#' ---

#+ echo=F, include=T


####_  Document options _####

knitr::opts_chunk$set(echo       = FALSE   )
# knitr::opts_chunk$set(cache      = TRUE    )
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
source("/home/athan/CM_21_GLB/DEFINITIONS.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


## PATHS
missfiles  = paste0(BASED, "LOGS/", Script.Name ,"_missingfilelist.dat" )
tmpfolder  = paste0("/dev/shm/", sub(pattern = "\\..*", "" , Script.Name))
dailyplots = paste0(BASED,"/REPORTS/", sub(pattern = "\\..*", "" , Script.Name), "_daily.pdf")
daylystat  = paste0(dirname(GLOBAL_DIR), "/CM21_P30_GHI_daily_filtered_stats.Rds")



## break between 2014-02-04 and 2014-02-05
breakdate  = as.POSIXct("2014-02-05 00:00:00")




## get first approximation statistics
statist <- readRDS(daylystat)



#'
#' ## Info
#'
#' We will use existing daily dark signal values, to infer the dark
#' signal when it can not be computed for a day.
#' This is a result of missing data before sunrize on/and after sunset.
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











## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %s %s %s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
