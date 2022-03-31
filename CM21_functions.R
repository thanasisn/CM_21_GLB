
Sys.setenv(TZ = "UTC")
# require(xts)  ## index command




#' Title
#'
#' @param elevatio   Vector record of sun elevation
#' @param nightlimit Sun elevation limit to consider night time
#' @param dates      Vector record of dates
#' @param dstretch   Duration of dark signal sample
#' @param values     Vector of signal values
#'
#' @return           Data frame with dark signal statistical values
#' @export
#'
dark_calculations <- function(elevatio,
                              nightlimit,
                              dates,
                              dstretch,
                              values) {
    ## find local noun
    nounindex    <- match( max(elevatio), elevatio )
    ## split day in half
    selectmorn   <- elevatio < nightlimit & zoo::index(elevatio) < nounindex
    selecteven   <- elevatio < nightlimit & zoo::index(elevatio) > nounindex
    ## all morning and evening dates
    morning      <- dates[selectmorn]
    evening      <- dates[selecteven]

    ## morning selection with time limit
    mornigend    <- morning[max(zoo::index(morning))]
    mornigstart  <- mornigend - dstretch
    ## selection for morning dark
    morningdark  <- selectmorn & dates <= mornigend & mornigstart < dates

    ## evening selection with time limit
    eveningstart <- evening[min(zoo::index(evening))]
    eveningend   <- eveningstart + dstretch
    ## selection for evening dark
    eveningdark  <- selecteven & dates >= eveningstart & dates < eveningend

    return(
        data.frame(
            Mavg = mean(      values[morningdark],  na.rm = TRUE ),
            Mmed = median(    values[morningdark],  na.rm = TRUE ),
            Msta = max(       dates[ morningdark],  na.rm = TRUE ),
            Mend = min(       dates[ morningdark],  na.rm = TRUE ),
            Mcnt = sum(!is.na(values[morningdark])),
            Eavg = mean(      values[eveningdark],  na.rm = TRUE ),
            Emed = median(    values[eveningdark],  na.rm = TRUE ),
            Esta = min(       dates[ eveningdark],  na.rm = TRUE ),
            Eend = max(       dates[ eveningdark],  na.rm = TRUE ),
            Ecnt = sum(!is.na(values[eveningdark]))
        )
    )

    #
    # return(list( Mavg = mean(      datavalues_M,  na.rm = TRUE ),
    #              Mmed = median(    datavalues_M,  na.rm = TRUE ),
    #              Msta = max(       datedates_M,   na.rm = TRUE ),
    #              Mend = min(       datedates_M,   na.rm = TRUE ),
    #              Mcnt = sum(!is.na(datavalues_M)),
    #              Eavg = mean(      datavalues_E,  na.rm = TRUE ),
    #              Emed = median(    datavalues_E,  na.rm = TRUE ),
    #              Esta = min(       datedates_E,   na.rm = TRUE ),
    #              Eend = max(       datedates_E,   na.rm = TRUE ),
    #              Ecnt = sum(!is.na(datavalues_E))
    # ))

}




dark_function <- function( dark_day,
                           DCOUNTLIM,
                           type,
                           dd,
                           test,
                           missfiles,
                           missingdark) {
    ## ignore dark signal if too low counts
    if (dark_day$Mcnt < DCOUNTLIM) { dark_day$Mmed = dark_day$Mavg = NA }
    if (dark_day$Ecnt < DCOUNTLIM) { dark_day$Emed = dark_day$Eavg = NA }

    if (type == "mean") {
        # print("use mean for dark correction")
        ## Values to use
        dar_x = c(dark_day$Msta, dark_day$Esta)
        dar_y = c(dark_day$Mavg, dark_day$Eavg)

    } else if (type == "median") {
        # print("use median for dark correction")
        ## Values to use
        dar_x = c(dark_day$Msta, dark_day$Esta)
        dar_y = c(dark_day$Mmed, dark_day$Emed)

    } else {
        print("Don't know what to do")
        stop("Invalid argument in Dark correction")
    }


    ## Choose scenario based on available dark information
    ## with left and right dark
    if (sum(is.na( dar_y )) == 0) {
        dark_line = approxfun(x = dar_x,
                              y = dar_y,
                              rule = 2,
                              method = "linear")
    }

    ## with only left dark
    if ( sum(is.na( dar_y )) == 1 ) {
        dark_line = approxfun(x = dar_x[!is.na( dar_y )],
                              y = dar_y[!is.na( dar_y )],
                              method = "constant",
                              rule = 2 )
    }

    ## with out dark should break!
    if ( sum(is.na( dar_y )) >= 2 ) {
        text = paste( as.POSIXct(dd, origin = "1970-01-01" ), test, "No dark don't know what to do!! using ", missingdark, " for Dark!!" )
        # cat(text, sep = "\n\n")
        warning(text)
        cat(text, sep = "\n", file = missfiles, append = TRUE)

        ## protect from empty variable
        if (is.na(missingdark)) {
            stop("no value for dark given")
        }

        ## create dummy dark signal for correction
        ####FIXME this can change to a set value after processing from statistics -----
        dark_line = approxfun(x = dar_x,
                              y = c(missingdark, missingdark),
                              rule = 2,
                              method = "linear")

        # stop("\n",message, "\nFunction:\nfdfsf\n")
    }

    return(dark_line)
}




plot_norm <- function(daydata, test, tag) {
    ## Main data plot
    dddd = min(daydata$Global, daydata$GLstd , na.rm = TRUE)
    uuuu = max(daydata$Global, daydata$GLstd , na.rm = TRUE)
    if (dddd > -5  ) { dddd = 0  }
    if (uuuu < 190 ) { uuuu = 200}
    ylim = c(dddd , uuuu)

    plot(daydata$Date30, daydata$Global,
         "l", xlab = "UTC", ylab = "W/m^2",
         col  = "blue", lwd = 1.1, lty = 1, xaxt = "n", ylim = ylim )
    abline(h = 0, col = "gray60")
    abline(v   = axis.POSIXct(1, at = pretty(daydata$Date30, n = 12, min.n = 8 ), format = "%H:%M" ),
           col = "lightgray", lty = "dotted", lwd = par("lwd"))
    points(daydata$Date30, daydata$GLstd, pch = ".", cex = 2, col = "red" )
    title( main = paste(test, format(daydata$Date30[1] , format = "  %F")))
    text(daydata$Date30[1], uuuu, labels = tag, pos = 4, cex =.7 )
}



plot_norm2 <- function(daydata, test, tag) {
    ## Main data plot
    dddd = min(daydata$Global, daydata$GLstd , na.rm = TRUE)
    uuuu = max(daydata$Global, daydata$GLstd , na.rm = TRUE)
    if (dddd > -5  ) { dddd = 0  }
    if (uuuu < 190 ) { uuuu = 200}
    ylim = c(dddd , uuuu)

    plot(daydata$Date, daydata$Global,
         "l", xlab = "UTC", ylab = expression(W / m^2),
         col  = "blue", lwd = 1.1, lty = 1, xaxt = "n", ylim = ylim, xaxs = "i" )
    abline(h = 0, col = "gray60")
    abline(v   = axis.POSIXct(1, at = pretty(daydata$Date, n = 12, min.n = 8 ), format = "%H:%M" ),
           col = "lightgray", lty = "dotted", lwd = par("lwd"))
    points(daydata$Date, daydata$GLstd, pch = ".", cex = 2, col = "red" )
    title( main = paste(test, format(daydata$Date[1] , format = "  %F")))
    text(daydata$Date[1], uuuu, labels = tag, pos = 4, cex =.7 )
}






