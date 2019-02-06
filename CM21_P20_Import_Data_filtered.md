
---
title: "CM21 signal filtering."
author: "Natsis Athanasios"
date: "February 03, 2019"
keywords: "CM21, CM21 data validation, global irradiance"
documentclass: article
classoption:   a4paper,oneside
fontsize:      11pt
geometry:      "left=0.5in,right=0.5in,top=0.5in,bottom=0.5in"

header-includes:
- \usepackage{caption}
- \usepackage{placeins}
- \captionsetup{font=small}

output:
  bookdown::pdf_document2:
    number_sections:  no
    fig_caption:      no
    keep_tex:         no
    latex_engine:     xelatex
    toc:              yes
  html_document:
    keep_md:          yes
  odt_document:  default
  word_document: default

params:
  CACHE: true
---









## Info

Apply filtering from measurements log files and
signal limitations.

### Too bad days.

Exclude days from file 'Too_bad_dates.dat'.
These were determined with manual inspection and logging.

### Bad day ranges.

Exclude date ranges from file 'Skip_ranges_CM21.txt'.
These were determined with manual inspection and logging.

### Filter of possible signal values.

Only signal of range [-0.06, 0.5] Volts is possible to be recorded normaly.

### Filter of possible night signal.

During night (sun elevation < -10) we allow a signal range of [-0.02, 0.1] to remove various inconsistencies.

### Filter negative signal when sun is up.

When sun elevation > 5 ignore CM-21 signal < 0.



\newpage

##  2006 

\scriptsize

--------------------------------------
                    Name   Data_points
------------------------ -------------
            Initial data        472282

            Too bad days          4060

         Bad date ranges             0

  Signal physical limits            24

     Signal night limits             0

        Negative daytime           940

          Remaining data        467258
--------------------------------------


--------------------------------------------------------------------------
        CM21value           CM21sd             Elevat                  day
----------------- ---------------- ------------------ --------------------
   Min.  :-0.0071    Min.  :0.0000    Min.  :-72.8133    Min.  :2006-01-01

  1st Qu.:-0.0024   1st Qu.:0.0000   1st Qu.:-27.2109   1st Qu.:2006-03-28

  Median :-0.0001   Median :0.0000    Median : 1.1509   Median :2006-06-28

    Mean : 0.0533     Mean :0.0009      Mean : 0.9378     Mean :2006-06-25

  3rd Qu.: 0.0906   3rd Qu.:0.0003   3rd Qu.: 28.9159   3rd Qu.:2006-09-20

   Max.  : 0.3817    Max.  :0.1219    Max.  : 72.8115    Max.  :2006-12-27

        NA's :940        NA's :940                 NA                   NA
--------------------------------------------------------------------------

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-2.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-3.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-4.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2007 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      466403 |
|           Too bad days |       18495 |
|        Bad date ranges |           0 |
| Signal physical limits |          31 |
|    Signal night limits |           0 |
|       Negative daytime |         650 |
|         Remaining data |      447227 |



|       CM21value |         CM21sd |          Elevat |                day |
|----------------:|---------------:|----------------:|-------------------:|
| Min.   :-0.0077 | Min.   :0.0000 | Min.   :-72.812 | Min.   :2007-01-27 |
| 1st Qu.:-0.0023 | 1st Qu.:0.0000 | 1st Qu.:-26.497 | 1st Qu.:2007-04-30 |
| Median : 0.0001 | Median :0.0001 | Median :  1.734 | Median :2007-07-24 |
| Mean   : 0.0559 | Mean   :0.0007 | Mean   :  1.777 | Mean   :2007-07-21 |
| 3rd Qu.: 0.0973 | 3rd Qu.:0.0003 | 3rd Qu.: 30.005 | 3rd Qu.:2007-10-12 |
| Max.   : 0.4221 | Max.   :0.1080 | Max.   : 72.811 | Max.   :2007-12-31 |
|     NA's   :650 |    NA's   :650 |              NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-5.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-6.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-7.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-8.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2008 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      512946 |
|           Too bad days |           0 |
|        Bad date ranges |           0 |
| Signal physical limits |           0 |
|    Signal night limits |           0 |
|       Negative daytime |        1107 |
|         Remaining data |      511839 |



