
---
title: "CM21 daily GHI complete dark correction."
author: "Natsis Athanasios"
date: "February 04, 2019"
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

Apply dark correction on days with missing dark.




```
Warning in min(index(evening)): no non-missing arguments to min; returning
Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

\newpage

##  2006 

\scriptsize

---------------------------------
               Name   Data_points
------------------- -------------
       Initial data        467040

           SD limit             0

  Minimum GHI limit             0

     Remaining data         27449
---------------------------------


------------------------------------------------------------------------------
          CM21value              CM21sd            Elevat                  day
------------------- ------------------- ----------------- --------------------
   Min.  :-0.004447    Min.  :0.000e+00    Min.  :-71.685    Min.  :2006-01-16

  1st Qu.:-0.002444   1st Qu.:8.290e-06   1st Qu.:-24.991   1st Qu.:2006-05-30

  Median : 0.003521   Median :5.841e-05    Median : 3.843   Median :2006-07-29

    Mean : 0.060159     Mean :1.431e-03      Mean : 4.258     Mean :2006-07-21

  3rd Qu.: 0.104278   3rd Qu.:4.736e-04   3rd Qu.: 33.314   3rd Qu.:2006-09-24

   Max.  : 0.334892    Max.  :1.130e-01    Max.  : 72.797    Max.  :2006-12-04
------------------------------------------------------------------------------

Table: Table continues below

 
-------------------------------------
             Global             GLstd
------------------- -----------------
    Min.  : -6.5924    Min.  : 0.0000

    1st Qu.: 0.0047   1st Qu.: 0.0277

   Median : 19.0077   Median : 0.1949

    Mean : 208.5771     Mean : 4.7761

  3rd Qu.: 355.9872   3rd Qu.: 1.5806

   Max.  :1124.9498   Max.  :377.1890
-------------------------------------

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-2.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-3.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-4.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2007 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      447202 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28455 |



|         CM21value |            CM21sd |          Elevat |
|------------------:|------------------:|----------------:|
| Min.   :-0.003909 | Min.   :0.000e+00 | Min.   :-71.781 |
| 1st Qu.:-0.002330 | 1st Qu.:2.579e-05 | 1st Qu.:-23.678 |
| Median : 0.005091 | Median :5.752e-05 | Median :  5.160 |
| Mean   : 0.063531 | Mean   :1.128e-03 | Mean   :  5.753 |
| 3rd Qu.: 0.114903 | 3rd Qu.:3.601e-04 | 3rd Qu.: 34.868 |
| Max.   : 0.356976 | Max.   :1.080e-01 | Max.   : 72.806 |

 

|                day |            Global |            GLstd |
|-------------------:|------------------:|-----------------:|
| Min.   :2007-03-05 | Min.   :  -4.9842 | Min.   :  0.0000 |
| 1st Qu.:2007-05-14 | 1st Qu.:   0.0348 | 1st Qu.:  0.0861 |
| Median :2007-08-06 | Median :  24.7177 | Median :  0.1920 |
| Mean   :2007-07-23 | Mean   : 219.7094 | Mean   :  3.7662 |
| 3rd Qu.:2007-10-02 | 3rd Qu.: 391.5902 | 3rd Qu.:  1.2022 |
| Max.   :2007-12-05 | Max.   :1198.8767 | Max.   :360.4491 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-5.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-6.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-7.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-8.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2008 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      511799 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28645 |



|         CM21value |            CM21sd |          Elevat |
|------------------:|------------------:|----------------:|
| Min.   :-0.004176 | Min.   :0.000e+00 | Min.   :-72.762 |
| 1st Qu.:-0.002434 | 1st Qu.:2.406e-05 | 1st Qu.:-30.086 |
| Median :-0.001686 | Median :4.640e-05 | Median : -1.192 |
| Mean   : 0.044840 | Mean   :5.256e-04 | Mean   : -2.077 |
| 3rd Qu.: 0.063691 | 3rd Qu.:2.202e-04 | 3rd Qu.: 25.974 |
| Max.   : 0.298393 | Max.   :8.565e-02 | Max.   : 72.767 |

 

|                day |            Global |             GLstd |
|-------------------:|------------------:|------------------:|
| Min.   :2008-01-01 | Min.   :  -7.4554 | Min.   :  0.00000 |
| 1st Qu.:2008-03-02 | 1st Qu.:  -0.0031 | 1st Qu.:  0.08036 |
| Median :2008-05-29 | Median :   1.3053 | Median :  0.15494 |
| Mean   :2008-06-21 | Mean   : 157.7483 | Mean   :  1.75536 |
| 3rd Qu.:2008-09-24 | 3rd Qu.: 220.7952 | 3rd Qu.:  0.73515 |
| Max.   :2008-12-28 | Max.   :1005.0588 | Max.   :286.02749 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-9.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-10.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-11.png" width="60%" style="display: block; margin: auto;" />

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in min(index(evening)): no non-missing arguments to min; returning
Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf

Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in dark_correction(dark_day = dark_day, DCOUNTLIM = DCOUNTLIM, type
= "median", : 2009-07-08 08070906 No dark don't know what to do!! using
-8.78569783385263 for Dark!!
```

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf
```

```
Warning in max(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-12.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2009 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      478751 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       26968 |



|          CM21value |            CM21sd |          Elevat |
|-------------------:|------------------:|----------------:|
| Min.   :-0.0044831 | Min.   :0.000e+00 | Min.   :-72.705 |
| 1st Qu.:-0.0026752 | 1st Qu.:3.238e-05 | 1st Qu.:-25.911 |
| Median :-0.0000486 | Median :5.938e-05 | Median :  1.969 |
| Mean   : 0.0575672 | Mean   :5.432e-04 | Mean   :  1.975 |
| 3rd Qu.: 0.1024406 | 3rd Qu.:2.736e-04 | 3rd Qu.: 29.756 |
| Max.   : 0.3272163 | Max.   :8.984e-02 | Max.   : 72.717 |
|                 NA |                NA |              NA |

 

|                day |            Global |            GLstd |
|-------------------:|------------------:|-----------------:|
| Min.   :2009-01-15 | Min.   :  -7.3966 | Min.   :  0.0000 |
| 1st Qu.:2009-02-16 | 1st Qu.:   0.0115 | 1st Qu.:  0.1082 |
| Median :2009-06-10 | Median :   7.7459 | Median :  0.1984 |
| Mean   :2009-05-29 | Mean   : 195.4472 | Mean   :  1.8148 |
| 3rd Qu.:2009-07-25 | 3rd Qu.: 332.9283 | 3rd Qu.:  0.9141 |
| Max.   :2009-12-26 | Max.   :1102.1646 | Max.   :300.1100 |
|                 NA |       NA's   :238 |               NA |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-13.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-14.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-15.png" width="60%" style="display: block; margin: auto;" />

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in min(index(evening)): no non-missing arguments to min; returning
Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in min(index(evening)): no non-missing arguments to min; returning
Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-16.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2010 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      386784 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       25776 |



|         CM21value |            CM21sd |            Elevat |
|------------------:|------------------:|------------------:|
| Min.   :-0.004063 | Min.   :0.000e+00 | Min.   :-70.23315 |
| 1st Qu.:-0.002573 | 1st Qu.:3.743e-05 | 1st Qu.:-30.79965 |
| Median :-0.001927 | Median :5.435e-05 | Median :  0.03988 |
| Mean   : 0.047595 | Mean   :6.854e-04 | Mean   : -0.64850 |
| 3rd Qu.: 0.073223 | 3rd Qu.:2.655e-04 | 3rd Qu.: 28.85293 |
| Max.   : 0.382705 | Max.   :1.120e-01 | Max.   : 72.80877 |

 

|                day |            Global |            GLstd |
|-------------------:|------------------:|-----------------:|
| Min.   :2010-01-18 | Min.   :  -5.2277 | Min.   :  0.0000 |
| 1st Qu.:2010-03-05 | 1st Qu.:  -0.0053 | 1st Qu.:  0.1251 |
| Median :2010-06-21 | Median :   1.9856 | Median :  0.1816 |
| Mean   :2010-06-19 | Mean   : 167.7018 | Mean   :  2.2907 |
| 3rd Qu.:2010-09-15 | 3rd Qu.: 253.3302 | 3rd Qu.:  0.8873 |
| Max.   :2010-11-25 | Max.   :1287.5156 | Max.   :374.3840 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-17.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-18.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-19.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-20.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2011 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      474119 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28626 |



|          CM21value |            CM21sd |           Elevat |
|-------------------:|------------------:|-----------------:|
| Min.   :-0.0044181 | Min.   :0.000e+00 | Min.   :-71.2708 |
| 1st Qu.:-0.0024582 | 1st Qu.:2.497e-05 | 1st Qu.:-28.9682 |
| Median :-0.0008515 | Median :7.487e-05 | Median :  0.1984 |
| Mean   : 0.0518205 | Mean   :9.165e-04 | Mean   : -0.1092 |
| 3rd Qu.: 0.0836743 | 3rd Qu.:2.599e-04 | 3rd Qu.: 27.8669 |
| Max.   : 0.3662826 | Max.   :1.100e-01 | Max.   : 72.8026 |

 

|                day |           Global |            GLstd |
|-------------------:|-----------------:|-----------------:|
| Min.   :2011-01-10 | Min.   :  -6.701 | Min.   :  0.0000 |
| 1st Qu.:2011-01-30 | 1st Qu.:   0.003 | 1st Qu.:  0.0835 |
| Median :2011-05-04 | Median :   4.145 | Median :  0.2503 |
| Mean   :2011-05-29 | Mean   : 181.179 | Mean   :  3.0644 |
| 3rd Qu.:2011-09-09 | 3rd Qu.: 287.848 | 3rd Qu.:  0.8688 |
| Max.   :2011-11-08 | Max.   :1232.724 | Max.   :367.6390 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-21.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-22.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-23.png" width="60%" style="display: block; margin: auto;" />

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf

Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-24.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2012 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      480217 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28098 |



|          CM21value |            CM21sd |          Elevat |
|-------------------:|------------------:|----------------:|
| Min.   :-0.0042685 | Min.   :0.000e+00 | Min.   :-72.644 |
| 1st Qu.:-0.0028360 | 1st Qu.:7.054e-05 | 1st Qu.:-26.624 |
| Median : 0.0004355 | Median :1.160e-04 | Median :  2.219 |
| Mean   : 0.0617703 | Mean   :7.512e-04 | Mean   :  2.587 |
| 3rd Qu.: 0.1212173 | 3rd Qu.:2.835e-04 | 3rd Qu.: 31.898 |
| Max.   : 0.3738408 | Max.   :9.234e-02 | Max.   : 72.557 |

 

|                day |            Global |            GLstd |
|-------------------:|------------------:|-----------------:|
| Min.   :2012-01-31 | Min.   :  -3.9205 | Min.   :  0.0000 |
| 1st Qu.:2012-03-25 | 1st Qu.:   0.0183 | 1st Qu.:  0.2359 |
| Median :2012-06-12 | Median :  10.8449 | Median :  0.3881 |
| Mean   :2012-06-20 | Mean   : 216.0929 | Mean   :  2.5125 |
| 3rd Qu.:2012-08-22 | 3rd Qu.: 415.0964 | 3rd Qu.:  0.9482 |
| Max.   :2012-12-27 | Max.   :1258.0603 | Max.   :308.8175 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-25.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-26.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-27.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-28.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2013 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      502311 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28766 |



|         CM21value |            CM21sd |          Elevat |
|------------------:|------------------:|----------------:|
| Min.   :-0.004253 | Min.   :0.000e+00 | Min.   :-71.448 |
| 1st Qu.:-0.002938 | 1st Qu.:5.664e-05 | 1st Qu.:-23.955 |
| Median : 0.004281 | Median :9.990e-05 | Median :  4.794 |
| Mean   : 0.065080 | Mean   :1.208e-03 | Mean   :  5.737 |
| 3rd Qu.: 0.117535 | 3rd Qu.:3.159e-04 | 3rd Qu.: 35.204 |
| Max.   : 0.384875 | Max.   :1.232e-01 | Max.   : 72.757 |

 

|                day |            Global |            GLstd |
|-------------------:|------------------:|-----------------:|
| Min.   :2013-01-15 | Min.   :  -3.9448 | Min.   :  0.0000 |
| 1st Qu.:2013-04-24 | 1st Qu.:   0.0611 | 1st Qu.:  0.1894 |
| Median :2013-06-17 | Median :  23.9676 | Median :  0.3341 |
| Mean   :2013-06-24 | Mean   : 227.6644 | Mean   :  4.0415 |
| 3rd Qu.:2013-08-22 | 3rd Qu.: 403.7021 | 3rd Qu.:  1.0566 |
| Max.   :2013-12-02 | Max.   :1297.0068 | Max.   :412.0120 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-29.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-30.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-31.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-32.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2014 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      499683 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28771 |



|          CM21value |            CM21sd |          Elevat |
|-------------------:|------------------:|----------------:|
| Min.   :-0.0040717 | Min.   :4.097e-05 | Min.   :-72.558 |
| 1st Qu.:-0.0001027 | 1st Qu.:1.048e-03 | 1st Qu.:-27.099 |
| Median : 0.0014381 | Median :1.418e-03 | Median :  1.105 |
| Mean   : 0.0575094 | Mean   :2.351e-03 | Mean   :  1.017 |
| 3rd Qu.: 0.0961247 | 3rd Qu.:1.786e-03 | 3rd Qu.: 28.480 |
| Max.   : 0.3716583 | Max.   :1.277e-01 | Max.   : 72.802 |

 

|                day |            Global |           GLstd |
|-------------------:|------------------:|----------------:|
| Min.   :2014-01-30 | Min.   :  -5.9939 | Min.   :  0.137 |
| 1st Qu.:2014-06-22 | 1st Qu.:   0.0128 | 1st Qu.:  3.504 |
| Median :2014-08-26 | Median :   5.0725 | Median :  4.741 |
| Mean   :2014-08-22 | Mean   : 193.1686 | Mean   :  7.864 |
| 3rd Qu.:2014-11-05 | 3rd Qu.: 323.2136 | 3rd Qu.:  5.972 |
| Max.   :2014-12-29 | Max.   :1243.6731 | Max.   :427.194 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-33.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-34.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-35.png" width="60%" style="display: block; margin: auto;" />

```
Warning in min(index(evening)): no non-missing arguments to min; returning
Inf

Warning in min(index(evening)): no non-missing arguments to min; returning
Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-36.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2015 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      475124 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       27984 |



|         CM21value |            CM21sd |          Elevat |
|------------------:|------------------:|----------------:|
| Min.   :-0.002083 | Min.   :0.0002898 | Min.   :-72.600 |
| 1st Qu.:-0.000145 | 1st Qu.:0.0009691 | 1st Qu.:-26.719 |
| Median : 0.002533 | Median :0.0013376 | Median :  2.026 |
| Mean   : 0.059825 | Mean   :0.0019421 | Mean   :  2.156 |
| 3rd Qu.: 0.103653 | 3rd Qu.:0.0016955 | 3rd Qu.: 30.083 |
| Max.   : 0.401966 | Max.   :0.0911679 | Max.   : 72.600 |

 

|                day |            Global |            GLstd |
|-------------------:|------------------:|-----------------:|
| Min.   :2015-01-19 | Min.   :  -4.9374 | Min.   :  0.9692 |
| 1st Qu.:2015-04-15 | 1st Qu.:   0.0431 | 1st Qu.:  3.2410 |
| Median :2015-07-11 | Median :   8.7671 | Median :  4.4734 |
| Mean   :2015-07-05 | Mean   : 200.8318 | Mean   :  6.4953 |
| 3rd Qu.:2015-09-21 | 3rd Qu.: 347.3323 | 3rd Qu.:  5.6705 |
| Max.   :2015-12-14 | Max.   :1344.3264 | Max.   :304.9094 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-37.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-38.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-39.png" width="60%" style="display: block; margin: auto;" />

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf

Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-40.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2016 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      519208 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28497 |



|          CM21value |            CM21sd |          Elevat |
|-------------------:|------------------:|----------------:|
| Min.   :-0.0018005 | Min.   :0.0002669 | Min.   :-72.269 |
| 1st Qu.: 0.0000381 | 1st Qu.:0.0005688 | 1st Qu.:-25.234 |
| Median : 0.0039024 | Median :0.0007311 | Median :  3.769 |
| Mean   : 0.0578735 | Mean   :0.0021956 | Mean   :  4.102 |
| 3rd Qu.: 0.0972900 | 3rd Qu.:0.0015521 | 3rd Qu.: 33.836 |
| Max.   : 0.3386574 | Max.   :0.1065122 | Max.   : 72.784 |

 

|                day |           Global |            GLstd |
|-------------------:|-----------------:|-----------------:|
| Min.   :2016-01-02 | Min.   :  -5.796 | Min.   :  0.8927 |
| 1st Qu.:2016-03-24 | 1st Qu.:   0.051 | 1st Qu.:  1.9022 |
| Median :2016-05-23 | Median :  12.489 | Median :  2.4451 |
| Mean   :2016-06-08 | Mean   : 193.659 | Mean   :  7.3431 |
| 3rd Qu.:2016-09-09 | 3rd Qu.: 325.369 | 3rd Qu.:  5.1911 |
| Max.   :2016-10-25 | Max.   :1133.056 | Max.   :356.2279 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-41.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-42.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-43.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-44.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2017 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      515820 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28370 |



|          CM21value |            CM21sd |          Elevat |
|-------------------:|------------------:|----------------:|
| Min.   :-0.0017586 | Min.   :0.0003890 | Min.   :-72.788 |
| 1st Qu.:-0.0001183 | 1st Qu.:0.0006966 | 1st Qu.:-26.907 |
| Median : 0.0026474 | Median :0.0008143 | Median :  1.676 |
| Mean   : 0.0633674 | Mean   :0.0011780 | Mean   :  1.500 |
| 3rd Qu.: 0.1221809 | 3rd Qu.:0.0009941 | 3rd Qu.: 28.216 |
| Max.   : 0.3408127 | Max.   :0.0840262 | Max.   : 71.792 |

 

|                day |            Global |           GLstd |
|-------------------:|------------------:|----------------:|
| Min.   :2017-01-04 | Min.   :  -4.8417 | Min.   :  1.301 |
| 1st Qu.:2017-03-30 | 1st Qu.:   0.0383 | 1st Qu.:  2.330 |
| Median :2017-07-08 | Median :   8.8151 | Median :  2.723 |
| Mean   :2017-06-27 | Mean   : 212.2618 | Mean   :  3.940 |
| 3rd Qu.:2017-09-22 | 3rd Qu.: 408.9289 | 3rd Qu.:  3.325 |
| Max.   :2017-12-23 | Max.   :1141.0228 | Max.   :281.024 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-45.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-46.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-47.png" width="60%" style="display: block; margin: auto;" />

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

```
Warning in max(index(morning)): no non-missing arguments to max; returning
-Inf
```

```
Warning in max.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to max; returning -Inf
```

```
Warning in min.default(structure(numeric(0), class = c("POSIXct", "POSIXt":
no non-missing arguments to min; returning Inf
```

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-48.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2018 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      510122 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       27736 |



|          CM21value |            CM21sd |          Elevat |
|-------------------:|------------------:|----------------:|
| Min.   :-0.0019413 | Min.   :0.0001726 | Min.   :-72.804 |
| 1st Qu.: 0.0001678 | 1st Qu.:0.0007557 | 1st Qu.:-33.116 |
| Median : 0.0009651 | Median :0.0010328 | Median : -2.822 |
| Mean   : 0.0378501 | Mean   :0.0017747 | Mean   : -5.508 |
| 3rd Qu.: 0.0455761 | 3rd Qu.:0.0015923 | 3rd Qu.: 23.640 |
| Max.   : 0.3672676 | Max.   :0.1049837 | Max.   : 72.638 |

 

|                day |           Global |            GLstd |
|-------------------:|-----------------:|-----------------:|
| Min.   :2018-01-08 | Min.   :  -5.622 | Min.   :  0.5774 |
| 1st Qu.:2018-02-06 | 1st Qu.:  -0.051 | 1st Qu.:  2.5273 |
| Median :2018-06-14 | Median :   1.682 | Median :  3.4542 |
| Mean   :2018-06-18 | Mean   : 126.012 | Mean   :  5.9354 |
| 3rd Qu.:2018-10-23 | 3rd Qu.: 152.294 | 3rd Qu.:  5.3254 |
| Max.   :2018-12-22 | Max.   :1227.405 | Max.   :351.1161 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-49.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-50.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-51.png" width="60%" style="display: block; margin: auto;" />

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-52.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2019 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |       35570 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       28789 |



|          CM21value |            CM21sd |         Elevat |
|-------------------:|------------------:|---------------:|
| Min.   :-0.0017624 | Min.   :0.0003711 | Min.   :-72.33 |
| 1st Qu.: 0.0001526 | 1st Qu.:0.0007855 | 1st Qu.:-47.60 |
| Median : 0.0007210 | Median :0.0009641 | Median :-13.93 |
| Mean   : 0.0221413 | Mean   :0.0011879 | Mean   :-16.88 |
| 3rd Qu.: 0.0243454 | 3rd Qu.:0.0012114 | 3rd Qu.: 15.10 |
| Max.   : 0.2047615 | Max.   :0.0308396 | Max.   : 30.18 |

 

|                day |           Global |           GLstd |
|-------------------:|-----------------:|----------------:|
| Min.   :2019-01-01 | Min.   : -5.7412 | Min.   :  1.241 |
| 1st Qu.:2019-01-06 | 1st Qu.: -0.1988 | 1st Qu.:  2.627 |
| Median :2019-01-11 | Median :  0.8548 | Median :  3.225 |
| Mean   :2019-01-11 | Mean   : 73.1252 | Mean   :  3.973 |
| 3rd Qu.:2019-01-18 | 3rd Qu.: 80.0828 | 3rd Qu.:  4.051 |
| Max.   :2019-01-24 | Max.   :683.9483 | Max.   :103.143 |

\normalsize

<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-53.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-54.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-55.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-56.png" width="60%" style="display: block; margin: auto;" />






## Summary of daily statistics.


<img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-2.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-3.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-4.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-5.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-6.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-7.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-8.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-9.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-10.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-11.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-12.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-13.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-14.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-15.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-16.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-17.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-18.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-19.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-20.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-21.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-22.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-23.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-24.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-25.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-26.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-27.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-28.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-29.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-30.png" width="60%" style="display: block; margin: auto;" />


### Days with average global < -50 .



```
Date of length 0
```


### Days with average global > 390 .



```
[1] "2006-05-26"
```


### Days with max global > 1500 .



```
Date of length 0
```


### Days with min global < -200 .



```
Date of length 0
```


### Days with min global > 200 .



```
[1] "2009-07-08"
```


### Days with Evening dark data points count < 100 .



```
[1] "2006-05-26" "2007-09-15" "2009-07-08" "2010-03-09" "2010-11-15"
[6] "2015-02-18" "2017-01-04" "2018-12-06"
```


### Days with Morning dark data points count < 50 .



```
 [1] "2006-06-16" "2009-07-01" "2009-07-08" "2010-02-17" "2010-05-14"
 [6] "2010-06-21" "2012-01-31" "2016-06-26" "2018-12-06" "2018-12-08"
```


### Days with ( sun  measurements / sun up ) < 0.2 .



```
[1] "2009-07-08"
```


### Day with the minimum morning median dark .



```
[1] "2009-02-16 UTC"
```

```

  --   CM21_P50_GHI_dark_correcton.R  DONE  --  
```

```
2019-02-04 17:47:38 sagan athan CM21_P50_GHI_dark_correcton.R  5.631032 mins
```


---
title: "CM21_P50_GHI_dark_correction.R"
author: "athan"
date: "Mon Feb  4 17:42:00 2019"
---
