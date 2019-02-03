# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2018 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 signal inspection."
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

knitr::opts_chunk$set(out.width  = "60%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )


####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P01_Inspect_data.R")


library(data.table)
library(pander)


####  . . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")


#'
#' ## Info
#'
#' Raw data from CM21 without any filtering.
#'


signal_files <- list.files(path        = SIGNAL_DIR,
                           pattern     = "LAP_CM21H_SIG_[0-9]{4}.rds$",
                           ignore.case = T,
                           full.names  = T)
signal_files <- sort(signal_files)


all_data <- data.table()


#+ include=TRUE, echo=F, results="asis"
for (ff in signal_files) {
    dyear <- readRDS(ff)
    yyyy = format(dyear$Date[1], "%Y")

    cat(paste("\\newpage\n"))
    cat(paste("## ",yyyy,"\n"))

    panderOptions('table.alignment.default', 'right')

    cat('\\scriptsize\n')

    cat(pander::pander( summary(dyear[,-c('Date','Azimuth')]) ))

    cat('\\normalsize\n')

    cat('\n')

    hist(dyear$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )

    hist(dyear$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )

    plot(dyear$Elevat, dyear$CM21value, pch = 19, cex = .8,
         main = paste("CM21 signal ", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal" )

    plot(dyear$Elevat, dyear$CM21sd,    pch = 19, cex = .8,
         main = paste("CM21 signal SD", yyyy ),
         xlab = "Elevation",
         ylab = "CM21 signal Standard Deviations")

    cat('\n')
    cat('\n')


}
#'



# gather_dir <- tempdir()
# cnt=0
# for (ff in signal_files) {
#     dyear <- readRDS(ff)
#     yyyy = format(dyear$Date[1], "%Y")
#
#     cnt <- cnt + 1
#     png(paste0(gather_dir,"/",sprintf("%05d.png", cnt)))
#     hist(dyear$CM21value, breaks = 50, main = paste("CM21 signal ", yyyy ) )
#     dev.off()
#
#     cnt <- cnt + 1
#     png(paste0(gather_dir,"/",sprintf("%05d.png", cnt)))
#     hist(dyear$CM21sd,    breaks = 50, main = paste("CM21 signal SD", yyyy ) )
#     dev.off()
#
#     cnt <- cnt + 1
#     png(paste0(gather_dir,"/",sprintf("%05d.png", cnt)))
#     plot(dyear$Elevat, dyear$CM21value, pch = 19, cex=.8,main = paste("CM21 signal ", yyyy )  )
#     dev.off()
#
#     cnt <- cnt + 1
#     png(paste0(gather_dir,"/",sprintf("%05d.png", cnt)))
#     plot(dyear$Elevat, dyear$CM21sd,    pch = 19, cex=.8,main = paste("CM21 signal SD", yyyy )  )
#     dev.off()
#
# }
#
# system(paste0( "convert ", gather_dir,"/*.png  ", Script.Name,".pdf") )


## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %10s %10s %25s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