|       CM21value |         CM21sd |           Elevat |                day |
|----------------:|---------------:|-----------------:|-------------------:|
| Min.   :-0.0071 | Min.   :0.0000 | Min.   :-72.8116 | Min.   :2008-01-01 |
| 1st Qu.:-0.0025 | 1st Qu.:0.0000 | 1st Qu.:-27.5444 | 1st Qu.:2008-04-05 |
| Median :-0.0009 | Median :0.0001 | Median :  0.6203 | Median :2008-07-03 |
| Mean   : 0.0529 | Mean   :0.0007 | Mean   :  0.2686 | Mean   :2008-07-02 |
| 3rd Qu.: 0.0889 | 3rd Qu.:0.0003 | 3rd Qu.: 28.0110 | 3rd Qu.:2008-10-03 |
| Max.   : 0.3939 | Max.   :0.1188 | Max.   : 72.8099 | Max.   :2008-12-31 |
|    NA's   :1107 |   NA's   :1107 |               NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-9.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-10.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-11.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-12.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2009 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      480352 |
|           Too bad days |         120 |
|        Bad date ranges |           0 |
| Signal physical limits |           3 |
|    Signal night limits |           0 |
|       Negative daytime |        1223 |
|         Remaining data |      479006 |



|       CM21value |         CM21sd |            Elevat |                day |
|----------------:|---------------:|------------------:|-------------------:|
| Min.   :-0.0085 | Min.   :0.0000 | Min.   :-72.81105 | Min.   :2009-01-01 |
| 1st Qu.:-0.0026 | 1st Qu.:0.0000 | 1st Qu.:-28.62202 | 1st Qu.:2009-03-26 |
| Median :-0.0020 | Median :0.0001 | Median :  0.08025 | Median :2009-06-17 |
| Mean   : 0.0498 | Mean   :0.0009 | Mean   : -0.53803 | Mean   :2009-06-29 |
| 3rd Qu.: 0.0805 | 3rd Qu.:0.0003 | 3rd Qu.: 27.40757 | 3rd Qu.:2009-10-06 |
| Max.   : 0.3858 | Max.   :0.1169 | Max.   : 72.77484 | Max.   :2009-12-31 |
|    NA's   :1223 |   NA's   :1223 |                NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-13.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-14.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-15.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-16.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2010 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      422269 |
|           Too bad days |       34298 |
|        Bad date ranges |           0 |
| Signal physical limits |          29 |
|    Signal night limits |           0 |
|       Negative daytime |        1121 |
|         Remaining data |      386821 |



|       CM21value |         CM21sd |           Elevat |                day |
|----------------:|---------------:|-----------------:|-------------------:|
| Min.   :-0.0073 | Min.   :0.0000 | Min.   :-133.654 | Min.   :2010-01-01 |
| 1st Qu.:-0.0026 | 1st Qu.:0.0000 | 1st Qu.: -26.779 | 1st Qu.:2010-03-28 |
| Median :-0.0004 | Median :0.0001 | Median :   1.462 | Median :2010-06-12 |
| Mean   : 0.0521 | Mean   :0.0011 | Mean   :   1.314 | Mean   :2010-06-20 |
| 3rd Qu.: 0.0856 | 3rd Qu.:0.0003 | 3rd Qu.:  29.644 | 3rd Qu.:2010-09-21 |
| Max.   : 0.4014 | Max.   :0.1270 | Max.   :  72.809 | Max.   :2010-12-02 |
|    NA's   :1121 |   NA's   :1121 |               NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-17.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-18.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-19.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-20.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2011 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      476482 |
|           Too bad days |        1693 |
|        Bad date ranges |          14 |
| Signal physical limits |          54 |
|    Signal night limits |           0 |
|       Negative daytime |         584 |
|         Remaining data |      474137 |



