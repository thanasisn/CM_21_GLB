
---
title: "CM21 daily GHI complete dark correction."
author: "Natsis Athanasios"
date: "February 05, 2019"
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



\newpage

##  2006 

\scriptsize

---------------------------------
               Name   Data_points
------------------- -------------
       Initial data        467040

           SD limit             0

  Minimum GHI limit             0

     Remaining data        467040
---------------------------------


----------------------------------------------------------------------------------------------------------------------
           CM21value              CM21sd             Elevat                  day              Global             GLstd
-------------------- ------------------- ------------------ -------------------- ------------------- -----------------
   Min.  :-0.0044937    Min.  :0.000e+00    Min.  :-72.8133    Min.  :2006-01-01     Min.  : -6.8152    Min.  : 0.0000

  1st Qu.:-0.0024371   1st Qu.:7.530e-06   1st Qu.:-27.2591   1st Qu.:2006-03-28     1st Qu.: 0.0013   1st Qu.: 0.0251

  Median :-0.0000727   Median :3.020e-05    Median : 1.0657   Median :2006-06-29     Median : 7.5891   Median : 0.1008

    Mean : 0.0533120     Mean :9.481e-04      Mean : 0.9246     Mean :2006-06-25     Mean : 185.6804     Mean : 3.1638

  3rd Qu.: 0.0907022   3rd Qu.:3.147e-04   3rd Qu.: 28.9675   3rd Qu.:2006-09-20   3rd Qu.: 310.5636   3rd Qu.: 1.0501

   Max.  : 0.3817438    Max.  :1.219e-01    Max.  : 72.8115    Max.  :2006-12-27    Max.  :1281.9977   Max.  :406.6641
