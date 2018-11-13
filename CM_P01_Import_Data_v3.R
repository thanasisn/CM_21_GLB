#!/usr/bin/env Rscript
#' Copyright (C) 2016 Athanasios Natsis <natsisthanasis@gmail.com>
#'

#'
#' Read all raw data and create
#' database of all data
#' pdf of all days
#' statistic on days
#' NO FILTERING initial data import
#'
#' FIXME
#' Note processing 2007-2018 is very hard even for crane
#' should break up the calculations
#'

closeAllConnections()
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic = Sys.time()
Script.Name = c("CM_P01_Import_Data_v3.R")

library(xts)  ## index command

TEST = TRUE
TEST = FALSE

## root folder
BASED  = "/home/athan/Aerosols/CM21datavalidation/"
## data export folder
DATOUT = "/home/athan/DATA/cm21_data_validation/"
## report folder
REPRTD = paste0(BASED, "REPORTS/")


## INPUT
datadir     = "/home/athan/DATA_RAW/Bband/AC21_LAP.GLB/"
sunfolder   = "/home/athan/DATA_RAW/SUN/PySolar_LAP/"
toodaddate  = paste0(BASED, "/toobaddates.dat")
suspectdays = paste0(BASED, "/suspects_cleaned.dat")
# suspectdays = paste0(BASED, "/suspects_initial.dat")


## OUTPUT
datafile   = paste0( DATOUT, "/P01_allcm21data" )
daylystat  = paste0( DATOUT, "/P01_allcm21stat" )
missfiles  = paste0( REPRTD, "/P01 missingfilelist.dat"    )
pdfgraphs  = paste0( REPRTD, "/P01 normal plot w dark.pdf" )
suspects   = paste0( REPRTD, "/P01 suspects cleaned.pdf"   )


source( paste0(BASED, "CM21_functions.R"))


DARK_ELEV  = -10         ## sun elevation limit
DSTRETCH   =  20 * 3600  ## time duration of dark signal for morning and evening of the same day
DCOUNTLIM  =  10         ## if dark signal has fewer valid measurements than these ignore it

## date range to process
startday   = as.POSIXct("2007-01-01 00:00:00 UTC")
endtoday   = as.POSIXct("2018-01-01 00:00:00 UTC")

tag = paste0("Natsis Athanasios LAP AUTH ",
             strftime(Sys.time(), format = "%b %Y" ))

## bad dates
toobaddates <- read.table(toodaddate, as.is = TRUE, comment.char = "#")
toobaddates <- as.POSIXct(toobaddates$V1, format = "%Y-%m-%d")

## suspect days
suspecdates <- read.table(suspectdays, as.is = TRUE, comment.char = "#")
suspecdates <- as.POSIXct(suspecdates$V1, format = "%Y-%m-%d")


## list all available files
all_files <- list.files(path        = datadir,
                        recursive   = TRUE,
                        pattern     = "[0-9]*06.LAP",
                        ignore.case = TRUE,
                        full.names  = TRUE)
stopifnot( length(all_files) > 1 )

## sequence of all days to try-check
daystodo <- seq( from = startday, to = endtoday, by = "day" )

#### !! FOR TESTS !! ######################
if (TEST) {
    cat(" !! TEST is ENABLED !! \n")
    daystodo <- sample(daystodo, 10)
}
###########################################


#### PLOT ALL ####

## dataframes to gather data
alldata = data.frame()
statist = data.frame()
totals  = length(daystodo)
pbcount = 0
stime   = Sys.time()
## graphs options
par(mar = c(4,4,3,1))
pdf(pdfgraphs, onefile = TRUE)