|       CM21value |         CM21sd |          Elevat |                day |
|----------------:|---------------:|----------------:|-------------------:|
| Min.   :-0.0048 | Min.   :0.0000 | Min.   :-72.156 | Min.   :2011-01-03 |
| 1st Qu.:-0.0024 | 1st Qu.:0.0000 | 1st Qu.:-26.341 | 1st Qu.:2011-03-28 |
| Median : 0.0002 | Median :0.0001 | Median :  1.994 | Median :2011-06-19 |
| Mean   : 0.0555 | Mean   :0.0009 | Mean   :  2.059 | Mean   :2011-06-19 |
| 3rd Qu.: 0.0945 | 3rd Qu.:0.0003 | 3rd Qu.: 30.370 | 3rd Qu.:2011-09-11 |
| Max.   : 0.3920 | Max.   :0.5609 | Max.   : 72.808 | Max.   :2011-12-05 |
|     NA's   :584 |    NA's   :584 |              NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-21.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-22.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-23.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-24.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2012 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      481572 |
|           Too bad days |           0 |
|        Bad date ranges |           0 |
| Signal physical limits |           3 |
|    Signal night limits |           0 |
|       Negative daytime |        1281 |
|         Remaining data |      480288 |



|       CM21value |         CM21sd |          Elevat |                day |
|----------------:|---------------:|----------------:|-------------------:|
| Min.   :-0.0086 | Min.   :0.0000 | Min.   :-72.807 | Min.   :2012-01-31 |
| 1st Qu.:-0.0028 | 1st Qu.:0.0001 | 1st Qu.:-26.549 | 1st Qu.:2012-04-24 |
| Median :-0.0006 | Median :0.0001 | Median :  1.666 | Median :2012-07-16 |
| Mean   : 0.0560 | Mean   :0.0008 | Mean   :  1.725 | Mean   :2012-07-16 |
| 3rd Qu.: 0.0976 | 3rd Qu.:0.0003 | 3rd Qu.: 30.072 | 3rd Qu.:2012-10-09 |
| Max.   : 0.3897 | Max.   :0.1130 | Max.   : 72.806 | Max.   :2012-12-31 |
|    NA's   :1281 |   NA's   :1281 |              NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-25.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-26.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-27.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-28.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2013 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      507026 |
|           Too bad days |        3280 |
|        Bad date ranges |           0 |
| Signal physical limits |          10 |
|    Signal night limits |           0 |
|       Negative daytime |        1318 |
|         Remaining data |      502418 |



|       CM21value |         CM21sd |           Elevat |                day |
|----------------:|---------------:|-----------------:|-------------------:|
| Min.   :-0.0059 | Min.   :0.0000 | Min.   :-72.8077 | Min.   :2013-01-01 |
| 1st Qu.:-0.0029 | 1st Qu.:0.0001 | 1st Qu.:-27.2698 | 1st Qu.:2013-04-02 |
| Median :-0.0014 | Median :0.0001 | Median :  0.8899 | Median :2013-06-28 |
| Mean   : 0.0536 | Mean   :0.0010 | Mean   :  0.6560 | Mean   :2013-06-29 |
| 3rd Qu.: 0.0892 | 3rd Qu.:0.0003 | 3rd Qu.: 28.5591 | 3rd Qu.:2013-09-25 |
| Max.   : 0.3873 | Max.   :0.1256 | Max.   : 72.8060 | Max.   :2013-12-29 |
|    NA's   :1318 |   NA's   :1318 |               NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-29.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-30.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-31.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-32.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2014 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      500081 |
|           Too bad days |           0 |
|        Bad date ranges |           0 |
| Signal physical limits |           1 |
|    Signal night limits |           1 |
|       Negative daytime |         259 |
|         Remaining data |      499820 |



