# Problem Set 4. Statistical Modeling {-}

Relevant material will be covered by **Oct 17**. Problem set is due **Oct 25**.

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


```
outcome_model <- randomForest(re78 ~ treat * (race + married + nodegree + re74), 
                              data = lalonde, 
                              ntree=1000, keep.forest=TRUE)
```

**YOUR TASK**: Use the model above to estimate the average treatment effect among the *treated* (the ATT). o make your code easier to grade, break this task into the following three steps:

1. Create two data frames from the `lalonde` data:
     - The first should contain the *treated* individuals (with their factual treatment of `1`)
     - The second should contain the same *treated* individuals, but with `treat` set to the value `0`.
     - Hint: Both data frames should only contain individuals who were actually treated. One way to do this is with the [`filter`](https://dplyr.tidyverse.org/reference/filter.html) function.
2. Using the `outcome_model` above, predict the expected outcomes for the two data frames you created in step 1.
3. Report the average treatment effect among the treated (ATT).

\textbf{Answer.}


``` r
# Your code goes here
```


## 3. Matching without requiring exact matches {-}

We hope that from this class you are prepared to learn new causal estimators, apply them in R, and explain what you have done. This question is a chance to practice! In class we discussed many matching approaches. For this question, you will choose your own approach. There are many correct answers, and you will be evaluated by the clarity of your code and explanations.

Task: Using `matchit`, conduct matching to estimate the ATT where `treat` is the treatment and the sufficient adjustment set is `race`, `married`, `nodegree`, and `re74`.

1. Use `matchit`, setting `method`, `distance`, and any other arguments (like `replace`, `caliper`, `ratio`) to any values of your choosing. The only requirements are
     * `formula = treat ~ race + married + nodegree + re74`
     * `estimand = "ATT"`
     * For `method`, you may *not* use `exact`.
2. Create matched dataset using `match.data()`
3. Using linear regression with `lm()`, estimate a model using the formula `re78 ~ treat + race + married + nodegree + re74` and your matched data, weighted by the `weights` that are produced by `match.data()`.
4. Report your estimate of the ATT.

### 3.1. (5 points) Conduct the matching {-}

This is space to conduct the matching. We expect this part to be an R code chunk.


``` r
# Your code goes here
```



### 3.2. (5 points) Explain your choices {-}

In a few sentences, tell us about the matching approach you have chosen. Cite content from lecture or discussion slides in your answer by including the slide number(s) and date(s). 

**Answer.**

### 3.3. (2 points) How many units did you keep? {-}

Report the number of treated and control units in the original data, and how many were kept by your matching procedure.

**Answer.**

### 3.4. (2 points) Report your causal estimate {-}

What do you estimate for the average treatment effect on the treated? This is the coefficient on `treat` in the linear regression you fit on the matched data.

**Answer.**


## 4. (10 points) Reflection Question {-}
Answer **one** of the following two prompts in a short paragraph. For full credit, you must refer to at least **two** lecture or discussion slides or exercises that relate to what you choose to write about. To cite slides, simply reference the slide number and date. If you are citing an exercise/.Rmd notebook from a discussion or lecture, indicate the date, title, and subsection if appropriate.

a. Reflect on your overall experience with [Unit 5: Statistical Modeling](https://causal3900.github.io/statistical-modeling.html) by: describing an interesting idea or tool you learned, why it was interesting to you, and what it tells you about causal inference. 

b. Reflect on your overall experience with this problem set by telling us about a particular question that you found challenging, why it was hard for you, how you approached the problem, and what you learned by struggling through the problem.

**Answer.**

