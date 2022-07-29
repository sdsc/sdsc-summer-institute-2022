# High Throughput Computing

High-throughput computing (HTC) workloads are characterized by large numbers of small jobs. These frequently involve parameter sweeps where the same type of calculation is done repeatedly with different input values or data processing pipelines where an identical set of operations is applied to many files. This session covers the characteristics and potential pitfalls of HTC, job bundling, the Open Science Grid and the resources available through the Partnership to Advance Throughput Computing (PATh).

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays and dependencies](ARRAYS.md)
- [Ad-hoc job/task bundling](BUNDLING.md)
- [Distributed high-throughput computing](DHTC.md)

## Parallel paradigms: HPC vs. HTC

### Serial computation
![Serial computation](https://hpc.llnl.gov/sites/default/files/styles/with_sidebar_1_up/public/serialProblem.gif)

### Parallel computation
![Parallel computation](https://hpc.llnl.gov/sites/default/files/styles/with_sidebar_1_up/public/parallelProblem.gif)

### Why go parallel?

#### Speed


<img src='https://www.nasa.gov/sites/default/files/geos-5_wspd_2_katrina_0.png' width='50%' height='50%'/>

[Katrina - Low Resolution Simulation - 50-km - 2005](https://www.nasa.gov/sites/default/files/geos-5_wspd_2_katrina_0.png)

#### Scale

<img src='https://www.nasa.gov/sites/default/files/geos-5_wspd_6_katrina_0.png' width='50%' height='50%'/>

[Katrina - High Resolution Simulation - 6.25-km - 2015](https://www.nasa.gov/sites/default/files/geos-5_wspd_6_katrina_0.png)

https://www.nasa.gov/feature/goddard/since-katrina-nasa-advances-storm-models-science


#### Throughput

<img src='https://www.sdsc.edu/assets/images/news_items/PR20210414_IceCube_antineutrino_1280x800.jpg' width='50%' height='50%'/>

[IceCube - Glashow Event](https://www.sdsc.edu/assets/images/news_items/PR20210414_IceCube_antineutrino_1280x800.jpg)

https://www.sdsc.edu/News%20Items/PR20210414_IceCube_antineutrino.html

<img src='https://www.sdsc.edu/assets/images/news_items/PR20191119_GPU_Cloudburst.jpg' width='50%' height='50%'/>

[IceCube - GPU Cloud Burst](https://www.sdsc.edu/assets/images/news_items/PR20191119_GPU_Cloudburst.jpg)

https://www.sdsc.edu/News%20Items/PR20191119_GPU_Cloudburst.html
