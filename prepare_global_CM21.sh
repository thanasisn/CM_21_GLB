#!/bin/bash
## created on 2022-03-29

#### This is for daily usage.
## For building reports there is another scirpt


info() { echo ; echo "$(date +%F_%T) :: $* " >&1; }
mkdir -p "$(dirname "$0")/LOGs/"
LOG_FILE="$(dirname "$0")/LOGs/$(basename "$0")_$(date +%F_%T).log"
ERR_FILE="$(dirname "$0")/LOGs/$(basename "$0")_$(date +%F_%T).err"
exec  > >(tee -i "${LOG_FILE}")
exec 2> >(tee -i "${ERR_FILE}" >&2)
info "START :: $0 :: $* ::"



info "Try to get new files"
"$HOME/Aerosols/BASH_help/update_data_from_sirena.sh"

info "Read raw files to Rds"

Rscript "$(dirname "$0")/CM21_P10_Read_LAP.R"


## end coding
printf "%s %-10s %-10s %-50s %f\n" "$(date +"%F %H:%M:%S")" "$HOSTNAME" "$USER" "$(basename $0)" "$SECONDS"
exit 0
