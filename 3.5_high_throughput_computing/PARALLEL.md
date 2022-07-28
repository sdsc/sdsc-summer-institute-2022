# High Throughput Computing

High-throughput computing (HTC) workloads are characterized by large numbers of small jobs. These frequently involve parameter sweeps where the same type of calculation is done repeatedly with different input values or data processing pipelines where an identical set of operations is applied to many files. This session covers the characteristics and potential pitfalls of HTC, job bundling, the Open Science Grid and the resources available through the Partnership to Advance Throughput Computing (PATh).

- [Parallel computing: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays and dependencies](ARRAYS.md)
- [Ad-hoc job/task bundling](BUNDLING.md)
- [Distributed high-throughput computing](DHTC.md)

## Parallel computing: HPC vs. HTC

![Serial computation](https://hpc.llnl.gov/sites/default/files/styles/with_sidebar_1_up/public/serialProblem.gif)

![Parallel computation](https://hpc.llnl.gov/sites/default/files/styles/with_sidebar_1_up/public/parallelProblem.gif)

Why go parallel?

Speed

![Katrina - Low Resolution](https://www.nasa.gov/sites/default/files/geos-5_wspd_2_katrina_0.png)

Scale

![Katrina - High Resolution](https://www.nasa.gov/sites/default/files/geos-5_wspd_6_katrina_0.png)

https://www.nasa.gov/feature/goddard/since-katrina-nasa-advances-storm-models-science


Throughput
