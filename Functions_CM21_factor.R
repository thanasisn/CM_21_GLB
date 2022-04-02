
Sys.setenv(TZ = "UTC")
## check date function
is.POSIXct <- function(x) inherits(x, "POSIXct")

## values from CM21_caldata_06.txt
## define data
calibration_data <- matrix(
       c( "1991-01-01", 11.98E-6, 0.5E-2,
          "1995-10-21", 11.98E-6, 2E-2,
          "1995-11-01", 11.98E-6, 1E-2,
          "2004-07-01", 11.98E-6, 4E-2,
          "2005-12-05", 11.99E-6, 4E-2,
          "2011-12-30", 11.96E-6, 4E-2,
          "2012-01-31", 11.96E-6, 4E-2  ),
       byrow = TRUE,
       ncol = 3)
## read to data frame
calibration_data <- data.frame(Date = as.POSIXct( calibration_data[,1] ),
                               Sens = as.numeric( calibration_data[,2] ),
                               Gain = as.numeric( calibration_data[,3] ) )

## interpolation functions
sensitivity <- approxfun( x      = calibration_data$Date,
                          y      = calibration_data$Sens,
                          rule   = 1:2  )

gain        <- approxfun( x      = calibration_data$Date,
                          y      = calibration_data$Gain,
                          method = "constant",
                          rule   = 1:2  )


#' Conversion factor from volt to watt for CM21
#'
#' @details This uses both the sensitivity of the instruments and the gain
#' factor of the measurement device.
#'
#' @param date POSIXct date for the factor
#'
#' @return (numeric) Conversion factor
#' @family CM 21 functions
#' @export
cm21factor <- function(date) {
    if (is.POSIXct(date)) {
        return( gain(date) / sensitivity(date) )
    } else {
        stop("input must be POSIXct.\n you gave : ",date)
    }
}


## current values used
SENSITICM21  = 11.96    # μV/W/m^2
CFACTOR      = 40000    # measurement instrument conversion CM21

## create some test graphs
dates <- seq(calibration_data$Date[1],Sys.time(),by="day")

plot(dates, sensitivity(dates), pch = ".", main = "CM21 Sensitivity")
points(calibration_data$Date, calibration_data$Sens, col = "green")

plot(dates, gain(dates),        pch = ".", main = "CM21 Acquisition gain")
points(calibration_data$Date, calibration_data$Gain,  col = "cyan")

plot(dates, gain(dates) / sensitivity(dates),
                                pch = ".", main = "CM21 signal to radiation factor")
points(calibration_data$Date, calibration_data$Gain / calibration_data$Sens, col = "orange" )


plot(calibration_data$Date, c(NA, diff(calibration_data$Sens)),
     main = "CM21 calibration factor change")

plot(calibration_data$Date, 100*c(NA, diff(calibration_data$Sens))/calibration_data$Sens ,
     main = "CM21 calibration factor change %")


