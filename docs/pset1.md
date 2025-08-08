# Problem Set 1. Definitions {-}

Relevant material will be covered by **Aug 29**. Problem set is due **Sept 10** at 5pm.

Welcome to the problem set! This homework will practice conceptual and notation ideas for descriptive and causal inference.

To complete the problem set, [**Download the .Rmd**](assets/psets/pset1_download.Rmd) and complete the homework. Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on [Canvas](https://canvas.cornell.edu/courses/57329).

## 1. Practice with potential outcomes {-}

Jose says that coming to Cornell caused him to discover statistics, and it became his major! He says that if he had gone to NYU, he would have stuck with biology.

### 1.1 (7 points) {-}

In Jose's claim, what is the treatment?

**Answer.** Your answer here

### 1.2 (7 points) {-}

Using the mathematical notation we discussed in class, define the two potential outcomes to which Jose is referring

**Answer.** Your answer here

### 1.3 (7 points) {-}

In a sentence or two, say how the Fundamental Problem of Causal Inference applies to Jose's claim.

**Answer.** Your answer here

### 1.4 (7 points) {-}

Using conditional expectations or probabilities, write the following in math: the probability of majoring in statistics is higher among students who attend Cornell than among students who attend NYU.

**Answer.** Your answer here

### 1.5 (7 points) {-}

Give one reason why the average causal effect of attending Cornell versus NYU (the quantity from 1.2, averaged over all students) might be different from the average descriptive difference (from 1.4) in rates of majoring in statistics.

**Answer.** Your answer here

## 2. A sailing class {-}

You are looking into a sailing class through Cornell Wellness! For each claim below, tell us whether the claim is causal or descriptive.

### 2.1 (5 points) {-}

Last year, there was a survey of students who did and did not take the class. The proportion reporting that they felt prepared to sail on Cayuga Lake was higher among those who took the class.

**Answer.** Your answer here

### 2.2 (5 points) {-}

Last year, there was a survey of students before and after the class. The proportion reporting that they felt prepared to sail on Cayuga Lake was higher in the survey taken after the class.

**Answer.** Your answer here

### 2.3 (5 points) {-}

On average, the students in this class emerged more prepared to sail than they would have been without the class.

**Answer.** Your answer here

## Session info {-}

The chunk below will record information about your R session, which is useful for debugging issues in homework assignments that contain code.


``` r
sessionInfo()
```

```
## R version 4.5.0 (2025-04-11)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.5 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.20.so;  LAPACK version 3.10.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## time zone: America/New_York
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets 
## [6] methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          bookdown_0.43    
##  [4] fastmap_1.2.0     xfun_0.52         glue_1.8.0       
##  [7] cachem_1.1.0      knitr_1.50        memoise_2.0.1    
## [10] htmltools_0.5.8.1 rmarkdown_2.29    lifecycle_1.0.4  
## [13] xml2_1.3.8        cli_3.6.5         downlit_0.4.4    
## [16] vctrs_0.6.5       sass_0.4.10       withr_3.0.2      
## [19] jquerylib_0.1.4   compiler_4.5.0    rstudioapi_0.17.1
## [22] tools_4.5.0       pillar_1.10.2     evaluate_1.0.4   
## [25] bslib_0.9.0       yaml_2.3.10       fs_1.6.6         
## [28] jsonlite_2.0.0    rlang_1.1.6
```
