
Data processing of CM-21 data to produce Total Irradiance data.
================================================================

## Developed for in Laboratory of Atmosperic Pysics, for use in Thessaloniki, Greece.


- Convert CM-21 instrument signal data to Global Irradiance.
- Apply dark correction.
- Clean data.


This is used to:
- Produce the Global irradiance files for sirena repository.
- Create aggregated data for submission to WRDC.
- Create plots and reports from the available data.


TO RUN:
- First do a manual data inspection of the raw data and define data exclusions if needed.
- Run `~/Aerosols/BASH_help/update_data_from_sirena.sh` first to get the data from sirena.
- Change date ranges in `DEFINITIONS.R`
- Run the main script that hopefully it will do all the work.
- Check diffs between old and new radiation data before overwrite