## iterate all days
for (dd in daystodo) {
    ## try to read the right file
    theday  = as.POSIXct(dd, origin = "1970-01-01")
    test    = format( theday, format = "%d%m%y06" )
    afile   = all_files[grep(test, all_files)]
    sunfl   = paste0(sunfolder,"sun_path_",format(theday, "%F"), ".dat.gz")
    dayCMCF = cm21factor(theday)
    day     = data.frame()
    pbcount = pbcount + 1

    ## recreate time stamp for all minutes of this day
    suppressWarnings(rm(D_minutes))
    D_minutes = seq(from = as.POSIXct(paste(theday,"00:00:30 UTC")), length.out = 1440, by = "min" )

    ## multiple file match resolution
    if (length(afile) > 1) {
        print("too much files found you have to solve this")
        print(afile)
        stop()            ## stop execution
        # afile = afile[1]  ## select the first file
    }

    ## log missing files
    if ( length(afile) == 0 ) {
        text = paste( as.POSIXct(dd, origin = "1970-01-01" ), test, "missing file" )
        cat(text, sep = "\n", file = missfiles, append = TRUE)
        cat(text, sep = "\n")

    ## do when files present
    } else {
        suppressWarnings(remove(daydata, sun_temp))
        ## read sun data
        if ( !file.exists( sunfl ) ) stop(cat(paste("Missing:", sunfl, "\nRun:   Sun_vector_constraction_cron.py?\n")))
        sun_temp <- read.table( sunfl,
                                sep = ";",
                                header = TRUE,
                                na.strings = "None" ,strip.white = TRUE,  as.is = TRUE)

        #### READ RAW DATA ##########################################
        ## RAW DATA IS NOT IN UNIFORM FORMAT
        # daydata <- read.table(textConnection(gsub(",", " ", readLines(afile))))
        daydata <- as.data.frame( data.table::fread(afile) )

        ## Filter known missing data
        ## all -9 to NA
        daydata[ daydata <= -9 ] <- NA
        ## missing measurments also drop stdev
        daydata$V2[ is.na(daydata$V1) ] <- NA
        #############################################################

	## check that that there are data
        if ( all(is.na(daydata$V1)) ) {
            ## the file has no valid data
            text = paste( as.POSIXct(dd, origin = "1970-01-01" ), test, "stub file no usable data" )
            cat(text, sep = "\n", file = missfiles, append = TRUE)
        } else {

            ## missing minutes records protection lap files normaly have 1440 records
            if ( length(daydata[,1]) != 1440 ) {
                print(paste(theday, afile, "MISSING MINUTES"))
                stop(sprintf("\n  !!  Today’s data less than 1440 as expected %s !!  \n"))
            }

            ## assign correct dates to each record.
            daydata$Date30 <- D_minutes

            daydata$Global <- daydata$V1  * dayCMCF
            daydata$GLstd  <- daydata$V2  * dayCMCF
            daydata$Eleva  <- sun_temp$ELEV

            #########################################################
            #### Dark calculations
            #########################################################
            dark_day <- dark_calculations( dates    = daydata$Date30,
                                           values   = daydata$Global,
                                           elevatio = daydata$Eleva,
                                           darklim  = DARK_ELEV,
                                           dstretch = DSTRETCH)


            #########################################################
            #### Dark Correction
            #########################################################
            dark_line <-  dark_correction(dark_day    = dark_day,
                                          DCOUNTLIM   = DCOUNTLIM,
                                          type        = "median",
                                          dd          = dd,
                                          test        = test,
                                          missfiles   = missfiles,
                                          missingdark = 0 )

            ## create dark signal for correction
            todaysdark = dark_line(daydata$Date30)
            #########################################################

            #### Apply dark correction ##############################
            daydata$Global = daydata$Global - todaysdark
            #########################################################

            plot_norm(daydata, test, tag)

            # plot(daydata$Date30, todaysdark)


    #         ## Dark signal plot
    #         plot(daydata$Date30, todaysdark, "l",xlab = "UTC", ylab = "W/m^2")
    #         abline(v   = axis.POSIXct(1, at = pretty(daydata$Date30, min.n = 8 ), format = "%H:%M" ),
    #             col = "lightgray", lty = "dotted", lwd = par("lwd"))
    #         title(main=paste(test, format(daydata$Date30[1] , format = "  %F")))

            day    = data.frame(Date  = theday,
                                CMCF  = dayCMCF,
                                NAs   = sum(is.na(daydata$Global)          ),
                                SunUP = sum(      daydata$Eleva >= 0       ),
                                MinVa = min(      daydata$V1,     na.rm = T),
                                MaxVa = max(      daydata$V1,     na.rm = T),
                                AvgVa = mean(     daydata$V2,     na.rm = T),
                                MinGL = min(      daydata$Global, na.rm = T),
                                MaxGL = max(      daydata$Global, na.rm = T),
                                AvgGL = mean(     daydata$Global, na.rm = T),
                                sunMeas = sum(    daydata$Eleva >= 0  &  !is.na(daydata$Global)),
                                Mavg  = dark_day$Mavg,
                                Mmed  = dark_day$Mmed,
                                Msta  = dark_day$Msta,
                                Mend  = dark_day$Mend,
                                Mcnt  = dark_day$Mcnt,
                                Eavg  = dark_day$Eavg,
                                Emed  = dark_day$Emed,
                                Esta  = dark_day$Esta,
                                Eend  = dark_day$Eend,
                                Ecnt  = dark_day$Ecnt
                                )
            suppressWarnings(
                rm( Mavg, Mmed, dayCMCF, Msta,
                    Mend, Mcnt, Eavg, Emed, Esta, Eend,
                    Ecnt, todaysdark, dark_line )
            )

            ## gather days
            alldata = rbind(alldata, daydata)
            statist = rbind(statist, day )

            eta = difftime(Sys.time(),stime) *(totals/pbcount - 1)
            cat( sprintf( "%6.2f%%   %6.2f mins  %s   \r", 100*(pbcount/totals) , eta, as.Date(theday) ) )
        } #END If the file has valid data
    }#END if the data file exist
} #END loop of days
dev.off() # close pdf


