
# Problem Set 4. Statistical modeling {-}

Relevant material will be covered by **Oct 17**. Problem set is due **Oct 24**.

To complete the problem set:

- [**Copy and Paste this into a .Rmd file**](https://github.com/causal3900/causal3900.github.io/blob/main/assets/psets/pset4_download.Rmd) and complete the homework. 
- Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on Canvas.

This problem set uses data from the following paper:

> Dehejia, R. H. and Wahba, S. 1999. [Causal Effects in Nonexperimental Studies: Reevaluating the Evaluation of Training Programs](https://www-jstor-org.proxy.library.cornell.edu/stable/2669919?). Journal of the American Statistical Association 94(448):1053--1062.

The paper compares methods for observational causal inference to recover an average causal effect that was already known from a randomized experiment. You do not need to read the paper; we will just use the study's data as an illustration.

The following lines will load these data into R.

```
library(tidyverse)
library(MatchIt)
library(randomForest)
data("lalonde")
```

## 1. (10 points) Drawbacks of Exact Matching {-}

In the discussion section on Wednesday, October 16th, you walked through an example of exact matching with high-dimensional confounding. You looked at some statistics and information of the `re74` values in the full data versus the matched data. Answer the following questions about what you observed:

1. Notice the difference between the values of re74 in the full data versus the matched data. Explain what happened and why it happened. 
2. In light of this example, what is the drawback of using exact matching in this type of setting?

**Answer.**

## 2. (6 points) Outcome modeling {-}

In the code below, we use `randomForest` to learn a model of future earnings `re78` on treatment `treat`, interacted with confounders: `race`, `married`, `nodegree`, and `re74`. A random forest is a machine learning method that trains multiple decision trees in the final prediction model. 

> Knowing about decision trees and random forests is not necessary for this course or problem set. However, if you are interested in learning more about these machine learning methods, you can take a look at this cool (and free) [Google course](https://developers.google.com/machine-learning/decision-forests/decision-trees) or watch [this short video from IBM Technology](https://youtu.be/gkXX4h3qYm4?si=2aa3T-D91wh4BZcQ). 
> Documentation for the R Library `randomForest` can be found [here](https://cran.r-project.org/web/packages/randomForest/randomForest.pdf)








