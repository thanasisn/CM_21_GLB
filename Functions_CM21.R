
Sys.setenv(TZ = "UTC")





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