## WRITE DATA TO FILES
if ( ! TEST ) {
    cat(paste("Write data to disk!" ))

    # RAerosols::write_RDS( alldata, datafile  )
    # RAerosols::write_RDS( statist, daylystat )

    saveRDS(alldata, datafile,  compress = "xz")
    saveRDS(statist, daylystat, compress = "xz")
}

## remove too bad days
daystodo = daystodo[!is.element(daystodo, toobaddates )]

## plot only remaining suspects!!
suspecdates = suspecdates[!is.element(suspecdates, toobaddates )]



# stop()


#### PLOT SUSPECTS ####
cat(paste("Plot suspect days!" ))


## dataframes to gather data
totals = length(suspecdates)
pbcount = 0
stime = Sys.time()
## graphs options
par(mar = c(4,4,3,1))
pdf(suspects, onefile = TRUE)
## iterate all days
for (dd in suspecdates) {
    ## try to read the right file
    theday  = as.POSIXct(dd, origin = "1970-01-01")
    test    = format( theday, format = "%d%m%y06" )
    afile   = all_files[grep(test, all_files)]
    sunfl   = paste0(sunfolder,"sun_path_",format(theday, "%F"), ".dat.gz")
    dayCMCF = cm21factor(theday)
    day     = data.frame()
    pbcount = pbcount + 1

    ## recreate time stamp for all minutes of this day
    suppressWarnings(rm(D_minutes))
    D_minutes <- seq(from = as.POSIXct(paste(theday,"00:00:30 UTC")), length.out = 1440, by = "min" )

    ## multiple file match resolution
    if (length(afile) > 1) {
        print("too much files found you have to solve this")
        print(afile)
        stop()            ## stop execution
        # afile = afile[1]  ## select the first file
    }

    ## log missing files
    if ( length(afile) == 0 ) {
        text = paste( as.POSIXct(dd, origin = "1970-01-01" ), test, "missing file" )
        cat(text, sep = "\n")

        ## do when files present
    } else {
        suppressWarnings(remove(daydata, sun_temp))
        ## read sun data
        if ( !file.exists( sunfl ) ) stop("Sun file missing, run Sun_vector_constraction_cron.py")
        sun_temp = read.table( sunfl,
                               sep = ";",
                               header = TRUE,
                               na.strings = "None" ,strip.white = TRUE,  as.is = TRUE)

        #### READ RAW DATA ##############################################################
        ## RAW DATA IS NOT IN UNIFORM FORMAT
        daydata = read.table(textConnection(gsub(",", " ", readLines(afile))))
        ## Filter known missing data
        ## all -9 to NA
        daydata[ daydata <= -9 ] <- NA
        ## missing measurments also drop stdev
        daydata$V2[ is.na(daydata$V1) ] <- NA
        #################################################################################



        if ( all(is.na(daydata$V1)) ) {
            ## the file has no valid data
            text = paste( as.POSIXct(dd, origin = "1970-01-01" ), test, "stub file no usable data" )
            cat(text, sep = "\n", file = missfiles, append = TRUE)
        } else {

            ## missing minutes records protection lap files normaly have 1440 records
            if ( length(daydata[,1]) != 1440 ) {
                print(paste(theday, afile, "MISSING MINUTES"))
                stop(sprintf("\n  !!  Today’s data less than 1440 as expected %s !!  \n"))
            }


            ## assign correct dates to each record.
            daydata$Date30 = D_minutes
            ## assign elevation angle
            daydata$Eleva  = sun_temp$ELEV



            ## Convert to irradiance
            daydata$Global = daydata$V1  * dayCMCF
            daydata$GLstd  = daydata$V2  * dayCMCF


            #########################################################
            #### Dark calculations
            #########################################################
            dark_day <- dark_calculations( dates    = daydata$Date30,
                                           values   = daydata$Global,
                                           elevatio = daydata$Eleva,
                                           darklim  = DARK_ELEV,
                                           dstretch = DSTRETCH)

            #########################################################
            #### Dark Correction
            #########################################################

            dark_line <-  dark_correction(dark_day = dark_day,
                                          DCOUNTLIM = DCOUNTLIM,
                                          type = "median",
                                          dd = dd ,
                                          test = test,
                                          missfiles = missfiles,
                                          missingdark = 0 )


            ## create dark signal for correction
            todaysdark = dark_line(daydata$Date30)

            #########################################################


            ## apply dark correction
            daydata$Global = daydata$Global - todaysdark

            plot_norm(daydata, test, tag)

            plot(daydata$Date30, todaysdark)

            #         ## Dark signal plot
            #         plot(daydata$Date30, todaysdark, "l",xlab = "UTC", ylab = "W/m^2")
            #         abline(v   = axis.POSIXct(1, at = pretty(daydata$Date30, min.n = 8 ), format = "%H:%M" ),
            #             col = "lightgray", lty = "dotted", lwd = par("lwd"))
            #         title(main=paste(test, format(daydata$Date30[1] , format = "  %F")))

            suppressWarnings(
            rm( Mavg, theday, Mmed, dayCMCF, Msta,
                Mend, Mcnt, Eavg, Emed, Esta, Eend,
                Ecnt, todaysdark, dark_line )
               )

            eta = difftime(Sys.time(),stime, units = "mins") * ( totals / pbcount - 1)
            cat( sprintf( "%6.2f%%   %6.2f mins", 100*(pbcount/totals) , eta ), sep = "\n" )

        } #END If the file has valid data
    }#END if the data file exist
} #END loop of days
dev.off() # close pdf


## info of script run
tac = Sys.time(); cat( print( tac - tic) )
cat(paste("\n  --  ",  Script.Name, " DONE  --  \n\n"))
write(sprintf("%s %-10s %-10s %-50s %f",Sys.time(),Sys.info()["nodename"],Sys.info()["login"],Script.Name,difftime(tac,tic,units="mins")),"~/Aerosols/CM21datavalidation/run.log",append=T)