|        CM21value |          CM21sd |           Elevat |                day |
|-----------------:|----------------:|-----------------:|-------------------:|
| Min.   :-0.00476 | Min.   :0.00000 | Min.   :-72.8071 | Min.   :2014-01-01 |
| 1st Qu.:-0.00022 | 1st Qu.:0.00104 | 1st Qu.:-27.4696 | 1st Qu.:2014-04-10 |
| Median : 0.00106 | Median :0.00152 | Median :  0.6429 | Median :2014-07-06 |
| Mean   : 0.05279 | Mean   :0.00221 | Mean   :  0.3322 | Mean   :2014-07-05 |
| 3rd Qu.: 0.08191 | 3rd Qu.:0.00216 | 3rd Qu.: 28.0248 | 3rd Qu.:2014-10-06 |
| Max.   : 0.41170 | Max.   :0.12773 | Max.   : 72.8056 | Max.   :2014-12-31 |
|      NA's   :260 |     NA's   :260 |               NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-33.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-34.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-35.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-36.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2015 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      493554 |
|           Too bad days |       14400 |
|        Bad date ranges |        3654 |
| Signal physical limits |          16 |
|    Signal night limits |           0 |
|       Negative daytime |          44 |
|         Remaining data |      475440 |



|        CM21value |          CM21sd |            Elevat |                day |
|-----------------:|----------------:|------------------:|-------------------:|
| Min.   :-0.00349 | Min.   :0.00000 | Min.   :-124.0415 | Min.   :2015-01-01 |
| 1st Qu.:-0.00023 | 1st Qu.:0.00088 | 1st Qu.: -28.5096 | 1st Qu.:2015-03-27 |
| Median : 0.00105 | Median :0.00127 | Median :   0.2490 | Median :2015-07-09 |
| Mean   : 0.05337 | Mean   :0.00193 | Mean   :  -0.1966 | Mean   :2015-06-30 |
| 3rd Qu.: 0.08740 | 3rd Qu.:0.00166 | 3rd Qu.:  27.9424 | 3rd Qu.:2015-09-30 |
| Max.   : 0.40197 | Max.   :0.11577 | Max.   :  72.8050 | Max.   :2015-12-21 |
|       NA's   :44 |      NA's   :44 |                NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-37.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-38.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-39.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-40.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2016 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      520871 |
|           Too bad days |        1288 |
|        Bad date ranges |         298 |
| Signal physical limits |           0 |
|    Signal night limits |           0 |
|       Negative daytime |          56 |
|         Remaining data |      519229 |



|        CM21value |          CM21sd |           Elevat |                day |
|-----------------:|----------------:|-----------------:|-------------------:|
| Min.   :-0.00380 | Min.   :0.00018 | Min.   :-72.8060 | Min.   :2016-01-01 |
| 1st Qu.:-0.00008 | 1st Qu.:0.00063 | 1st Qu.:-27.5537 | 1st Qu.:2016-04-03 |
| Median : 0.00142 | Median :0.00080 | Median :  0.7221 | Median :2016-07-04 |
| Mean   : 0.05597 | Mean   :0.00163 | Mean   :  0.3826 | Mean   :2016-07-03 |
| 3rd Qu.: 0.09332 | 3rd Qu.:0.00106 | 3rd Qu.: 28.2168 | 3rd Qu.:2016-10-02 |
| Max.   : 0.38802 | Max.   :0.12229 | Max.   : 72.8043 | Max.   :2016-12-31 |
|       NA's   :56 |      NA's   :56 |               NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-41.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-42.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-43.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-44.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2017 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      519420 |
|           Too bad days |        2371 |
|        Bad date ranges |        1203 |
| Signal physical limits |           0 |
|    Signal night limits |           0 |
|       Negative daytime |           3 |
|         Remaining data |      515843 |



