#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()


## TODO
## plot steps
## plot async
## plot sun


library(data.table, quietly = T, warn.conflicts = F)
library(optparse,   quietly = T, warn.conflicts = F)
library(plotly,     quietly = T, warn.conflicts = F)

source("~/CM_21_GLB/Functions_CM21_factor.R")
source("~/CHP_1_DIR/Functions_CHP1.R")


# BROWSER_CMD <- "qutebrowser --backend webengine "
BROWSER_CMD <- "brave-browser --incognito -app=file://"



## Data folder
# FOLDER <- "/home/athan/DATA_RAW/Raddata"
FOLDER <- "/home/athan/DATA_RAW/Bband"


####   Get input    ############################################################
MINDATE <- as.Date("1993-01-01")
MAXDATE <- as.Date(Sys.Date())
MINSTEP <- 1
MAXSTEP <- 400

option_list <-  list(
    make_option(c("-d", "--day"),
                type    = "character",
                default = paste0(year(Sys.Date()), "-01-01"),
                help    = paste0("Start day of ploting yyyy-mm-dd, [",MINDATE,", ",MAXDATE,"]"),
                metavar = "yyyy-mm-dd"),
    make_option(c("-s", "--step"),
                type    = "integer",
                default = 3,
                help    = paste0("Step width in days, [",MINSTEP,", ",MAXSTEP,"]"),
                metavar = "integer")
)
opt_parser <- OptionParser(option_list = option_list)
args       <- parse_args(opt_parser)

STARTDAY <- args$day
STARTDAY <- as.Date(STARTDAY)
STEP     <- args$step

cat("Start day:", paste(STARTDAY),"\n")
cat("Step     :", STEP, "\n")

if ( ! (MINDATE <= STARTDAY & STARTDAY <= MAXDATE)) {
    stop(STARTDAY, " is invalid date")
}

if ( ! (MINSTEP <= STEP & STEP <= MAXSTEP)) {
    stop(STEP, " is invalid step")
}



####    Init    ################################################################

globalfiles <- list.files(path        = FOLDER,
                          recursive   = TRUE,
                          pattern     = "[0-9]*06.LAP$",
                          ignore.case = TRUE,
                          full.names  = TRUE)

directfiles <- list.files(path        = FOLDER,
                          recursive   = TRUE,
                          pattern     = "[0-9]*03.LAP$",
                          ignore.case = TRUE,
                          full.names  = TRUE)

if (STEP == 1) {
    MOVE <- 1
} else {
    MOVE <- STEP - 1
}

daystodo <- seq(STARTDAY, MAXDATE, by = MOVE)


# daystodo <- daystodo[1:3]

