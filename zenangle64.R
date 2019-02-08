
## Sirena files
base_dir = "/home/athan/DATA/cm21_data_validation/AC21_lap.GLB_TOT/"


YYYY = 2018
doy  = 200
la   = 40.634
lo   = -22.956

## load sirena sza
file <- paste0(base_dir, YYYY, "/TOT", sprintf("%03d", doy), substr( as.character(YYYY), 3, 4 ),".dat")
SIR <- data.table::fread( file )[,1:2]
# SIR <- data.table::fread( paste0(base_dir, YYYY, "/TOT", sprintf("%03d", doy), substr( as.character(YYYY), 3, 4 ),".DAT") )[,1:2]


time <- 60*SIR$TIME_UT
# ./zenangle64 2019 1 1.5 40.634 -22.956

## calculate sza 0.99:1440
gather <- c()
for (min in time) {
    gather <- c(gather, round(as.numeric(system(paste("./BINARY/zenangle64 ", YYYY ,min, doy, " 40.634 -22.956" ), intern = T)) , 2) )
     }
dd <- data.frame(gather)

SIR$sss <- gather

SIR[ , dif:=SZA-sss ]

hist(SIR$dif,breaks = 40)

which(SIR$dif!=0)
SIR$SZA[ SIR$dif!=0 ]

SIR[which.min(SIR$dif)]

summary(SIR)

plot(SIR$dif)

plot(SIR$SZA, type = "l", col="blue")
points(which(SIR$dif>0),SIR$SZA[ SIR$dif>0 ], col = "red", pch = 2    )
points(which(SIR$dif<0),SIR$SZA[ SIR$dif<0 ], col = "magenta", pch = 3 )
lines(SIR$sss, col = "green")
title(main =  basename(file) )
legend("top", c("Sirena","My Sirena","Sirena > My Sirena","My Sirena > Sirena"),
       lty = c(1,1,NA,NA), pch = c(NA,NA,2,3) , col = c("blue", "green", "red", "magenta"),
       bty = "n")


plot(SIR$SZA, type = "l", col="blue", ylim = c(80,100), xlim = c(200,1200))
lines(SIR$sss, col = "green")


tail(0.5:1440)


zenangle <- function(YYYY,min,doy){
    as.numeric(system(paste("./BINARY/zenangle64 ", YYYY ,min, doy, " 40.634 -22.956" ), intern = T))
}



zenangle(2019,1:1440,10)
vzen <- Vectorize(zenangle, "min")
vzen(2019,1:1440,10)
