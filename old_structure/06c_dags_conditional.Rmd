
# DAGs and conditonal independence

**Sep 28**

**Warning.** As we develop this website, the material below is a draft at teaching these concepts and until we finalize the page it is possible that a definition has a technical error.

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6.3 and 6.4, and especially Fine Point 6.1 of which this page is an abbreviation.

Often, we want to condition on some set of variables $\vec{L}$ so that conditional exchangeability holds. In a DAG, we want to block all backdoor paths between $A$ and $Y$.

This class introduces four rules related to blocking a path

1. A path is blocked if it contains an unadjusted collider
2. A path is blocked if it contains an adjusted non-collider
3. If a collider is adjusted, the collider no longer blocks the path
4. If a descendant of a collider is adjusted, the collider no longer blocks the path

**D-separation** is a concept that encompasses the above rules. Any pair or set of variables are d-separated (and thus independent) if the paths between them are blocked.
