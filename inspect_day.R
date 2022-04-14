#!/usr/bin/env Rscript
# /* Copyright (C) 2022 Athanasios Natsis <natsisthanasis@gmail.com> */

rm(list = (ls()[ls() != ""]))
Sys.setenv(TZ = "UTC")
tic <- Sys.time()


library(data.table, quietly = T, warn.conflicts = F)
library(optparse)


option_list <-  list(
    make_option(c("-d", "--day"),
                type    = "character",
                default = paste0(year(Sys.Date()), "-01-01"),
                help    = "Start day of ploting yyyy-mm-dd",
                metavar = "yyyy-mm-dd"),
    make_option(c("-s", "--step"),
                type    = "integer",
                default = 3,
                help    = "Step width in days",
                metavar = "integer")
)
opt_parser <- OptionParser(option_list = option_list)
args       <- parse_args(opt_parser)


STARTDAY <- args$day
STARTDAY <- as.Date(STARTDAY)
STEP     <- args$step





cat("Start day:", paste(STARTDAY),"\n")
cat("Step     :", STEP, "\n")

