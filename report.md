
Title
=======================
Multithread scalabality of the PageRank algorithm

Things to mention
========================
- task based parallelism
- Dependencies in the page-rank algorithm
- Parallel reduce pattern
- No use of vector instructions
- Thread affinity might hinder scaling
- False sharing might hinder scaling
- Memory access patterns of column vector
- Improving memory access patterns with arch knowledge
- environment use for testing
    - reduced noice in amazon machine
    - compiler and tbb versions

Graphs to get
========================
- scalability of versions with number of threads (use average)
    - linear scaling line based on baseline run 
- divergence of runs with scalability (plot all iterations for certain versions)
- copy vs double buffer vs parallell copy (5, 5-2, 5-3)
