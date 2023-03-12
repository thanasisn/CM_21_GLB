---
title:         "Correlate Horizontal and Inclined CM21 signal **INC ~ HOR**."
author:        "Natsis Athanasios"
abstract:      "Compare Inclined CM21 with Global CM21 to produce a calibration factor for inclined."
institute:     "AUTH"
affiliation:   "Laboratory of Atmospheric Physics"
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
    fig_width:        8
    fig_height:       5
  html_document:
    toc:        true
    fig_width:  7.5
    fig_height: 5

date: "2023-03-12"
params:
   ALL_YEARS: TRUE
---










# Data Overview

Investigate data of horizontal and inclined CM-21.

Inclined data are read from "sirena" directly.

Global data are produced by me.

Data view is extended to:

Start day: 2022-02-21

End day:   2022-06-27



Correlation period:

Start day exact: 2022-02-21 11:50:00

End day exact: 2022-06-27 08:40:00







## Common measurements

Only simultaneous measurements for correlation.








# Process

## Compute dark signal correction for inclined CM-21.

We calculate zero offset as the **median** value of signal with:

- Sun elevation angle bellow $-10^\circ$.
- Data span for dark 20 minutes for each "morning" and "evening".
- We interpolate between the "morning" and "evening" offset for each day for the dark correction.





\newpage

## Correlation Inclined ~ Horizontal CM-21.





### Linear regression

Outliers selection by $2σ$ distance



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-12-1} \end{center}


---------------------------------------------------------------
     &nbsp;        Estimate   Std. Error   t value   Pr(>|t|)  
----------------- ---------- ------------ --------- -----------
 **(Intercept)**   0.00376    0.0003051     12.33    8.205e-35 

 **DT$wattGLB**    0.004648   5.827e-07     7977         0     
---------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
    25437             0.03107         0.9996       0.9996     
--------------------------------------------------------------

Table: Linear regression **RED**


-------------------
    Var1      Freq 
------------ ------
 2022-02-25    13  

 2022-06-03    4   

 2022-06-04    34  

 2022-06-05    66  

 2022-06-06    39  

 2022-06-07    41  

 2022-06-08    16  

 2022-06-09    17  

 2022-06-10    8   

 2022-06-11    24  

 2022-06-12    5   

 2022-06-13    20  

 2022-06-14    49  

 2022-06-15    10  

 2022-06-16    26  

 2022-06-17    16  

 2022-06-19    63  

 2022-06-20    57  

 2022-06-21    27  

 2022-06-22    17  

 2022-06-23    5   

 2022-06-24    27  

 2022-06-25    9   

 2022-06-26    46  

 2022-06-27    6   
-------------------

Table: Offending points


---------------------------------------------------------------
     &nbsp;        Estimate   Std. Error   t value   Pr(>|t|)  
----------------- ---------- ------------ --------- -----------
 **(Intercept)**   0.00376    0.0003051     12.33    8.205e-35 

 **DT$wattGLB**    0.004648   5.827e-07     7977         0     
---------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
    25437             0.03107         0.9996       0.9996     
--------------------------------------------------------------

Table: Robust Linear regression **BLUE**


\newpage

## Distribution of ratios





\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-13-1} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-13-2} \end{center}


\newpage

## Floating scale daily plot after dark correction

Ratios are filtered for plotting



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-1} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-2} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-3} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-4} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-5} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-6} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-7} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-8} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-9} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-10} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-11} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-12} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-13} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-14} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-15} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-16} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-17} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-18} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-19} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-20} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-21} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-22} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-23} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-24} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-25} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-26} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-27} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-28} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-29} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-30} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-14-31} \end{center}


\newpage

# Results

## Calibrated daily data

Using the linear fit model

With removed offending data points

**Radiometric values are on the same scale now**




\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-1} \end{center}


---------------------------------------------------------------
     &nbsp;        Estimate   Std. Error   t value   Pr(>|t|)  
----------------- ---------- ------------ --------- -----------
 **(Intercept)**   0.002936   0.0002064     14.22    1.012e-45 

 **DT$wattGLB**    0.004654   4.024e-07     11565        0     
---------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
    24792             0.02085         0.9998       0.9998     
--------------------------------------------------------------

Table: Linear regression **RED**


---------------------------------------------------------------
     &nbsp;        Estimate   Std. Error   t value   Pr(>|t|)  
----------------- ---------- ------------ --------- -----------
 **(Intercept)**   0.002936   0.0002064     14.22    1.012e-45 

 **DT$wattGLB**    0.004654   4.024e-07     11565        0     
---------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
    24792             0.02085         0.9998       0.9998     
--------------------------------------------------------------

Table: Robust Linear regression **BLUE**



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-2} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-3} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-4} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-5} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-6} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-7} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-8} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-9} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-10} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-11} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-12} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-13} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-14} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-15} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-16} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-17} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-18} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-19} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-20} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-21} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-22} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-23} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-24} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-25} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-26} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-27} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-28} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-29} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-30} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-31} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{CM21_incline_global_comparison_files/figure-latex/unnamed-chunk-15-32} \end{center}








**END**


```
2023-03-12 17:07:10.0 athan@tyler CM21_incline_global_comparison_ 1.216360 mins
```

