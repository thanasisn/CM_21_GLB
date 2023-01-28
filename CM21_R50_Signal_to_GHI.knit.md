---
title:         "CM21 signal to radiation. **S1 -> L0**"
author:        "Natsis Athanasios"
institute:     "AUTH"
affiliation:   "Laboratory of Atmospheric Physics"
abstract:      "Read signal and dark correction and convert to global radiation."
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
  bookdown::pdf_document2:
    number_sections:  no
    fig_caption:      no
    keep_tex:         no
    latex_engine:     xelatex
    toc:              yes
    fig_width:        7
    fig_height:       4.5
  html_document:
    toc:        true
    fig_width:  7.5
    fig_height: 5
date: "2023-01-28"
params:
   ALL_YEARS: TRUE
---

**S1 -> L0**


**Source code: [github.com/thanasisn/CM_21_GLB](https://github.com/thanasisn/CM_21_GLB)**

**Data display: [thanasisn.netlify.app/3-data_display/2-cm21_global/](https://thanasisn.netlify.app/3-data_display/2-cm21_global/)**

Convert CM21 signal $[V]$ to radiation $[W/m^2]$.

- Apply proper gain by the acquisition system
- Use an interpolated sensitivity between calibrations.
- No filtering of data at this point.
- Mark negative global during day
- Mark too low global in the night
- Mark too much global in the night






```

**ALL_YEARS: FALSE **
```

```

**TEST     : FALSE **
```

```

**YEARS TO DO: 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 **
```


## CM21 conversion factor calculation




|       Date | Sensitivity |  Gain |
|-----------:|------------:|------:|
| 1991-01-01 |   1.198e-05 | 0.005 |
| 1995-10-21 |   1.198e-05 |  0.02 |
| 1995-11-02 |   1.198e-05 |  0.01 |
| 2004-07-01 |   1.198e-05 |  0.04 |
| 2005-12-05 |   1.199e-05 |  0.04 |
| 2011-12-30 |   1.196e-05 |  0.04 |
| 2012-01-31 |   1.196e-05 |  0.04 |
| 2022-06-04 |   1.202e-05 |  0.04 |

Table: CM21 calibrations



\begin{center}\includegraphics[width=1\linewidth]{/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_R50_Signal_to_GHI_files/figure-latex/unnamed-chunk-5-1} \end{center}





\begin{center}\includegraphics[width=1\linewidth]{/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_R50_Signal_to_GHI_files/figure-latex/unnamed-chunk-5-2} \end{center}





\begin{center}\includegraphics[width=1\linewidth]{/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_R50_Signal_to_GHI_files/figure-latex/unnamed-chunk-5-3} \end{center}





\begin{center}\includegraphics[width=1\linewidth]{/home/athan/CM_21_GLB/REPORTS/REPORTS/CM21_R50_Signal_to_GHI_files/figure-latex/unnamed-chunk-5-4} \end{center}


### Mark negative global when sun is up

When elevation is above 0 mark
Global radiation less than -0.3.
These values are considered to be erroneous records.


### Mark minimum Global irradiance.

Reject data when GHI is below an acceptable limit.

**Before 2014-02-05 we use -15,**

**after  2014-02-05 we use -7.**

This is due to changes in instrumentation. This filter may is superseded by another.


### Mark positive radiation when sun is down

when elevation is below -5
mark Global greater than 5.










