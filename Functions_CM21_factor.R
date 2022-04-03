
Sys.setenv(TZ = "UTC")

## Check date help function
is.POSIXct <- function(x) inherits(x, "POSIXct")

## Calibration values from CM21_caldata_06.txt
calibration_data <- matrix(
       c( "1991-01-01", 11.98E-6, 0.5E-2,
          "1995-10-21", 11.98E-6,   2E-2,
          "1995-11-01", 11.98E-6,   1E-2,
          "2004-07-01", 11.98E-6,   4E-2,
          "2005-12-05", 11.99E-6,   4E-2,
          "2011-12-30", 11.96E-6,   4E-2,
          "2012-01-31", 11.96E-6,   4E-2  ),
       byrow = TRUE,
       ncol = 3)

## Format to data frame
calibration_data <- data.frame(Date        = as.POSIXct( calibration_data[,1] ),
                               Sensitivity = as.numeric( calibration_data[,2] ),
                               Gain        = as.numeric( calibration_data[,3] ))

## Interpolation functions with extend right rule
sensitivity <- approxfun( x      = calibration_data$Date,
                          y      = calibration_data$Sensitivity,
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
#' @export
cm21factor <- function(date) {
    if (is.POSIXct(date)) {
        return( gain(date) / sensitivity(date) )
    } else {
        stop("input must be POSIXct.\n you gave : ",date)
    }
}

