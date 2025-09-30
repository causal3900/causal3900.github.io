# Problem Set 1. Definitions {-}

Relevant material will be covered by **Aug 28**. Problem set is due **Sept 9** at 5pm.

Welcome to the first problem set! This homework will practice conceptual and notation ideas for descriptive and causal inference.

To complete the problem set, [**Download the .Rmd**](assets/psets/pset1_download.Rmd) and complete the homework. Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on Canvas.

## 1. Practice with potential outcomes {-}

Popeye says that eating spinach caused him to grow strong muscles. He claims that if he had not eaten spinach, he would not have grown strong muscles.  

### 1.1 (7 points) {-}

In Popeye's claim, what is the treatment? You can either describe the treatment variable or explicitly write out the two options the treatment variable can take.

**Answer.** Your answer here

### 1.2 (7 points) {-}

Using the mathematical notation we discussed in class, define the two potential outcomes to which Popeye is referring

**Answer.** Your answer here

### 1.3 (7 points) {-}

In a sentence or two, say how the Fundamental Problem of Causal Inference applies to Popeye's claim.

**Answer.** Your answer here

### 1.4 (7 points) {-}

Using conditional expectations or probabilities, write the following in math: the probability of having strong muscles is higher among individuals who eat spinach than among individuals who do not eat spinach.

**Answer.** Your answer here

### 1.5 (7 points) {-}

Give one reason why the average causal effect of eating spinach (the quantity from 1.2, averaged over all individuals) might be different from the average descriptive difference (from 1.4) of having strong muscles.

**Answer.** Your answer here

## 2. Taking 3900 {-}

You are wondering if taking STSCI 3900 will help you get a higher paying job. For each claim below, tell us whether the claim is causal or descriptive.

### 2.1 (5 points) {-}

Last year, there was a survey of all Cornell students who have graduated in the past two years. The students who did take 3900 reported an average salary of 85,000 dollars and the students who did not take 3900 reported an average salary of 78,000 dollars. 

**Answer.** Your answer here

### 2.2 (5 points) {-}

A student who did not take the course took a job after graduation that paid 80,000. Had this student taken the course, they would have taken a job that paid 85,000. 

**Answer.** Your answer here

### 2.3 (5 points) {-}

Among students who have an on-campus job and took the course, the average wage was 18.50/hr the semester before they took the course and the average wage the semester after taking the course was 21.25.  

**Answer.** Your answer here

### 2.4 (5 points) {-}

Students who took the course applied for twice as many jobs after graduation compared to students who did not take the course.  

**Answer.** Your answer here

## Session info {-}

The chunk below will record information about your R session, which is useful for debugging issues in homework assignments that contain code.


``` r
sessionInfo()
```

```
## R version 4.5.1 (2025-06-13)
## Platform: aarch64-apple-darwin20
## Running under: macOS Tahoe 26.0
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRblas.0.dylib 
## LAPACK: /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1
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
##  [1] digest_0.6.37     R6_2.6.1          bookdown_0.43    
##  [4] fastmap_1.2.0     xfun_0.52         glue_1.8.0       
##  [7] cachem_1.1.0      knitr_1.50        memoise_2.0.1    
## [10] htmltools_0.5.8.1 rmarkdown_2.29    lifecycle_1.0.4  
## [13] xml2_1.3.8        cli_3.6.5         downlit_0.4.4    
## [16] vctrs_0.6.5       sass_0.4.10       withr_3.0.2      
## [19] jquerylib_0.1.4   compiler_4.5.1    rstudioapi_0.17.1
## [22] tools_4.5.1       pillar_1.11.0     evaluate_1.0.4   
## [25] bslib_0.9.0       yaml_2.3.10       fs_1.6.6         
## [28] jsonlite_2.0.0    rlang_1.1.6
```
