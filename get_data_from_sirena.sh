#!/bin/bash

#### Get data from sirena

## this sould be mounted
SOURCE="/media/sirena_lapdata_ro"


if mountpoint -q "$SOURCE" ; then

    echo "get signal files 'LAP' of CM21"
    rsync -rhvt                                    \
        --include '*/'                             \
        --include '*.LAP'                          \
        --include '*.lap'                          \
        --include '*.ori'                          \
        --exclude '*'                              \
        "$SOURCE/archive/Bband/AC21_LAP.GLB/"      \
        "$HOME/DATA_RAW/Bband/AC21_LAP.GLB"


    echo "get chp1 signal files"
    rsync -rhvt                                    \
        "$SOURCE/archive/Bband/CHP1_lap.DIR/"      \
        "$HOME/DATA_RAW/Bband/CHP1_lap.DIR"


    echo "get total radiation files 'TOT.DAT'"
    rsync -rhvt                                    \
        --delete                                   \
        "$SOURCE/products/Bband/AC21_lap.GLB/"     \
        "$HOME/DATA/cm21_data_validation/AC21_lap.GLB_TOT"


    echo "get other relative files"
    rsync -rhvt                                    \
        --include '*/'                             \
        --include '*.txt'                          \
        --include '*.bas'                          \
        --include '*.BAS'                          \
        --include '*.doc'                          \
        --include '*.docx'                         \
        --include '*.dat'                          \
        --include '*.xls'                          \
        --include '*.xlsx'                         \
        --exclude '*'                              \
        --prune-empty-dirs                         \
        "$SOURCE/process/"                         \
        "$HOME/DATA/process_sirena/"
else
    echo ""
    echo "No DATA mount point found!!"
    echo "...exit..."
fi

exit 0
