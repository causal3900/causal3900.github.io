
# Difference in differences

## Introduction

> Nov 17. [**Slides.**](assets/slides/8-1_diff_in_diff.pdf) No reading is required, but for reference see [Card \& Krueger 1994](https://davidcard.berkeley.edu/papers/njmin-aer.pdf)

Today we study the effect of a policy change in New Jersey, drawing on evidence from the neighboring state of Pennsylvania.

Difference in difference is an identification strategy to be used when one or more units become treated at some time point while others do not. If we believe an assumption of **parallel trends**, then we can use the change over time for the never-treated units to estimate the change over time that would have been experienced by the units who become treated, in a counterfactual world where they had not become treated.

## Lab
> Nov 18  [**Discussion**](discussion-11.-difference-in-differences) and [**discussion slides**](assets/discussions/discussion11-DID.pdf) Download the R Markdown file [**here**](assets/discussions/DID-discussion.Rmd)

In lab, you will implement a difference in difference estimator in a specific setting. The example comes from [Malesky, Nguyen, \& Tran 2014](https://doi.org/10.1017/S0003055413000580) and will most closely follow the re-analysis of these data by [Egami \& Yamauchi 2023](https://doi.org/10.1017/pan.2022.8).


