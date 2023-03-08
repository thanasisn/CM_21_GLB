#!/bin/bash
## created on 2022-12-19

#### Create a master md file with h1 header from folders names

## this sould be sorted
args=( "$@" )

targetfile=".markdowncontent"
echo "" > "$targetfile"

## get all the years from files
years=($(for af in "${args[@]}"; do echo "$(basename "$(dirname "$af")")"; done | sort -u))

## loop years
for ay in "${years[@]}"; do
    echo
    echo "** $ay **"
    ( 
    echo
    echo "# $ay"
    echo
    ) >> "$targetfile"
    
    ## loop all files of year
    for af in "${args[@]}"; do
        infile="$(echo "$af" | grep "/$ay/")"
        ## append the appropriate files only
        if [[ -n "$infile" ]]; then
            echo " - $infile"
            cat "$infile" >> "$targetfile" 
            echo ""       >> "$targetfile" 
        fi
    done
done 

exit 0 
