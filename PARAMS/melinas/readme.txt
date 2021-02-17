
*** The files in directory SPECTRAL are named as follows:

    nncjjjyy.dat

where nn the instrument number (e.g. 03 for 04103), c for channel number (1-6).
jjj is the julian day and yy the year (e.g. 04 for 2004) of the calibration.
 
The files are structured :

  column 1                column 2
wavelength (nm)       spectral response normalized in maximun


*** The files in directory COSINE are named as follows :

    nnijjjyy.dat

where nn the instrument number (e.g. 03 for 04103),i (1-2) for the 2 azimuth positions
jjj is the julian day and yy the year (e.g. 04 for 2004) of the calibration.

The files are structured :

col.1           col.2                 col.3       col.4       col.5       col.6       col.7
 
zenith angle    cosine response (cr)  cr for      cr for      cr for      cr for      cr for 
(-90 to 90)     for channel 1         channel 2   channel 3   channel 4   channel 5   channel 6

All cosine responses are normalized to their maximum