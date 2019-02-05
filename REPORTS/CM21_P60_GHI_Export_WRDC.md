
---
title: "CM21 export GHI data for WRDC."
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

Apply data aggregation and export data for submission to WRDC.

We calculate the mean global radiation for every quarter of the hour using all available data and ignoring missing values.

The mean hourly values are produced only for the cases where all four of the quarters of each hour are present in the data set.
If there is any missing quarterly value the hourly value is not exported.



\newpage

##  2008 

Data Exported to: sumbit_to_WRDC_2008.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2008 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2008 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2008 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2008 | Mean   : 6.514 | Mean   :15.76 | Mean   :12.00 |
| 3rd Qu.:2008 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2008 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|          global |
|----------------:|
| Min.   :-99.000 |
| 1st Qu.:  0.000 |
| Median :  3.059 |
| Mean   :176.625 |
| 3rd Qu.:298.602 |
| Max.   :997.137 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-1.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-2.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2009 

Data Exported to: sumbit_to_WRDC_2009.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2009 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2009 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2009 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2009 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2009 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2009 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|            global |
|------------------:|
| Min.   : -99.0000 |
| 1st Qu.:   0.0000 |
| Median :   0.5948 |
| Mean   : 149.2458 |
| 3rd Qu.: 232.5135 |
| Max.   :1009.4256 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-3.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-4.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2010 

Data Exported to: sumbit_to_WRDC_2010.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2010 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2010 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2010 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2010 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2010 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2010 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|            global |
|------------------:|
| Min.   : -99.0000 |
| 1st Qu.: -99.0000 |
| Median :   0.1171 |
| Mean   : 106.9237 |
| 3rd Qu.: 146.7979 |
| Max.   :1134.3949 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-5.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-6.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2011 

Data Exported to: sumbit_to_WRDC_2011.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2011 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2011 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2011 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2011 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2011 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2011 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|            global |
|------------------:|
| Min.   : -99.0000 |
| 1st Qu.:   0.0000 |
| Median :   0.9889 |
| Mean   : 165.0038 |
| 3rd Qu.: 284.1817 |
| Max.   :1065.7278 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-7.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-8.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2012 

Data Exported to: sumbit_to_WRDC_2012.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2012 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2012 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2012 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2012 | Mean   : 6.514 | Mean   :15.76 | Mean   :12.00 |
| 3rd Qu.:2012 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2012 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|          global |
|----------------:|
| Min.   :-99.000 |
| 1st Qu.:  0.000 |
| Median :  1.181 |
| Mean   :170.562 |
| 3rd Qu.:296.033 |
| Max.   :995.244 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-9.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-10.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2013 

Data Exported to: sumbit_to_WRDC_2013.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2013 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2013 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2013 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2013 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2013 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2013 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|           global |
|-----------------:|
| Min.   : -99.000 |
| 1st Qu.:   0.000 |
| Median :   2.651 |
| Mean   : 176.692 |
| 3rd Qu.: 299.235 |
| Max.   :1034.022 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-11.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-12.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2014 

Data Exported to: sumbit_to_WRDC_2014.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2014 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2014 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2014 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2014 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2014 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2014 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|           global |
|-----------------:|
| Min.   : -99.000 |
| 1st Qu.:   0.000 |
| Median :   1.691 |
| Mean   : 164.488 |
| 3rd Qu.: 259.839 |
| Max.   :1047.776 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-13.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-14.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2015 

Data Exported to: sumbit_to_WRDC_2015.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2015 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2015 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2015 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2015 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2015 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2015 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|            global |
|------------------:|
| Min.   : -99.0000 |
| 1st Qu.:   0.0000 |
| Median :   0.8338 |
| Mean   : 152.5937 |
| 3rd Qu.: 253.6474 |
| Max.   :1025.1450 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-15.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-16.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2016 

Data Exported to: sumbit_to_WRDC_2016.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2016 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2016 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2016 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2016 | Mean   : 6.514 | Mean   :15.76 | Mean   :12.00 |
| 3rd Qu.:2016 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2016 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|           global |
|-----------------:|
| Min.   : -99.000 |
| 1st Qu.:   0.027 |
| Median :   5.212 |
| Mean   : 183.568 |
| 3rd Qu.: 319.367 |
| Max.   :1013.161 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-17.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-18.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2017 

Data Exported to: sumbit_to_WRDC_2017.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2017 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2017 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2017 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2017 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2017 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2017 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|            global |
|------------------:|
| Min.   : -99.0000 |
| 1st Qu.:   0.0141 |
| Median :   5.1774 |
| Mean   : 187.1187 |
| 3rd Qu.: 332.9455 |
| Max.   :1138.7703 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-19.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-20.png" width="60%" style="display: block; margin: auto;" />\newpage

##  2018 

Data Exported to: sumbit_to_WRDC_2018.dat 
\scriptsize


|         year |          month |           day |          time |
|-------------:|---------------:|--------------:|--------------:|
| Min.   :2018 | Min.   : 1.000 | Min.   : 1.00 | Min.   : 0.50 |
| 1st Qu.:2018 | 1st Qu.: 4.000 | 1st Qu.: 8.00 | 1st Qu.: 6.25 |
| Median :2018 | Median : 7.000 | Median :16.00 | Median :12.00 |
| Mean   :2018 | Mean   : 6.526 | Mean   :15.72 | Mean   :12.00 |
| 3rd Qu.:2018 | 3rd Qu.:10.000 | 3rd Qu.:23.00 | 3rd Qu.:17.75 |
| Max.   :2018 | Max.   :12.000 | Max.   :31.00 | Max.   :23.50 |

 

|           global |
|-----------------:|
| Min.   : -99.000 |
| 1st Qu.:   0.000 |
| Median :   4.085 |
| Mean   : 175.159 |
| 3rd Qu.: 300.561 |
| Max.   :1009.081 |

\normalsize

<img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-21.png" width="60%" style="display: block; margin: auto;" /><img src="/home/athan/CM_21_GLB/REPORTS/CM21_P60_GHI_Export_WRDC_files/figure-html/unnamed-chunk-5-22.png" width="60%" style="display: block; margin: auto;" />
  --   CM21_P60_GHI_Export.R  DONE  --  
2019-02-05 10:43:29 sagan athan CM21_P60_GHI_Export.R  1.891169 mins


---
title: "CM21_P60_GHI_Export_WRDC.R"
author: "athan"
date: "Tue Feb  5 10:41:35 2019"
---
