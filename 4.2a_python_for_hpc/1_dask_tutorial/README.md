# Dask Tutorial

[Watch the full SciPy 2020 tutorial](https://www.youtube.com/watch?v=EybGGLbLipI)


Dask provides multi-core execution on larger-than-memory datasets.

We can think of dask at a high and a low level

*  **High level collections:**  Dask provides high-level Array, Bag, and DataFrame
   collections that mimic NumPy, lists, and Pandas but can operate in parallel on
   datasets that don't fit into main memory.  Dask's high-level collections are
   alternatives to NumPy and Pandas for large datasets.
*  **Low Level schedulers:** Dask provides dynamic task schedulers that
   execute task graphs in parallel.  These execution engines power the
   high-level collections mentioned above but can also power custom,
   user-defined workloads.  These schedulers are low-latency (around 1ms) and
   work hard to run computations in a small memory footprint.  Dask's
   schedulers are an alternative to direct use of `threading` or
   `multiprocessing` libraries in complex cases or other task scheduling
   systems like `Luigi` or `IPython parallel`.

Different users operate at different levels but it is useful to understand
both.  This tutorial will interleave between high-level use of `dask.array` and
`dask.dataframe` (even sections) and low-level use of dask graphs and
schedulers (odd sections.)

## On Expanse

Use the singularity container at:

`/expanse/lustre/projects/sds166/zonca/dask-numba-si21.sif`

## Prepare

    conda env create -f binder/environment.yml 
    conda activate python-hpc
    jupyter labextension install @jupyter-widgets/jupyterlab-manager
    jupyter labextension install @bokeh/jupyter_bokeh
    jupyter labextension install dask-labextension
    jupyter serverextension enable dask_labextension

## Links

*  Reference
    *  [Docs](https://dask.org/)
    *  [Examples](https://examples.dask.org/)
    *  [Code](https://github.com/dask/dask/)
    *  [Blog](https://blog.dask.org/)
*  Ask for help
    *   [`dask`](http://stackoverflow.com/questions/tagged/dask) tag on Stack Overflow, for usage questions
    *   [github issues](https://github.com/dask/dask/issues/new) for bug reports and feature requests
    *   [gitter chat](https://gitter.im/dask/dask) for general, non-bug, discussion
    *   Attend a live tutorial

## Outline

0. [Overview](00_overview.ipynb) - dask's place in the universe.

1. [Delayed](01_dask.delayed.ipynb) - the single-function way to parallelize general python code.

3. [Array](03_array.ipynb) - blocked numpy-like functionality with a collection of 
numpy arrays spread across your cluster.

7. [Dataframe](04_dataframe.ipynb) - parallelized operations on many pandas dataframes
spread across your cluster.

5. [Distributed](05_distributed.ipynb) - Dask's scheduler for clusters, with details of
how to view the UI.

6. [Advanced Distributed](06_distributed_advanced.ipynb) - further details on distributed 
computing, including how to debug.

7. [Dataframe Storage](07_dataframe_storage.ipynb) - efficient ways to read and write
dataframes to disc.

8. [Machine Learning](08_machine_learning.ipynb) - applying dask to machine-learning problems.
