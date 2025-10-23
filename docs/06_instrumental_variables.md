# (PART) Identification without exchangeability {-}

# Instrumental variables

## Experimental settings

> Oct 21. [**Slides.**](assets/slides/7-1_iv_experimental.pdf)

An instrumental variable (IV) identification strategy applies when a treatment effect of $A$ on $Y$ is confounded by unobserved variables ($U$), but an **instrument** $Z$ creates random unconfounded variation in $A$.

<script type="text/tikz">
  \begin{tikzpicture}
    \node (l) at (0,0) {$L$};
    \node (a) at (1,0) {$A$};
    \node (y) at (2,0) {$Y$};
    \draw[->] (l) -- (a);
    \draw[->] (a) -- (y);
    \draw[->] (l) to[bend right] (y);
  \end{tikzpicture}
</script>

A very clean setting for IV is randomized experiments with non-compliance: an experimenter randomizes the assigned treatment ($Z$) but the actual treatment ($A$) may be unequal to $Z$ because some units do not follow their assignment. Our first class will discuss this setting.

## Lab: Instrumental Variable analysis in Code

In this lab we will implement instrumental variables estimators in R.

> October 22 [**Discussion**](discussion-9.-instrumental-variable) and [**discussion slides**](assets/discussions/discussion9-instrumental-variables.pdf) Download the
R Markdown file [**here**](assets/discussions/discussion9.Rmd)

## Observational settings

> Oct 23 [**Slides.**](assets/slides/7-2_iv_observational.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 16.

On Thursday, we move on to IV analysis in observational settings. Here we focus on the casual assumptions required for IV. These assumptions often hold by design in experiments with non-compliance. In observational settings, they can be more doubtful.
