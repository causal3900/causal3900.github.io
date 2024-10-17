# Directed Acyclic Graphs


## Marginal independence

> Sep 24. [**Slides.**](assets/slides/4-1_dags_marginal.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6.1 and 6.2. For historical reference, optionally see [Greenland, Pearl, and Robins 1999](https://journals.lww.com/epidem/Abstract/1999/01000/Causal_Diagrams_for_Epidemiologic_Research.8.aspx).

This class will introduce key ideas about DAGs.

1. **Directed Acyclic Graph.** A series of nodes representing variables, connected by directed edges representing direct causal effects. Any node with an edge to at least two other nodes must be drawn on the graph.
2. **Path.** A path is a sequence of edges connecting two nodes
3. **Collider along a path.** A node such as $B$ where to directed edges collide: $A\rightarrow B \leftarrow C$. A collider blocks the path.

DAGs help us know if variables $A$ and $B$ are statistically related

* $A$ and $B$ are *marginally dependent* if and only if there exists an unblocked path connecting them
* $A$ and $B$ are *marginally independent* if and only if any paths connecting them are blocked


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

## Lab: Project Overview

> Sep 25.  [**Slides.**](assets/discussions/discussion5-task1.pdf)

You can find information about the course project [**here**](https://causal3900.github.io/course-project.html). During discussion, we will walk through the [**project overview**](https://causal3900.github.io/assets/psets/project/project_overview.pdf) and the instructions for [**Task 1**](https://causal3900.github.io/assets/psets/project/task1.pdf). *Task 1 is due Thursday, October 3rd.*

## Conditional independence

> Sep 26. [**Slides.**](assets/slides/4-2_dag_conditional.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6.3 and 6.4, and especially Fine Point 6.1 of which this page is an abbreviation.

Often, we want to condition on some set of variables $\vec{L}$ so that conditional exchangeability holds. 

A path is blocked if any node on the path is blocked. If every node on a path is open, then the entire path is open

1. A non-collider is blocked if is conditioned on, otherwise it is open
2. A collider is open if it or any of its descendants are conditioned on. Otherwise it is blocked


## Sufficient adjustment sets

> Oct 1. [**Slides.**](assets/slides/4-3_adjustment_sets.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) 7.1--7.4.

When marginal exchangeability does not hold, we may be able to condition on some set of variables $\vec{L}$ so that conditional exchangeability holds. We can accomplish this by blocking all non-causal paths between $A$ and $Y$. A set that does that is called a sufficient adjustment set. To find a sufficient adjustment set, we will use the backdoor criterion:

1. The set $L$ blocks all backdoor paths
2. The set $L$ does not contain any descendants of $A$


## Lab: DAGs Review

> Oct 2  [**Slides.**](assets/discussions/discussion6-dags.pdf)

In this lab, we’re reviewing some DAG basics such as identifying paths and determining whether a path is open or closed.
