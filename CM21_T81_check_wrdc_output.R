# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */
#' ---
#' title:         "Inspect WRDC submission"
#' author:        "Natsis Athanasios"
#' institute:     "AUTH"
#' affiliation:   "Laboratory of Atmospheric Physics"
#' abstract:      "Just a simple plot of the submited data"
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
knitr::opts_chunk$set(dev        = "png"    )
knitr::opts_chunk$set(out.width  = "100%"   )
knitr::opts_chunk$set(fig.align  = "center" )
# knitr::opts_chunk$set(fig.pos    = '!h'    )



#+ include=F, echo=F
####  Set environment  ####
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n")
                            return("inspect wrds submition") })
if(!interactive()) {
    pdf(    file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".pdf",  Script.Name))))
    sink(   file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".out",  Script.Name))), split = TRUE)
    filelock::lock(paste0("~/CM_21_GLB/LOGs/",    basename(sub("\\.R$",".lock", Script.Name))), timeout = 0)
}





#+ echo=F, include=F
####  External code  ####
library(data.table)

file <- "~/DATA/cm21_data_validation/CM21_exports/sumbit_to_WRDC_2021.dat"


data <- fread(file)

plot(data$global)




#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
