
# Problem Set 1. Definitions {-}

Relevant material will be covered by **Aug 24**. Problem set is due **Aug 31**.

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


```r
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: aarch64-apple-darwin20 (64-bit)
## Running under: macOS Ventura 13.6.2
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRblas.0.dylib 
## LAPACK: /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## time zone: America/New_York
## tzcode source: internal
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets 
## [6] methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.33     R6_2.5.1          bookdown_0.36    
##  [4] fastmap_1.1.1     xfun_0.40         cachem_1.0.8     
##  [7] knitr_1.44        memoise_2.0.1     htmltools_0.5.6.1
## [10] rmarkdown_2.25    xml2_1.3.5        cli_3.6.1        
## [13] downlit_0.4.3     sass_0.4.7        withr_2.5.1      
## [16] jquerylib_0.1.4   compiler_4.3.1    rstudioapi_0.15.0
## [19] tools_4.3.1       evaluate_0.22     bslib_0.5.1      
## [22] yaml_2.3.7        fs_1.6.3          jsonlite_1.8.7   
## [25] rlang_1.1.1
```
