# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

#### Functions including the calibration factors of the instruments and the acquisition system.

Sys.setenv(TZ = "UTC")

####  Check input date help function  ####
is.POSIXct <- function(x) inherits(x, "POSIXct")

####  Calibration values from CM21_caldata_06.txt  ####
cm21_calibration_data <- matrix(
       c( "1991-01-01", 11.98E-6, 0.5E-2,
          "1995-10-21", 11.98E-6,   2E-2,
          "1995-11-02", 11.98E-6,   1E-2,  ## <- this is correct!!!
          "2004-07-01", 11.98E-6,   4E-2,  ## <- date is not correct needs a shift
          "2004-07-22", 11.98E-6,   4E-2,  ## <- date is not correct needs a shift
          "2005-12-05", 11.99E-6,   4E-2,
          "2011-12-30", 11.96E-6,   4E-2,
          "2012-01-31", 11.96E-6,   4E-2,
          "2022-06-04", 12.02E-6,   4E-2  ),
       byrow = TRUE,
       ncol = 3)


## Format to data frame
cm21_calibration_data <- data.frame(Date        = as.POSIXct( cm21_calibration_data[,1] ),
                                    Sensitivity = as.numeric( cm21_calibration_data[,2] ),
                                    Gain        = as.numeric( cm21_calibration_data[,3] ))

####  Interpolation functions with extend to right rule  ####
cm21_sensitivity <- approxfun( x      = cm21_calibration_data$Date,
                               y      = cm21_calibration_data$Sensitivity,
                               rule   = 1:2  )

cm21_gain        <- approxfun( x      = cm21_calibration_data$Date,
                               y      = cm21_calibration_data$Gain,
                               method = "constant",
                               rule   = 1:2  )


#'
#' Conversion factor from volt to watt for CM-21
#'
#' @details      This uses both the sensitivity of the instruments and
#'               the gain factor of the measurement device.
#'
#' @param  date  POSIXct date input for the conversion factor
#'
#' @return (numeric) Conversion factor
#'
#' @export
cm21factor <- function(date) {
    if (is.POSIXct(date)) {
        return( cm21_gain(date) / cm21_sensitivity(date) )
    } else {
        stop("input must be POSIXct.\n you gave : ",date)
    }
}



####  Set possible signal range on acquisition  ####
signal_physical_limits <- matrix(
    c( "1991-01-01",       -1.0, 5.0,
       "1995-10-21",       -0.4, 1.2,
       "1995-11-02",       -0.6, 2.5,
       "2004-07-01",       -0.2, 0.6,
       "2004-07-03 00:00", -0.2 + 2.5, 0.6 + 2.5, ## there is a siglnal offset
       "2004-07-22 00:00", -0.2, 0.6,
       "2005-12-05",       -0.2, 0.6,
       "2011-12-30",       -0.2, 0.6,
       "2012-01-31",       -0.2, 0.6,
       "2022-06-04",       -0.2, 0.6
        ),    byrow = TRUE,
    ncol = 3)

## Format to data frame
signal_physical_limits <- data.frame(Date      = as.POSIXct(signal_physical_limits[,1]),
                                     Lower_lim = as.numeric(signal_physical_limits[,2]),
                                     Upper_lim = as.numeric(signal_physical_limits[,3]))

# cm21factor(signal_physical_limits$Date) * signal_physical_limits$Lower_lim
# cm21factor(signal_physical_limits$Date) * signal_physical_limits$Upper_lim

signal_physical_limits$Lower_radiation_lim <- cm21factor(signal_physical_limits$Date) * signal_physical_limits$Lower_lim
signal_physical_limits$Upper_radiation_lim <- cm21factor(signal_physical_limits$Date) * signal_physical_limits$Upper_lim


####  Functions to get upper and lower limit for acquisition signal  ####
signal_lower_limit <- approxfun(x      = signal_physical_limits$Date,
                                y      = signal_physical_limits$Lower_lim,
                                method = "constant",
                                rule   = 1:2  )

signal_upper_limit <- approxfun(x      = signal_physical_limits$Date,
                                y      = signal_physical_limits$Upper_lim,
                                method = "constant",
                                rule   = 1:2  )


dd <- seq.POSIXt(as.POSIXct("2004-06-01"), as.POSIXct("2004-09-01"), by = "day")
plot(dd, cm21factor(dd))
plot(dd, signal_upper_limit(dd))


