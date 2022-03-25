
---
title:         "Read global radiation data from sirena"
author:        "Natsis Athanasios"
date:          "March 25, 2022"
keywords:      "CM21, CM21 data validation, global irradiance"
documentclass: article
classoption:   a4paper,oneside
fontsize:      11pt
geometry:      "left=0.5in,right=0.5in,top=0.5in,bottom=0.5in"

header-includes:
- \usepackage{caption}
- \usepackage{placeins}
- \captionsetup{font=small}

output:
  html_document:
    keep_md:          yes
  bookdown::pdf_document2:
    number_sections:  no
    fig_caption:      no
    keep_tex:         no
    latex_engine:     xelatex
    toc:              yes
  odt_document:  default
  word_document: default

---





## Files read by year



```
    year   N
 1: 1993 339
 2: 1994 360
 3: 1995 357
 4: 1996 361
 5: 1997 357
 6: 1998 351
 7: 1999 364
 8: 2000 358
 9: 2001 351
10: 2002 360
11: 2003 361
12: 2004 361
13: 2005 340
14: 2006 338
15: 2007 321
16: 2008 359
17: 2009 348
18: 2010 287
19: 2011 334
20: 2012 336
21: 2013 352
22: 2014 350
23: 2015 334
24: 2016 362
25: 2017 363
26: 2018 356
27: 2019 343
28: 2020 343
29: 2021 363
30: 2022  59
    year   N
```


## Data points by hour



```r
table(DT$TIME_UT %/% 1)
```

```

     0      1      2      3      4      5      6      7      8      9     10 
599912 610080 610080 610080 610080 610080 610080 610080 610080 610080 610080 
    11     12     13     14     15     16     17     18     19     20     21 
610080 610080 610080 610080 610080 610080 610080 610080 610080 610080 610080 
    22     23     24 
610080 610080  10168 
```

```r
hist( DT$TIME_UT %/% 1, breaks = 25)
```

<img src="check_export_sirena_files/figure-html/unnamed-chunk-4-1.png" width="70%" style="display: block; margin: auto;" />


## Data points by minute

<img src="check_export_sirena_files/figure-html/unnamed-chunk-5-1.png" width="70%" style="display: block; margin: auto;" />



## Drop some data




## Inspect all data


```
    TIME_UT             SZA            [W.m-2]             st.dev       
 Min.   : 0.0167   Min.   : 17.19   Min.   :   0.000   Min.   : -9.000  
 1st Qu.: 6.0167   1st Qu.: 61.50   1st Qu.:   0.000   1st Qu.:  0.070  
 Median :12.0000   Median : 89.08   Median :   5.138   Median :  0.773  
 Mean   :11.9930   Mean   : 89.37   Mean   : 183.160   Mean   :  4.299  
 3rd Qu.:17.9667   3rd Qu.:117.30   3rd Qu.: 301.249   3rd Qu.:  3.450  
 Max.   :24.0000   Max.   :162.81   Max.   :1416.586   Max.   :879.417  
      Date                           file          
 Min.   :1993-01-19 00:02:00.0   Length:14277441   
 1st Qu.:2000-03-23 12:37:00.0   Class :character  
 Median :2007-08-08 09:59:00.0   Mode  :character  
 Mean   :2007-08-14 12:29:58.5                     
 3rd Qu.:2015-01-25 18:10:00.0                     
 Max.   :2022-02-28 09:18:00.0                     
```

<img src="check_export_sirena_files/figure-html/unnamed-chunk-10-1.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-10-2.png" width="70%" style="display: block; margin: auto;" />

## Monthly values

<img src="check_export_sirena_files/figure-html/unnamed-chunk-11-1.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-11-2.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-11-3.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-11-4.png" width="70%" style="display: block; margin: auto;" />


## Too high values

There are 56 days with more than 1260.327 watts, representing 0.001 % of the data.



<img src="check_export_sirena_files/figure-html/unnamed-chunk-14-1.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-2.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-3.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-4.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-5.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-6.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-7.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-8.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-9.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-10.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-11.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-12.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-13.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-14.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-15.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-16.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-17.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-18.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-19.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-20.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-21.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-22.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-23.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-24.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-25.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-26.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-27.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-28.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-29.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-30.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-31.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-32.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-33.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-34.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-35.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-36.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-37.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-38.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-39.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-40.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-41.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-42.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-43.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-44.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-45.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-46.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-47.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-48.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-49.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-50.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-51.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-52.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-53.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-54.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-55.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-56.png" width="70%" style="display: block; margin: auto;" /><img src="check_export_sirena_files/figure-html/unnamed-chunk-14-57.png" width="70%" style="display: block; margin: auto;" />

```
2022-03-25 12:29:11.3 athan@tyler Undefined R script name!! 85.651447 mins
```