## loop plots
for (ap in daystodo) {
    toplot <- seq.Date( as.Date(ap, origin = "1970-01-01"), length.out = STEP, by = "day")
    gather <- data.table()

    ## loop days to plot with step
    for (ad in toplot) {
        theday    <- as.Date(ad, origin = "1970-01-01")
        strday    <- format(theday,"%d%m%y")

        glbfile   <- grep( strday, globalfiles, value = T )[1]
        dirfile   <- grep( strday, directfiles, value = T )[1]

        D_minutes <- seq(from       = as.POSIXct(paste(theday,"00:00:00 UTC")),
                         length.out = 1440,
                         by         = "min" )

        if (file.exists(glbfile)) {
            glb <- fread(glbfile)
            names(glb) <- c("GLBsig", "GLBsd")
            glb[ GLBsig < -8, GLBsig := NA ]
            glb[ GLBsd  < -8, GLBsd  := NA ]
        } else {
            cat(paste0("Missing global : ", strday,"06"),"\n")
            glb        <- data.table()
            glb$GLBsig <- rep(NA, 1440)
            glb$GLBsd  <- rep(NA, 1440)
        }
        if (file.exists(dirfile)){
            dir <- fread(dirfile)
            names(dir) <- c("DIRsig", "DIRsd")
            dir[ DIRsig < -8, DIRsig := NA ]
            dir[ DIRsd  < -8, DIRsd  := NA ]
        } else {
            cat(paste0("Missing direct : ", strday,"03"),"\n")
            dir        <- data.table()
            dir$DIRsig <- rep(NA, 1440)
            dir$DIRsd  <- rep(NA, 1440)
        }

        daydt  <- cbind(Date = D_minutes,glb, dir)
        gather <- rbind(gather, daydt)
    }

    ## convert to radiation
    gather$GLBsig <- gather$GLBsig * cm21factor(gather$Date)
    gather$GLBsd  <- gather$GLBsd  * cm21factor(gather$Date)
    gather$DIRsig <- gather$DIRsig * chp1factor(gather$Date)
    gather$DIRsd  <- gather$DIRsd  * chp1factor(gather$Date)

    ## Base Plot
    # xlim <- range(gather$Date)
    # ylim <- range(0, 300, gather$GLBsig, gather$DIRsig, gather$GLBsd, gather$DIRsd, na.rm = T)
    #
    # plot(NULL, xlab="", ylab="", xlim = xlim, ylim = ylim, xaxt = "n")
    # axis.POSIXct(1, gather$Date, format = "%F")
    # axis.POSIXct(1, at = seq(min(gather$Date), max(gather$Date), "2 hours"),
    #           labels = FALSE, tcl = -0.2)
    #
    # lines(gather$Date, gather$GLBsig, col = "green")
    # lines(gather$Date, gather$DIRsig, col = "blue")
    #
    # points(gather$Date, gather$GLBsd, col = "green", pch = 8, cex = 0.3)
    # points(gather$Date, gather$DIRsd, col = "blue" , pch = 8, cex = 0.3)


    ## Plotly

    fig <- plot_ly()
    fig <- add_trace(fig, x = gather$Date, y = gather$DIRsig,
                     name = "Direct beam",
                     line = list(color = "blue"),
                     text = paste(format(gather$Date, "%F %R"),"\n","DBI:",round(gather$DIRsig,1)),
                     hoverinfo = 'text',
                     mode = "lines", type = "scatter")
    fig <- add_trace(fig, x = gather$Date, y = gather$GLBsig,
                     name = "Global",
                     line = list(color = "green"),
                     text = paste(format(gather$Date, "%F %R"),"\n","GHI:",round(gather$GLBsig,1)),
                     # text = paste(round(gather$GLBsig,1)),
                     hoverinfo = 'text',
                     mode = "lines", type = "scatter")

    fig <- add_trace(fig, x = gather$Date, y = gather$DIRsd,
                     name = "Direct beam SD",
                     marker = list(color = "blue", symbol = "asterisk-open", size = 2),
                     # text = paste(format(gather$Date, "%F %R"),"\n",round(gather$DIRsd,1)),
                     text = paste("DBI SD:",round(gather$DIRsd,1)),
                     hoverinfo = 'text',
                     # showlegend = FALSE,
                     mode = 'markers', type = "scatter")
    fig <- add_trace(fig, x = gather$Date, y = gather$GLBsd,
                     name = "Global SD",
                     marker = list(color = "green", symbol = "asterisk-open", size = 2),
                     # text = paste(format(gather$Date, "%F %R"),"\n",round(gather$GLBsd,1)),
                     text = paste("GHI SD:",round(gather$GLBsd,1)),
                     hoverinfo = 'text',
                     # showlegend = FALSE,
                     mode = 'markers', type = "scatter")

    fig <- layout(fig, legend = list(x = 0.85, y = 0.95))
    # fig <- layout(fig, xaxis  = list(showcrossline = T))
    # fig <- layout(fig, hovermode = "x unified")
    fig <- layout(fig, hovermode = "x")

    # fig
    # print(fig)
    # stop()

    # Generate random file name
    temp <- paste(tempfile('plotly'), 'html', sep = '.')
    cat(paste(temp),"\n")

    # Save. Note, leaving selfcontained=TRUE created files that froze my browser
    htmlwidgets::saveWidget(fig, temp, selfcontained = FALSE)

    ## Launch with desired application

    ## must not have other plottly open
    # system(sprintf("brave-browser --incognito -app=file://%s ", temp),
    #        wait = TRUE)

    ## ugly
    # system(sprintf("qutebrowser --backend webengine %s", temp),
    #        wait = TRUE)

    ## slow
    # system(sprintf("firefox %s", temp),
    #        wait = TRUE)

    ## call the file in browser
    system(paste0(BROWSER_CMD, temp), wait = TRUE)

    file.remove(temp)

}