|          CM21value |            CM21sd |           Elevat |
|-------------------:|------------------:|-----------------:|
| Min.   :-0.0027390 | Min.   :0.0000000 | Min.   :-72.8070 |
| 1st Qu.:-0.0000496 | 1st Qu.:0.0006782 | 1st Qu.:-27.4602 |
| Median : 0.0014725 | Median :0.0007868 | Median :  0.7852 |
| Mean   : 0.0574517 | Mean   :0.0014853 | Mean   :  0.4488 |
| 3rd Qu.: 0.0985413 | 3rd Qu.:0.0009552 | 3rd Qu.: 28.2770 |
| Max.   : 0.3998566 | Max.   :0.1279875 | Max.   : 72.8045 |
|          NA's   :3 |         NA's   :3 |               NA |

 

|                day |
|-------------------:|
| Min.   :2017-01-01 |
| 1st Qu.:2017-04-01 |
| Median :2017-06-30 |
| Mean   :2017-07-01 |
| 3rd Qu.:2017-09-30 |
| Max.   :2017-12-31 |
|                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-45.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-46.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-47.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-48.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2018 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |      511022 |
|           Too bad days |           0 |
|        Bad date ranges |         835 |
| Signal physical limits |           0 |
|    Signal night limits |           0 |
|       Negative daytime |          19 |
|         Remaining data |      510168 |



|         CM21value |           CM21sd |           Elevat |                day |
|------------------:|-----------------:|-----------------:|-------------------:|
| Min.   :-0.003300 | Min.   :0.000000 | Min.   :-72.8079 | Min.   :2018-01-01 |
| 1st Qu.:-0.000031 | 1st Qu.:0.000864 | 1st Qu.:-27.0842 | 1st Qu.:2018-03-30 |
| Median : 0.001717 | Median :0.001307 | Median :  1.1890 | Median :2018-06-27 |
| Mean   : 0.054866 | Mean   :0.002055 | Mean   :  0.9258 | Mean   :2018-06-27 |
| 3rd Qu.: 0.089588 | 3rd Qu.:0.001784 | 3rd Qu.: 28.8795 | 3rd Qu.:2018-09-23 |
| Max.   : 0.404935 | Max.   :0.118403 | Max.   : 72.8055 | Max.   :2018-12-31 |
|        NA's   :19 |       NA's   :19 |               NA |                 NA |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-49.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-50.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-51.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-52.png" width="60%" style="display: block; margin: auto;" />

\newpage

##  2019 

\scriptsize


|                   Name | Data_points |
|-----------------------:|------------:|
|           Initial data |       35570 |
|           Too bad days |           0 |
|        Bad date ranges |           0 |
| Signal physical limits |           0 |
|    Signal night limits |           0 |
|       Negative daytime |           0 |
|         Remaining data |       35570 |



|          CM21value |            CM21sd |         Elevat |                day |
|-------------------:|------------------:|---------------:|-------------------:|
| Min.   :-0.0017624 | Min.   :0.0003711 | Min.   :-72.33 | Min.   :2019-01-01 |
| 1st Qu.: 0.0001602 | 1st Qu.:0.0008022 | 1st Qu.:-47.46 | 1st Qu.:2019-01-07 |
| Median : 0.0007286 | Median :0.0009960 | Median :-13.52 | Median :2019-01-13 |
| Mean   : 0.0232935 | Mean   :0.0012083 | Mean   :-16.57 | Mean   :2019-01-12 |
| 3rd Qu.: 0.0284681 | 3rd Qu.:0.0012533 | 3rd Qu.: 15.59 | 3rd Qu.:2019-01-19 |
| Max.   : 0.2047615 | Max.   :0.0360124 | Max.   : 31.18 | Max.   :2019-01-28 |

\normalsize

<img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-53.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-54.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-55.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P20_Import_Data_filtered_files/figure-html/unnamed-chunk-5-56.png" width="60%" style="display: block; margin: auto;" />




```

  --   CM21_P20_Import_Data_filtered_LAP.R  DONE  --  
```

```
2019-02-03 17:40:28      sagan      athan CM21_P20_Import_Data_filtered_LAP.R  5.423845 mins
```


---
title: "CM21_P20_Import_Data_filtered.R"
author: "athan"
date: "Sun Feb  3 17:35:03 2019"
---
