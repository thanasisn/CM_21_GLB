
Data processing of CM-21 data to produce Total Irradiance data.
================================================================

Convert from CM-21 instrument signal data to Global Irradiance.
The output files will replace the automatically created files in sirena.
This product has to be considered as "level 0". No quality assurance is applied in this stage.

A lot of the processes here are created similar to those for Direct irradiance.



This is used to:
- Produce the Global irradiance files for sirena repository.
- Create aggregated data for submission to WRDC.
- Create plots and reports from the available data.


TO RUN:
- Do a manual data inspection of the raw data and define data exclusions if needed.
- Run `~/Aerosols/BASH_help/update_data_from_sirena.sh` first to get the data from sirena.
- Change date ranges in `DEFINITIONS.R`
- Run the main script that hopefully will do all the work.


Check diff between old and new radiation data
Copy to sirena