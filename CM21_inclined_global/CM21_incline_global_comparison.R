# /* Copyright (C) 2022 Athanasios Natsis <natsisphysicist@gmail.com> */
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
#'
#' date: "`r format(Sys.time(), '%F')`"
#' params:
#'    ALL_YEARS: TRUE
#' ---

#'
#' Compare Inclined CM21 with Global CM21 to produce a calibration factor
#'
#+ echo=F, include=T


####_  Document options _####

#+ echo=F, include=F
knitr::opts_chunk$set(comment    = ""      )
# knitr::opts_chunk$set(dev        = "pdf"   )
knitr::opts_chunk$set(dev        = "png"    )
knitr::opts_chunk$set(out.width  = "100%"   )
knitr::opts_chunk$set(fig.align  = "center" )
knitr::opts_chunk$set(fig.pos    = '!h'     )



#+ include=F, echo=F
####  Set environment  ####
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n\n")
                            return("CM21_R20_") })
if (!interactive()) {
    pdf( file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".pdf", Script.Name))))
    sink(file = paste0("~/CM_21_GLB/RUNTIME/", basename(sub("\\.R$",".out", Script.Name))), split = TRUE)
    filelock::lock(paste0("~/CM_21_GLB/LOGs/", basename(sub("\\.R$",".lock", Script.Name))), timeout = 0)
}


#+ echo=F, include=F
####  External code  ####
library(data.table, quietly = TRUE, warn.conflicts = FALSE)
library(pander,     quietly = TRUE, warn.conflicts = FALSE)
source("~/CM_21_GLB/Functions_write_data.R")
source("~/CM_21_GLB/Functions_CM21_factor.R")


####  Variables  ####
source("~/CM_21_GLB/DEFINITIONS.R")
panderOptions('table.alignment.default', 'right')
panderOptions('table.split.table',        120   )

OutliersPlot <- 5



####  Execution control  ####
## Default
ALL_YEARS <- FALSE
TEST      <- FALSE
# TEST      <- TRUE
# ALL_YEARS <- TRUE

## When running
args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0) {
    if (!TEST | any(args == "NOTEST")) { TEST <- FALSE }
    if (any(args == "NOTALL"  )) { ALL_YEARS <- FALSE }
    if (any(args == "ALL"     )) { ALL_YEARS <- TRUE  }
    if (any(args == "ALLYEARS")) { ALL_YEARS <- TRUE  }
}
## When knitting
if (!exists("params")) {
    params <- list( ALL_YEARS = ALL_YEARS)
}
cat(paste("\n**ALL_YEARS:", ALL_YEARS, "**\n"))
cat(paste("\n**TEST     :", TEST,      "**\n"))

tag <- paste0("Natsis Athanasios LAP AUTH ", strftime(Sys.time(), format = "%b %Y" ))


#'
#' ## Check bad ranges input
#'
#+ include=T, echo=F

####  Load exclusion list  ####

ranges        <- read.table(BAD_RANGES,
                            sep          = ";",
                            colClasses   = "character",
                            strip.white  = TRUE,
                            header       = TRUE,
                            comment.char = "#" )
ranges$From     <- strptime(ranges$From,  format = "%F %H:%M", tz = "UTC")
ranges$Until    <- strptime(ranges$Until, format = "%F %H:%M", tz = "UTC")
ranges$HourSpan <- as.numeric(ranges$Until - ranges$From) / 3600
ranges$Comment[ranges$Comment == ""] <- "NO DESCRIPTION"

#'
#' Check inverted time ranges
#'
#+ include=T, echo=F
pander(ranges[ !ranges$From < ranges$Until, ])
stopifnot(!all(!ranges$From < ranges$Until))


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
input_files <- list.files(path       = SIGNAL_DIR,
                          pattern    = "LAP_CM21_H_SIG_[0-9]{4}.Rds",
                          full.names = TRUE )
input_years <- as.numeric(
    sub(".rds", "",
        sub(".*_SIG_", "", basename(input_files)),
        ignore.case = T))


## Get storage files
output_files <- list.files(path       = SIGNAL_DIR,
                           pattern    = "LAP_CM21_H_S0_[0-9]{4}.Rds",
                           full.names = TRUE )


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

# ## TEST
# if (TEST) {
#     years_to_do <- 2004
# }


## Decide what to do
if (length(years_to_do) == 0 ) {
    stop("NO new data! NO need to parse!")
}
cat(c("\n**YEARS TO DO:", years_to_do, "**\n"))


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
#' Allowed signal of ranges that are possible to be recorded normally.
#'
#+ include=T, echo=F
pander(signal_physical_limits)
#'
#' #### Mark of possible night signal.
#'
#' During night (sun elevation `r paste("<",DARK_ELEV)`) we allow
#' a radiation range of `r paste0("[",MINLIMnight,", " ,MAXLIMnight,"]")`
#' to remove various inconsistencies.
#'
#' #### Filter negative signal when sun is up.
#'
#' Allowed years to do: `r input_years`
#'
#' Years to do: `r years_to_do`
#'
#+ include=T, echo=F





#' **END**
#+ include=T, echo=F
tac <- Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
