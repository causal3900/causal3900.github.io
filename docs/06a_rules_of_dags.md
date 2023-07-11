
# Rules of DAGs

**Sep 26**

**Warning.** As we develop this website, the material below is a draft at teaching these concepts and until we finalize the page it is possible that a definition has a technical error.

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6. For historical reference, optionally see [Greenland, Pearl, and Robins 1999](https://journals.lww.com/epidem/Abstract/1999/01000/Causal_Diagrams_for_Epidemiologic_Research.8.aspx)

This class will introduce key ideas about DAGs.

1. **Path.** A path is a sequence of edges connecting two nodes
2. **Causal path.** A path is causal if all arrows point forward: $A\rightarrow B\rightarrow C$
3. **Backdoor path.** A backdoor path contains edges that do not point the same direction: $A\leftarrow B \rightarrow C$
4. **Collider along a path.** A node such as $B$ where to directed edges collide: $A\rightarrow B \leftarrow C$
5. **Blocked path.** A path is blocked if either
     * it contains a collider that is not held constant or
     * it contains a non-collider that is held constant

