
# DAGs and marginal independence

**Sep 26**

**Warning.** As we develop this website, the material below is a draft at teaching these concepts and until we finalize the page it is possible that a definition has a technical error.

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6.1 and 6.2. For historical reference, optionally see [Greenland, Pearl, and Robins 1999](https://journals.lww.com/epidem/Abstract/1999/01000/Causal_Diagrams_for_Epidemiologic_Research.8.aspx).

This class will introduce key ideas about DAGs.

1. **Path.** A path is a sequence of edges connecting two nodes
2. **Causal path.** A path is causal if all arrows point forward: $A\rightarrow B\rightarrow C$
3. **Backdoor path.** A backdoor path contains edges that do not point the same direction: $A\leftarrow B \rightarrow C$
4. **Collider along a path.** A node such as $B$ where to directed edges collide: $A\rightarrow B \leftarrow C$

DAGs help us know if variables $A$ and $B$ are statistically related

* $A$ and $B$ are *marginally dependent* if and only if there exists a path connecting them that does not contain a collider
* $A$ and $B$ are *marginally independent* if and only if any paths connecting them contain a collider


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
