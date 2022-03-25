#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

## Read total data from sirena


####  Set environment  ####
rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()
Script.Name <- tryCatch({ funr::sys.script() },
                        error = function(e) { cat(paste("\nUnresolved script name: ", e),"\n")
                            return("Undefined R script name!!") })
if(!interactive()) {
    pdf(file=sub("\\.R$",".pdf",Script.Name))
    sink(file=sub("\\.R$",".out",Script.Name,),split=TRUE)
}
Script.Base = sub("\\.R$","",Script.Name)

library(data.table)


#### read all tot files from sirena #####
rdsfile <- "~/DATA/cm21_data_validation/export_all_tot_dat.Rds"
folder  <- "~/DATA/cm21_data_validation/AC21_lap.GLB_TOT"

files <- list.files(folder,
                     pattern     = "[0-9]*\\TOT.*.dat",
                     recursive   = T,
                     ignore.case = T,
                     full.names  = T)

## check if we have to read
if (!file.exists(rdsfile) |  max(file.mtime(files)) > file.mtime(rdsfile)) {
    gather <- data.table()
    for (af in files) {
        temp      <- fread(af)
        partdate  <- sub(".dat", "", sub(".*TOT","",af), ignore.case = T)
        date      <- as.POSIXct(strptime(partdate, "%j%y" ))
        temp$Date <- date
        temp$file <- af
        gather    <- rbind(gather, temp)
        print(date)
    }
    gather[ `[W.m-2]` < -8, `[W.m-2]` := NA ]
    myRtools::writeDATA(gather, rdsfile)
} else {
    gather <- readRDS(rdsfile)
}




## FIXME this is bad!! why 24
table(gather$TIME_UT %/% 1)
hist(round((gather$TIME_UT %% 1) * 60), breaks = 61)
hist(gather$TIME_UT %/% 1, breaks = 25)

gather[ TIME_UT %/% 1 == 24, unique(file)]

gather[ TIME_UT %/% 1 == 24, .N, by = year(Date)]


## add nice date
dateess     <- paste( gather$Date,  gather$TIME_UT %/% 1, round((gather$TIME_UT %% 1) * 60) )
gather$Date <- as.POSIXct( strptime(dateess, "%F %H %M") )
setorder(gather,Date)

## drop some data
gather <- gather[ !is.na(`[W.m-2]`), ]
gather <- gather[ `[W.m-2]` > -5   , ]


## test data
# plot(gather$Date, gather$`[W.m-2]`)
hist(gather$`[W.m-2]`)



# ## apply exclusions this have been done
# ranges       <- read.table( "~/Aerosols/source_R/PARAMETRIC/skip_date_ranges_CM21.txt",
#                             sep = ";",
#                             colClasses = "character",
#                             header = TRUE, comment.char = "#" )
# ranges$From  <- strptime(ranges$From,  format = "%F %H:%M", tz = "UTC")
# ranges$Until <- strptime(ranges$Until, format = "%F %H:%M", tz = "UTC")
#
# for ( i in 1:nrow(ranges) ) {
#     lower <- ranges$From[  i ]
#     upper <- ranges$Until[ i ]
#     ## select to remove
#     select  <- gather$Date >= lower & gather$Date <= upper
#     gather  <- gather[ ! select ]
#     rm(select)
# }




## monthly data
temp <- gather[ , .( Mean   = mean(`[W.m-2]`,   na.rm = T),
                     Max    = max(`[W.m-2]`,    na.rm = T),
                     Min    = min(`[W.m-2]`,    na.rm = T),
                     Median = median(`[W.m-2]`, na.rm = T)
), by = .(year(Date),month(Date)) ]

temp$Date <- as.POSIXct(strptime( paste( temp$year, temp$month, "1"), "%Y %m %d" ))


plot(temp$Date, temp$Mean,   "l")
plot(temp$Date, temp$Max,    "l")
plot(temp$Date, temp$Min,    "l")
plot(temp$Date, temp$Median, "l")


gather$file    <- NULL
gather$TIME_UT <- NULL
names(gather)[names(gather) == "[W.m-2]"] <- "wattGLB"


perc    <- 0.99999
uplim   <- quantile(gather$wattGLB, na.rm = T, probs = perc)
datespp <- gather[wattGLB > uplim, unique(as.Date(Date)) ]
length(datespp)

cat("There are", length(datespp),
    "days with more than", uplim,
    "watts, representing", perc * 100, "% of data\n")


for (ad in datespp ) {
    pp <- gather[ as.Date(Date) == ad ]

    plot(pp$Date, pp$wattGLB, "l", col = "green")
    points(pp$Date, pp$st.dev, col = "blue", pch=19, cex=.2)

    title(as.Date(ad, origin = "1970-01-01"))
}


pp <- gather[ as.Date(Date) %in% datespp ]

plot(pp$Date, pp$wattGLB, "l", col = "green")
points(pp$Date, pp$st.dev, col = "blue", pch=19, cex=.2)






myRtools::writeDATA(gather,
                    "~/DATA/cm21_data_validation/export_all_total.dat",
                    contact = "natsisthanasis@gmail.com",
                    type = "dat")

tac = Sys.time()
cat(sprintf("%s %s@%s %s %f mins\n\n",Sys.time(),Sys.info()["login"],Sys.info()["nodename"],Script.Name,difftime(tac,tic,units="mins")))
