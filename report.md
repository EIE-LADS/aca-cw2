
Title
=======================
Multithread scalabality of the PageRank algorithm

Things to mention
========================
INTRO
- introduction on objectives and methodology 
    - objectives
    - environment use for testing
        - reduced noice in amazon machine
        - compiler and tbb versions
- who did what

HPC
- task based parallelism
- Dependencies in the page-rank algorithm
- Parallel reduce pattern
- No use of vector instructions
- copy vs par copy

ARCH
- par copy vs double buffer
- Thread affinity might hinder scaling
- False sharing might hinder scaling
- Memory access patterns of column vector
- Improving memory access patterns with arch knowledge


Graphs to get
========================
- scalability of versions with number of threads (use average)
    - linear scaling line based on baseline run 
- divergence of runs with scalability (plot all iterations for certain versions)
- copy vs double buffer vs parallell copy (5, 5-2, 5-3)
- scaling with problem size for selected versions (5-3, 5-2 and 7?)

Optional
=============
chunk optimization and data collection 
