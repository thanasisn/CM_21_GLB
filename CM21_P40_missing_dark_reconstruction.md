
---
title: "CM21 dark trend reconstruction."
author: "Natsis Athanasios"
date: "February 04, 2019"
keywords: "CM21, CM21 data validation, global irradiance, dark"
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

We will use existing daily dark signal values, to infer the dark
signal when it can not be computed for a day.
This is a result of missing data before sunrise on/and after sunset.



## Dark calculated as `median` value.

The median dark of a period before morning and after night is used as the
base of the dark signal correction.


<img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-4-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-4-2.png" width="60%" style="display: block; margin: auto;" />


## Dark calculated as `mean` value.

The mean dark of a period before morning and after night is used as the
base of the dark signal correction.


<img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-5-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-5-2.png" width="60%" style="display: block; margin: auto;" />


## Mean Dark from first pass


<img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-6-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-6-2.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-6-3.png" width="60%" style="display: block; margin: auto;" />


## Dark calculated as `running mean` value.


<img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-7-1.png" width="60%" style="display: block; margin: auto;" /><img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-7-2.png" width="60%" style="display: block; margin: auto;" />


 **We will use running mean with a window of 15 days**.

**and interpolate to get a daily value to fill the gaps**





There are 0 missing dark cases to fill.


<img src="CM21_P40_missing_dark_reconstruction_files/figure-html/unnamed-chunk-9-1.png" width="60%" style="display: block; margin: auto;" />

```

  --   CM21_P40_missing_dark_reconstruction.R  DONE  --  
```

```
2019-02-04 19:10:08 sagan athan CM21_P40_missing_dark_reconstruction.R  0.020269 mins
```


---
title: "CM21_P40_missing_dark_reconstruction.R"
author: "athan"
date: "Mon Feb  4 19:10:06 2019"
---
