#!/bin/bash
## created on 2022-03-29

#### This is for daily usage.
## For building reports there is an R scirpt


info() { echo ; echo "$(date +%F_%T) :: $* " >&1; }
mkdir -p "$(dirname "$0")/LOGs/"
LOG_FILE="$(dirname "$0")/LOGs/$(basename "$0")_$(date +%F_%T).log"
ERR_FILE="$(dirname "$0")/LOGs/$(basename "$0")_$(date +%F_%T).err"
exec  > >(tee -i "${LOG_FILE}")
exec 2> >(tee -i "${ERR_FILE}" >&2)
info "START :: $0 :: $* ::"



info "Try to get new files"
"$HOME/Aerosols/BASH_help/update_data_from_sirena.sh"

info "Read raw files to SIG"
Rscript "$(dirname "$0")/CM21_R10_Read_raw_LAP.R"

info "Filter raw data to S0"
Rscript "$(dirname "$0")/CM21_R20_Parse_Data.R"

info "Compute dark to S1"
Rscript "$(dirname "$0")/CM21_R30_Compute_dark.R"

info "Construct missing dark for S1"
Rscript "$(dirname "$0")/CM21_R40_Missing_dark_construct.R"

info "Convert S1 to L0 GHI"
Rscript "$(dirname "$0")/CM21_R50_Signal_to_GHI.R"

info "Clean output L0 to L1 GHI"
Rscript "$(dirname "$0")/CM21_R60_GHI_output.R"







## rclone options
bwlim=${1:-110}  # if not set to 110
rclone="$HOME/PROGRAMS/rclone"
config="$HOME/Documents/rclone.conf"
otheropt=" --checkers=20 --delete-before --stats=300s"
bwlimit="--bwlimit=${bwlim}k"



info "Upload  CM21_Reports"
"${rclone}" ${otheropt} "${bwlimit}" --config "$config" copy "$HOME/CM_21_GLB/REPORTS/REPORTS" lapauththanasis:/Aerosols/CM21_Reports

info "Upload  CM21_Daily"
"${rclone}" ${otheropt} "${bwlimit}" --config "$config" copy "$HOME/CM_21_GLB/REPORTS/DAILY"   lapauththanasis:/Aerosols/CM21_Daily




## end coding
printf "%s %-10s %-10s %-50s %f\n" "$(date +"%F %H:%M:%S")" "$HOSTNAME" "$USER" "$(basename $0)" "$SECONDS"
exit 0
