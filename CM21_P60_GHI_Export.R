# /* #!/usr/bin/env Rscript */
# /* Copyright (C) 2019 Athanasios Natsis <natsisthanasis@gmail.com> */
#'
#' ---
#' title: "CM21 daily GHI complete dark correction."
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
knitr::opts_chunk$set(dev        = "png"   )

knitr::opts_chunk$set(fig.width  = 8       )
knitr::opts_chunk$set(fig.height = 6       )

knitr::opts_chunk$set(out.width  = "60%"    )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'     )


####_ Notes _####

#
# this script substitutes CM_P03_import_Data_wo_bad_dates.r
#






####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM21_P60_GHI_Export.R")

## FIXME this is for pdf output
# options(warn=-1)

#+ echo=F, include=F
library(data.table, quietly = T)
library(pander,     quietly = T)
# library(RAerosols,  quietly = T)
source("/home/athan/CM_21_GLB/CM21_functions.R")
#'

####  . Variables  ####
source("/home/athan/CM_21_GLB/DEFINITIONS.R")

tag = paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))



## PATHS
missfiles  = paste0(BASED, "LOGS/", Script.Name ,"_missingfilelist.dat" )
tmpfolder  = paste0("/dev/shm/", sub(pattern = "\\..*", "" , Script.Name))
dailyplots = paste0(BASED,"/REPORTS/", sub(pattern = "\\..*", "" , Script.Name), "_daily.pdf")
daylystat  = paste0(dirname(GLOBAL_DIR), "/", sub(pattern = "\\..*", "" , Script.Name),"_stats")



## create a new temp dir
unlink(tmpfolder, recursive = TRUE)
dir.create(tmpfolder, showWarnings = FALSE)



TEST      = TRUE
TEST      = FALSE



## . get data input files ####
input_files <- list.files( path       = GLOBAL_DIR,
                           pattern    = "LAP_CM21H_GHI_[0-9]{4}_L1.Rds",
                           full.names = T )
input_files <- sort(input_files)

## . get functions for missing dark resolution
## were precomputed at the previus step
load(DARKFILE)




#'
#' ## Info
#'
#' Apply dark correction on days with missing dark.
#'



## loop all input files

statist <- data.table()
pbcount = 0

#+ include=TRUE, echo=F, results="asis"
for (afile in input_files) {

    print(afile)

    } #END loop of days





## END ##
tac = Sys.time(); cat(paste("\n  --  ",  Script.Name, " DONE  --  \n"))
cat(sprintf("%s %s %s %s  %f mins\n\n",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")))
