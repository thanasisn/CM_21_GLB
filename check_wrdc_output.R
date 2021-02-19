

file = "~/DATA/cm21_data_validation/CM21_exports/sumbit_to_WRDC_2018.dat"

library(data.table)

data <- fread(file)

plot(data$global)
