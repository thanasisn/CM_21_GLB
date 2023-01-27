---
title:         "??"
author:        "Natsis Athanasios"
institute:     "AUTH"
affiliation:   "Laboratory of Atmospheric Physics"
abstract:      " todo  "
documentclass: article
classoption:   a4paper,oneside
fontsize:      10pt
geometry:      "left=0.5in,right=0.5in,top=0.5in,bottom=0.5in"

link-citations:  yes
colorlinks:      yes

header-includes:
- \usepackage{caption}
- \usepackage{placeins}
- \captionsetup{font=small}

output:
  bookdown::html_document2:
    keep_md:          yes
    out_width:        100%
    toc:              yes
    number_sections:  no
  bookdown::pdf_document2:
    fig_caption:      no
    keep_tex:         no
    latex_engine:     xelatex
    number_sections:  no
    toc:              yes
  odt_document:  default
  word_document: default
---







## By year



| year | Files | Datapoints | Missing | MissPerC |
|-----:|------:|-----------:|--------:|---------:|
| 1993 |   339 |     488160 |   30911 |      6.3 |
| 1994 |   360 |     518400 |   27857 |      5.4 |
| 1995 |   357 |     514080 |   25042 |      4.9 |
| 1996 |   361 |     519840 |   11776 |      2.3 |
| 1997 |   357 |     514080 |   11058 |      2.2 |
| 1998 |   351 |     505440 |    9420 |      1.9 |
| 1999 |   364 |     524160 |    7642 |      1.5 |
| 2000 |   358 |     515520 |   11071 |      2.1 |
| 2001 |   351 |     505440 |   24823 |      4.9 |
| 2002 |   360 |     518400 |   15321 |        3 |
| 2003 |   361 |     519840 |   16027 |      3.1 |
| 2004 |   361 |     519840 |   16876 |      3.2 |
| 2005 |   340 |     489600 |   18536 |      3.8 |
| 2006 |   338 |     486720 |   19680 |        4 |
| 2007 |   321 |     462240 |   15038 |      3.3 |
| 2008 |   359 |     516960 |    5161 |        1 |
| 2009 |   348 |     501120 |   22369 |      4.5 |
| 2010 |   287 |     413280 |   26496 |      6.4 |
| 2011 |   334 |     480960 |    6841 |      1.4 |
| 2012 |   336 |     483840 |    3623 |      0.7 |
| 2013 |   352 |     506880 |    4569 |      0.9 |
| 2014 |   350 |     504000 |    4317 |      0.9 |
| 2015 |   334 |     480960 |    5836 |      1.2 |
| 2016 |   362 |     521280 |    2072 |      0.4 |
| 2017 |   363 |     522720 |    4529 |      0.9 |
| 2018 |   356 |     512640 |    2032 |      0.4 |
| 2019 |   343 |     493920 |    3202 |      0.6 |
| 2020 |   349 |     502560 |    8958 |      1.8 |
| 2021 |   365 |     525600 |    8989 |      1.7 |
| 2022 |   271 |     390240 |    4396 |      1.1 |
| 2023 |    24 |      34560 |      81 |      0.2 |


Unique files: 10412

Unique days:  10412


<img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-6-2.png" width="100%" style="display: block; margin: auto;" />


## Data points by hour



```r
pander(
    table(  DT$TIME_UT %/% 1 )
)
```



|      0 |      1 |      2 |      3 |      4 |      5 |      6 |      7 |      8 |      9 |     10 |     11 |
|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
| 614308 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 |

 

|     12 |     13 |     14 |     15 |     16 |     17 |     18 |     19 |     20 |     21 |     22 |     23 |    24 |
|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|------:|
| 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 624720 | 10412 |





## Data points by minute


<img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-9-1.png" width="100%" style="display: block; margin: auto;" />


Do all files has 1440 records: TRUE


|  1440 |
|------:|
| 10412 |

## Drop some data


```r
DT <- DT[ !is.na(`[W.m-2]`), ]
DT <- DT[ `[W.m-2]` > -5   , ]
```





## Inspect all data


|         TIME_UT |            SZA |          [W.m-2] |         st.dev |                          Date |
|----------------:|---------------:|-----------------:|---------------:|------------------------------:|
| Min.   : 0.0167 | Min.   : 17.19 | Min.   :   0.000 | Min.   :  0.00 | Min.   :1993-01-19 00:02:00.0 |
| 1st Qu.: 6.0167 | 1st Qu.: 61.59 | 1st Qu.:   0.000 | 1st Qu.:  0.07 | 1st Qu.:2000-05-22 02:12:30.0 |
| Median :12.0000 | Median : 89.10 | Median :   5.073 | Median :  0.81 | Median :2007-12-10 05:20:00.0 |
| Mean   :11.9927 | Mean   : 89.41 | Mean   : 183.167 | Mean   :  4.44 | Mean   :2007-12-21 06:14:05.1 |
| 3rd Qu.:17.9667 | 3rd Qu.:117.30 | 3rd Qu.: 301.411 | 3rd Qu.:  3.63 | 3rd Qu.:2015-08-15 01:02:30.0 |
| Max.   :24.0000 | Max.   :162.81 | Max.   :2685.711 | Max.   :879.42 | Max.   :2023-01-25 00:00:00.0 |
|              NA |             NA |               NA | NA's   :166654 |                            NA |

 

|             file |
|-----------------:|
|  Length:14618731 |
| Class :character |
| Mode  :character |
|               NA |
|               NA |
|               NA |
|               NA |

<img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-14-1.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-14-2.png" width="100%" style="display: block; margin: auto;" />

## Monthly values

<img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-15-1.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-15-2.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-15-3.png" width="100%" style="display: block; margin: auto;" />


## Extreme values

There are 59 days with more than 1260.06769210003 watts, representing 0.000999999999995449 % of the data.



## Plot all extreme days


<img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-1.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-2.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-3.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-4.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-5.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-6.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-7.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-8.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-9.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-10.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-11.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-12.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-13.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-14.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-15.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-16.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-17.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-18.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-19.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-20.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-21.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-22.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-23.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-24.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-25.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-26.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-27.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-28.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-29.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-30.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-31.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-32.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-33.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-34.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-35.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-36.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-37.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-38.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-39.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-40.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-41.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-42.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-43.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-44.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-45.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-46.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-47.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-48.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-49.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-50.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-51.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-52.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-53.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-54.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-55.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-56.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-57.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-58.png" width="100%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-18-59.png" width="100%" style="display: block; margin: auto;" />



## Plot all extreme days in time series


<img src="/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_T80_check_sirena_export_files/figure-html/unnamed-chunk-19-1.png" width="100%" style="display: block; margin: auto;" />

**END**


```
2023-01-27 21:24:45.4 athan@sagan /home/athan/CM_21_GLB/CM21_000_render_all.R 8.866698 mins
```



---
date: '2023-01-27'

---