----------------------------------------------------------------------------------------------------------------------

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-1.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-2.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-3.png" width="60%" style="display: block; margin: auto;" />

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf
```

```
Warning in max(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-4.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2007 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      447202 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      447202 |



|         CM21value |            CM21sd |          Elevat |                day |            Global |            GLstd |
|------------------:|------------------:|----------------:|-------------------:|------------------:|-----------------:|
| Min.   :-0.004465 | Min.   :0.000e+00 | Min.   :-72.812 | Min.   :2007-01-27 | Min.   : -11.5040 | Min.   :  0.0000 |
| 1st Qu.:-0.002341 | 1st Qu.:2.394e-05 | 1st Qu.:-26.527 | 1st Qu.:2007-04-30 | 1st Qu.:   0.0106 | 1st Qu.:  0.0799 |
| Median : 0.000052 | Median :5.026e-05 | Median :  1.653 | Median :2007-07-24 | Median :   7.8746 | Median :  0.1678 |
| Mean   : 0.055947 | Mean   :7.115e-04 | Mean   :  1.764 | Mean   :2007-07-21 | Mean   : 194.2675 | Mean   :  2.3751 |
| 3rd Qu.: 0.097313 | 3rd Qu.:2.714e-04 | 3rd Qu.: 30.045 | 3rd Qu.:2007-10-12 | 3rd Qu.: 332.3121 | 3rd Qu.:  0.9059 |
| Max.   : 0.422140 | Max.   :1.080e-01 | Max.   : 72.811 | Max.   :2007-12-31 | Max.   :1416.5855 | Max.   :360.4491 |
|                NA |                NA |              NA |                 NA |       NA's   :127 |               NA |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-5.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-6.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-7.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-8.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2008 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      511799 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      511799 |



|          CM21value |            CM21sd |           Elevat |                day |            Global |
|-------------------:|------------------:|-----------------:|-------------------:|------------------:|
| Min.   :-0.0044905 | Min.   :0.000e+00 | Min.   :-72.8116 | Min.   :2008-01-01 | Min.   :  -8.4754 |
| 1st Qu.:-0.0024705 | 1st Qu.:2.495e-05 | 1st Qu.:-27.5921 | 1st Qu.:2008-04-05 | 1st Qu.:   0.0091 |
| Median :-0.0009066 | Median :5.113e-05 | Median :  0.5074 | Median :2008-07-03 | Median :   4.8194 |
| Mean   : 0.0529382 | Mean   :7.353e-04 | Mean   :  0.2474 | Mean   :2008-07-02 | Mean   : 185.1043 |
| 3rd Qu.: 0.0889555 | 3rd Qu.:2.691e-04 | 3rd Qu.: 28.0538 | 3rd Qu.:2008-10-03 | 3rd Qu.: 305.4764 |
| Max.   : 0.3939194 | Max.   :1.188e-01 | Max.   : 72.8099 | Max.   :2008-12-31 | Max.   :1324.4783 |

 

|            GLstd |
|-----------------:|
| Min.   :  0.0000 |
| 1st Qu.:  0.0833 |
| Median :  0.1708 |
| Mean   :  2.4557 |
| 3rd Qu.:  0.8988 |
| Max.   :396.8727 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-9.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-10.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-11.png" width="60%" style="display: block; margin: auto;" />

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf

Warning in min(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf
```

```
Warning in max(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf
```

```
Warning in max(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf
```

```
Warning in max(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-12.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2009 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      478751 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      478751 |



|         CM21value |            CM21sd |            Elevat |                day |           Global |            GLstd |
|------------------:|------------------:|------------------:|-------------------:|-----------------:|-----------------:|
| Min.   :-0.004488 | Min.   :0.000e+00 | Min.   :-72.81105 | Min.   :2009-01-01 | Min.   :  -8.153 | Min.   :  0.0000 |
| 1st Qu.:-0.002627 | 1st Qu.:3.300e-05 | 1st Qu.:-28.68032 | 1st Qu.:2009-03-26 | 1st Qu.:   0.007 | 1st Qu.:  0.1103 |
| Median :-0.002002 | Median :5.399e-05 | Median : -0.02696 | Median :2009-06-22 | Median :   2.264 | Median :  0.1804 |
| Mean   : 0.049828 | Mean   :8.537e-04 | Mean   : -0.55710 | Mean   :2009-06-29 | Mean   : 174.341 | Mean   :  2.8522 |
| 3rd Qu.: 0.080534 | 3rd Qu.:2.717e-04 | 3rd Qu.: 27.47096 | 3rd Qu.:2009-10-06 | 3rd Qu.: 275.704 | 3rd Qu.:  0.9077 |
| Max.   : 0.385809 | Max.   :1.169e-01 | Max.   : 72.77484 | Max.   :2009-12-31 | Max.   :1297.624 | Max.   :390.5166 |
|                NA |                NA |                NA |                 NA |      NA's   :819 |               NA |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-13.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-14.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-15.png" width="60%" style="display: block; margin: auto;" />

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf

Warning in min(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-16.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2010 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      386784 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      386784 |



|          CM21value |            CM21sd |           Elevat |                day |            Global |
|-------------------:|------------------:|-----------------:|-------------------:|------------------:|
| Min.   :-0.0044823 | Min.   :0.000e+00 | Min.   :-133.654 | Min.   :2010-01-01 | Min.   :  -6.7783 |
| 1st Qu.:-0.0025543 | 1st Qu.:3.459e-05 | 1st Qu.: -26.847 | 1st Qu.:2010-03-28 | 1st Qu.:   0.0104 |
| Median :-0.0003927 | Median :5.269e-05 | Median :   1.301 | Median :2010-06-12 | Median :   7.0050 |
| Mean   : 0.0520900 | Mean   :1.071e-03 | Mean   :   1.288 | Mean   :2010-06-20 | Mean   : 182.6183 |
| 3rd Qu.: 0.0855928 | 3rd Qu.:3.091e-04 | 3rd Qu.:  29.711 | 3rd Qu.:2010-09-21 | 3rd Qu.: 294.4432 |
| Max.   : 0.4014083 | Max.   :1.270e-01 | Max.   :  72.809 | Max.   :2010-12-02 | Max.   :1349.5573 |
|                 NA |                NA |               NA |                 NA |       NA's   :113 |

 

|            GLstd |
|-----------------:|
| Min.   :  0.0000 |
| 1st Qu.:  0.1156 |
| Median :  0.1761 |
| Mean   :  3.5808 |
| 3rd Qu.:  1.0332 |
| Max.   :424.6078 |
|               NA |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-17.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-18.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-19.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-20.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2011 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      474119 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      474119 |



|          CM21value |            CM21sd |          Elevat |                day |            Global |            GLstd |
|-------------------:|------------------:|----------------:|-------------------:|------------------:|-----------------:|
| Min.   :-0.0044760 | Min.   :0.000e+00 | Min.   :-72.156 | Min.   :2011-01-03 | Min.   :  -7.7011 | Min.   :  0.0000 |
| 1st Qu.:-0.0024278 | 1st Qu.:2.602e-05 | 1st Qu.:-26.362 | 1st Qu.:2011-03-29 | 1st Qu.:   0.0121 | 1st Qu.:  0.0870 |
| Median : 0.0001724 | Median :9.405e-05 | Median :  1.927 | Median :2011-06-19 | Median :   8.4881 | Median :  0.3145 |
| Mean   : 0.0554998 | Mean   :8.840e-04 | Mean   :  2.050 | Mean   :2011-06-19 | Mean   : 193.5731 | Mean   :  2.9558 |
| 3rd Qu.: 0.0944751 | 3rd Qu.:2.794e-04 | 3rd Qu.: 30.399 | 3rd Qu.:2011-09-11 | 3rd Qu.: 323.9529 | 3rd Qu.:  0.9344 |
| Max.   : 0.3920436 | Max.   :1.149e-01 | Max.   : 72.808 | Max.   :2011-12-05 | Max.   :1318.7440 | Max.   :384.1508 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-21.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-22.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-23.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-24.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2012 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      480217 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      480217 |



|          CM21value |            CM21sd |          Elevat |                day |            Global |            GLstd |
|-------------------:|------------------:|----------------:|-------------------:|------------------:|-----------------:|
| Min.   :-0.0044846 | Min.   :0.000e+00 | Min.   :-72.807 | Min.   :2012-01-31 | Min.   :  -7.0904 | Min.   :  0.0000 |
| 1st Qu.:-0.0028315 | 1st Qu.:6.778e-05 | 1st Qu.:-26.606 | 1st Qu.:2012-04-24 | 1st Qu.:   0.0173 | 1st Qu.:  0.2267 |
| Median :-0.0005704 | Median :1.118e-04 | Median :  1.519 | Median :2012-07-16 | Median :   7.3647 | Median :  0.3739 |
| Mean   : 0.0560065 | Mean   :7.683e-04 | Mean   :  1.705 | Mean   :2012-07-16 | Mean   : 196.7165 | Mean   :  2.5696 |
| 3rd Qu.: 0.0976519 | 3rd Qu.:2.797e-04 | 3rd Qu.: 30.147 | 3rd Qu.:2012-10-09 | 3rd Qu.: 336.0361 | 3rd Qu.:  0.9355 |
| Max.   : 0.3897255 | Max.   :1.130e-01 | Max.   : 72.806 | Max.   :2012-12-31 | Max.   :1312.4774 | Max.   :378.0722 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-25.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-26.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-27.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-28.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2013 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      502311 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      502311 |



|         CM21value |            CM21sd |           Elevat |                day |            Global |            GLstd |
|------------------:|------------------:|-----------------:|-------------------:|------------------:|-----------------:|
| Min.   :-0.004474 | Min.   :0.000e+00 | Min.   :-72.8077 | Min.   :2013-01-01 | Min.   :  -8.2941 | Min.   :  0.0000 |
| 1st Qu.:-0.002932 | 1st Qu.:5.550e-05 | 1st Qu.:-27.3230 | 1st Qu.:2013-04-02 | 1st Qu.:   0.0163 | 1st Qu.:  0.1856 |
| Median :-0.001363 | Median :8.366e-05 | Median :  0.7545 | Median :2013-06-28 | Median :   5.0132 | Median :  0.2798 |
| Mean   : 0.053639 | Mean   :9.957e-04 | Mean   :  0.6355 | Mean   :2013-06-29 | Mean   : 189.2030 | Mean   :  3.3302 |
| 3rd Qu.: 0.089275 | 3rd Qu.:2.838e-04 | 3rd Qu.: 28.6276 | 3rd Qu.:2013-09-25 | 3rd Qu.: 308.3462 | 3rd Qu.:  0.9490 |
| Max.   : 0.387298 | Max.   :1.256e-01 | Max.   : 72.8060 | Max.   :2013-12-29 | Max.   :1304.6895 | Max.   :420.0237 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-29.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-30.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-31.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-32.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2014 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      499683 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      499683 |



|          CM21value |           CM21sd |           Elevat |                day |            Global |           GLstd |
|-------------------:|-----------------:|-----------------:|-------------------:|------------------:|----------------:|
| Min.   :-0.0044845 | Min.   :0.000000 | Min.   :-72.8071 | Min.   :2014-01-01 | Min.   :  -8.4013 | Min.   :  0.000 |
| 1st Qu.:-0.0002213 | 1st Qu.:0.001039 | 1st Qu.:-27.4844 | 1st Qu.:2014-04-10 | 1st Qu.:   0.0128 | 1st Qu.:  3.476 |
| Median : 0.0010643 | Median :0.001522 | Median :  0.6246 | Median :2014-07-06 | Median :   3.8242 | Median :  5.090 |
| Mean   : 0.0528006 | Mean   :0.002213 | Mean   :  0.3313 | Mean   :2014-07-05 | Mean   : 178.0727 | Mean   :  7.400 |
| 3rd Qu.: 0.0819492 | 3rd Qu.:0.002165 | 3rd Qu.: 28.0437 | 3rd Qu.:2014-10-06 | 3rd Qu.: 275.7188 | 3rd Qu.:  7.240 |
| Max.   : 0.4117012 | Max.   :0.127731 | Max.   : 72.8056 | Max.   :2014-12-31 | Max.   :1378.9342 | Max.   :427.194 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-33.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-34.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-35.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-36.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2015 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      475124 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      475124 |



|          CM21value |            CM21sd |            Elevat |                day |            Global |
|-------------------:|------------------:|------------------:|-------------------:|------------------:|
| Min.   :-0.0020905 | Min.   :0.0000000 | Min.   :-124.0415 | Min.   :2015-01-01 | Min.   :  -8.5863 |
| 1st Qu.:-0.0002251 | 1st Qu.:0.0008764 | 1st Qu.: -28.5062 | 1st Qu.:2015-03-27 | 1st Qu.:   0.0063 |
| Median : 0.0010605 | Median :0.0012694 | Median :   0.2724 | Median :2015-07-09 | Median :   3.3987 |
| Mean   : 0.0534110 | Mean   :0.0019318 | Mean   :  -0.1833 | Mean   :2015-06-30 | Mean   : 179.4545 |
| 3rd Qu.: 0.0875053 | 3rd Qu.:0.0016651 | 3rd Qu.:  27.9584 | 3rd Qu.:2015-09-30 | 3rd Qu.: 293.4015 |
| Max.   : 0.4019657 | Max.   :0.1157653 | Max.   :  72.8050 | Max.   :2015-12-21 | Max.   :1344.3264 |

 

|           GLstd |
|----------------:|
| Min.   :  0.000 |
| 1st Qu.:  2.931 |
| Median :  4.245 |
| Mean   :  6.461 |
| 3rd Qu.:  5.569 |
| Max.   :387.175 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-37.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-38.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-39.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-40.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2016 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      519208 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      519208 |



|          CM21value |            CM21sd |           Elevat |                day |            Global |
|-------------------:|------------------:|-----------------:|-------------------:|------------------:|
| Min.   :-0.0020905 | Min.   :0.0001834 | Min.   :-72.8060 | Min.   :2016-01-01 | Min.   :  -6.7108 |
| 1st Qu.:-0.0000763 | 1st Qu.:0.0006344 | 1st Qu.:-27.5568 | 1st Qu.:2016-04-03 | 1st Qu.:   0.0128 |
| Median : 0.0014153 | Median :0.0008020 | Median :  0.7191 | Median :2016-07-04 | Median :   4.2774 |
| Mean   : 0.0559772 | Mean   :0.0016337 | Mean   :  0.3822 | Mean   :2016-07-03 | Mean   : 187.5605 |
| 3rd Qu.: 0.0933342 | 3rd Qu.:0.0010573 | 3rd Qu.: 28.2206 | 3rd Qu.:2016-10-02 | 3rd Qu.: 312.6294 |
| Max.   : 0.3880157 | Max.   :0.1222853 | Max.   : 72.8043 | Max.   :2016-12-31 | Max.   :1297.0150 |

 

|            GLstd |
|-----------------:|
| Min.   :  0.6135 |
| 1st Qu.:  2.1217 |
| Median :  2.6822 |
| Mean   :  5.4638 |
| 3rd Qu.:  3.5360 |
| Max.   :408.9811 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-41.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-42.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-43.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-44.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2017 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      515820 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      515820 |



|          CM21value |            CM21sd |           Elevat |                day |            Global |           GLstd |
|-------------------:|------------------:|-----------------:|-------------------:|------------------:|----------------:|
| Min.   :-0.0020714 | Min.   :0.0000000 | Min.   :-72.8070 | Min.   :2017-01-01 | Min.   :  -7.7059 | Min.   :  0.000 |
| 1st Qu.:-0.0000496 | 1st Qu.:0.0006782 | 1st Qu.:-27.4610 | 1st Qu.:2017-04-01 | 1st Qu.:   0.0128 | 1st Qu.:  2.268 |
| Median : 0.0014725 | Median :0.0007868 | Median :  0.7871 | Median :2017-06-30 | Median :   4.5923 | Median :  2.631 |
| Mean   : 0.0574544 | Mean   :0.0014854 | Mean   :  0.4490 | Mean   :2017-07-01 | Mean   : 192.3060 | Mean   :  4.968 |
| 3rd Qu.: 0.0985451 | 3rd Qu.:0.0009551 | 3rd Qu.: 28.2775 | 3rd Qu.:2017-09-30 | 3rd Qu.: 329.9147 | 3rd Qu.:  3.195 |
| Max.   : 0.3998566 | Max.   :0.1279875 | Max.   : 72.8045 | Max.   :2017-12-31 | Max.   :1338.6506 | Max.   :428.052 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-45.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-46.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-47.png" width="60%" style="display: block; margin: auto;" />

```
Warning in min(daydata$Global, na.rm = T): no non-missing arguments to min;
returning Inf

Warning in min(daydata$Global, na.rm = T): no non-missing arguments to max;
returning -Inf
```

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-48.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2018 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |      510122 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |      510122 |



|          CM21value |            CM21sd |           Elevat |                day |            Global |           GLstd |
|-------------------:|------------------:|-----------------:|-------------------:|------------------:|----------------:|
| Min.   :-0.0020905 | Min.   :0.0000000 | Min.   :-72.8079 | Min.   :2018-01-01 | Min.   :  -8.8159 | Min.   :  0.000 |
| 1st Qu.:-0.0000305 | 1st Qu.:0.0008637 | 1st Qu.:-27.0863 | 1st Qu.:2018-03-30 | 1st Qu.:   0.0128 | 1st Qu.:  2.889 |
| Median : 0.0017204 | Median :0.0013072 | Median :  1.1924 | Median :2018-06-27 | Median :   5.3338 | Median :  4.372 |
| Mean   : 0.0548707 | Mean   :0.0020548 | Mean   :  0.9258 | Mean   :2018-06-27 | Mean   : 183.5311 | Mean   :  6.872 |
| 3rd Qu.: 0.0895958 | 3rd Qu.:0.0017842 | 3rd Qu.: 28.8807 | 3rd Qu.:2018-09-23 | 3rd Qu.: 299.2478 | 3rd Qu.:  5.967 |
| Max.   : 0.4049348 | Max.   :0.1184030 | Max.   : 72.8055 | Max.   :2018-12-31 | Max.   :1352.6322 | Max.   :395.997 |
|                 NA |                NA |               NA |                 NA |       NA's   :348 |              NA |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-49.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-50.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-51.png" width="60%" style="display: block; margin: auto;" />

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-52.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2019 

\scriptsize


|              Name | Data_points |
|------------------:|------------:|
|      Initial data |       35570 |
|          SD limit |           0 |
| Minimum GHI limit |           0 |
|    Remaining data |       35570 |



|          CM21value |            CM21sd |         Elevat |                day |           Global |           GLstd |
|-------------------:|------------------:|---------------:|-------------------:|-----------------:|----------------:|
| Min.   :-0.0017624 | Min.   :0.0003711 | Min.   :-72.33 | Min.   :2019-01-01 | Min.   : -5.7412 | Min.   :  1.241 |
| 1st Qu.: 0.0001602 | 1st Qu.:0.0008022 | 1st Qu.:-47.46 | 1st Qu.:2019-01-07 | 1st Qu.: -0.2041 | 1st Qu.:  2.683 |
| Median : 0.0007286 | Median :0.0009960 | Median :-13.52 | Median :2019-01-13 | Median :  0.8803 | Median :  3.331 |
| Mean   : 0.0232935 | Mean   :0.0012083 | Mean   :-16.57 | Mean   :2019-01-12 | Mean   : 76.9496 | Mean   :  4.041 |
| 3rd Qu.: 0.0284681 | 3rd Qu.:0.0012533 | 3rd Qu.: 15.59 | 3rd Qu.:2019-01-19 | 3rd Qu.: 93.9916 | 3rd Qu.:  4.191 |
| Max.   : 0.2047615 | Max.   :0.0360124 | Max.   : 31.18 | Max.   :2019-01-28 | Max.   :683.9483 | Max.   :120.443 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-53.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-54.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-55.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-5-56.png" width="60%" style="display: block; margin: auto;" />






## Summary of daily statistics.


<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-1.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-2.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-3.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-4.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-5.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-6.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-7.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-8.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-9.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-10.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-11.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-12.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-13.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-14.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-15.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-16.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-17.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-18.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-19.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-20.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-21.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-22.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-23.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-24.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-25.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-26.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-27.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-28.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-29.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P50_GHI_dark_correction_files/figure-html/unnamed-chunk-7-30.png" width="60%" style="display: block; margin: auto;" />


### Days with average global < -50 .



```
Date of length 0
```


### Days with average global > 390 .



```
 [1] "2006-05-26" "2006-05-29" "2006-06-12" "2006-07-18" "2007-06-11"
 [6] "2008-08-15" "2009-06-17" "2009-06-28" "2009-07-02" "2010-07-15"
[11] "2016-06-27" "2017-08-30"
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
[1] "2007-03-20" "2009-06-22" "2009-07-03" "2009-07-07" "2009-07-08"
[6] "2010-08-02" "2018-12-07"
```


### Days with Evening dark data points count < 100 .



```
 [1] "2006-04-09" "2006-05-26" "2006-06-12" "2006-07-18" "2006-10-06"
 [6] "2006-11-11" "2006-12-07" "2007-02-17" "2007-02-24" "2007-03-19"
[11] "2007-03-20" "2007-05-25" "2007-06-07" "2007-09-15" "2008-03-05"
[16] "2008-08-15" "2009-03-12" "2009-06-17" "2009-06-22" "2009-06-24"
[21] "2009-06-28" "2009-06-30" "2009-07-02" "2009-07-03" "2009-07-07"
[26] "2009-07-08" "2009-08-08" "2009-08-21" "2009-09-25" "2009-12-19"
[31] "2010-01-13" "2010-02-11" "2010-02-25" "2010-03-09" "2010-04-02"
[36] "2010-05-10" "2010-06-15" "2010-06-20" "2010-07-09" "2010-07-15"
[41] "2010-07-23" "2010-08-02" "2010-08-05" "2010-10-17" "2010-11-15"
[46] "2010-12-02" "2011-01-23" "2011-08-24" "2011-12-05" "2015-02-18"
[51] "2017-01-04" "2017-08-30" "2018-12-06" "2018-12-07"
```


### Days with Morning dark data points count < 50 .



```
 [1] "2006-02-13" "2006-04-10" "2006-05-01" "2006-05-29" "2006-06-16"
 [6] "2006-07-19" "2006-08-25" "2006-10-09" "2006-10-29" "2006-11-08"
[11] "2006-11-13" "2006-12-13" "2006-12-27" "2007-02-20" "2007-02-23"
[16] "2007-03-01" "2007-03-07" "2007-03-09" "2007-03-20" "2007-03-21"
[21] "2007-05-28" "2007-06-11" "2007-09-18" "2007-12-03" "2008-03-11"
[26] "2008-08-18" "2009-03-13" "2009-06-22" "2009-06-23" "2009-06-25"
[31] "2009-06-29" "2009-07-01" "2009-07-03" "2009-07-07" "2009-07-08"
[36] "2009-07-10" "2009-08-10" "2009-08-27" "2009-09-28" "2009-10-14"
[41] "2009-12-20" "2010-01-15" "2010-02-04" "2010-02-08" "2010-02-17"
[46] "2010-02-26" "2010-03-12" "2010-04-06" "2010-05-14" "2010-06-16"
[51] "2010-06-21" "2010-07-12" "2010-07-19" "2010-08-02" "2010-08-04"
[56] "2010-08-18" "2010-10-18" "2010-11-18" "2011-01-24" "2011-03-11"
[61] "2011-08-25" "2011-10-10" "2011-11-21" "2012-01-31" "2013-03-22"
[66] "2013-08-30" "2013-10-08" "2013-12-13" "2014-02-05" "2014-02-10"
[71] "2014-03-31" "2014-07-17" "2014-10-02" "2015-01-23" "2015-02-19"
[76] "2015-05-11" "2015-06-10" "2016-01-25" "2016-04-21" "2016-06-26"
[81] "2016-06-27" "2017-01-05" "2017-01-12" "2017-08-17" "2017-09-01"
[86] "2017-11-10" "2018-12-06" "2018-12-07" "2018-12-08" "2019-01-28"
```


### Days with ( sun  measurements / sun up ) < 0.2 .



```
[1] "2007-03-20" "2009-06-22" "2009-07-03" "2009-07-07" "2009-07-08"
[6] "2010-08-02" "2018-12-07"
```


### Day with the minimum morning median dark .



```
[1] "2014-01-22 UTC"
```

```

  --   CM21_P50_GHI_dark_correcton.R  DONE  --  
```

```
2019-02-05 22:25:25 sagan athan CM21_P50_GHI_dark_correcton.R  20.188311 mins
```


---
title: "CM21_P50_GHI_dark_correction.R"
author: "athan"
date: "Tue Feb  5 22:05:14 2019"
---
