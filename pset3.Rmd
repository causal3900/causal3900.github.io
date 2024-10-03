
# Problem Set 3. DAGs. {-}

Relevant material will be covered by **Oct 1**. Problem set is due **Oct 11**.

To complete the problem set, [**copy this code**](https://github.com/causal3900/causal3900.github.io/blob/main/assets/psets/pset3_download.Rmd) into a .Rmd and complete the homework. Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on Canvas. 

Note: For this problem set only, you may alternatively complete the homework by hand. This is because you are welcome to draw DAGs by hand instead of producing them by code. If you do this, scan or take a picture of your document.

## 1. True or False {-}

For 1.1--1.5, answer True or False: The $Z$ nodes (i.e., either $Z$ itself or the set $\{Z_1, Z_2, \ldots \}$) form a sufficient adjustment set to identify the causal effect of $A$ on $Y$. Explain your answer in one sentence. If False, state the backdoor path that is unblocked conditional on $Z$.

<style>.img-responsive {
  max-width: 100%;
}
</style>

<div class="panel">
  <img class="img-responsive" src="assets/pset3dags.png" alt="DAGs for question 1">
</div>


### 1.6 (4 points) {-}

True or False? Conditioning on $C$ blocks this path: $A\leftarrow B \rightarrow C \leftarrow D \rightarrow Y$. Explain your answer.


### 1.7 (4 points) {-}

True or False? Conditioning on $C$ blocks this path: $A\leftarrow B \leftarrow C \rightarrow D \rightarrow Y$. Explain your answer.

## 2. Draw a DAG {-}

> In this problem, we reference the idea of "adjusting for" a variable $X$. We are using the terminology "adjust for" as equivalent to the terminology "condition on." To _adjust for_ or _condition on_ $X$ means to conduct analysis conditional on $X$.

> Building intuition from standardization, to adjust for or condition on $X$ means to

> * conduct analysis within each subgroup with $X = x$ (example: estimate the relationship between $A$ and $Y$ among those with $X = x$)

> * average the $x$-specific estimates over the population distribution of $X$

### 2.1. Your Task (12 points) {-}
A researcher comes to you with a proposal: identify the causal effect of $A$ on $Y$ by adjusting for any variable $B$ that predicts $A$ and also predicts $Y$. They propose that machine learning can thus solve causal identification for us.

The researcher is wrong. Show them why. Draw a DAG in which

- the effect of $A$ on $Y$ is unconfounded (i.e. marginal exchangeability holds)
- a variable $B$ is statistically associated with $A$
- a variable $B$ is statistically associated with $Y$
- but one does not need to adjust for $B$ to identify the causal effect

For full credit, all you need to do is draw a DAG. No need to explain your answer, although we encourage you to write down your explanation for your own sake, to make sure your DAG says what you expect!

> See [https://rpubs.com/brianwood1/698510](https://rpubs.com/brianwood1/698510) for how to insert an image.
