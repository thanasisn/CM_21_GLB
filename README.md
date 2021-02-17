
Data processing of CM-21 data to produce Total Irradiance data.
================================================================================

A lot of the processes here are created similar to those for Direct irradiance.

The output files will replace the automatically created files in sirena.


This is used to:
- Produce the Global irradiance files for sirena repository.
- Create aggregated data for submission to WRDC.
- Create plots and reports from the available data.


TO RUN:
- Do a manual data inspection of the raw data and define data exclusions if needed.
- Run `~/Aerosols/BASH_help/update_data_from_sirena.sh` first to get the data from sirena.
- Change date ranges in `DEFINITIONS.R`
- Run the main script that hopefully will do all the work.
