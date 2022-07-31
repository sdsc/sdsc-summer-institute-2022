# High Throughput Computing

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays](ARRAYS.md)
- [Batch job dependencies](DEPENDENCIES.md)
- [Batch job bundling](BUNDLING.md)
- [Preemptible batch jobs](PREEMPTIBLE.md)
- [Distributed high-throughput computing](DHTC.md)

## Batch job bundling

While Expanse was designed to be supportive of HTC-like workflows, many HPC systems cater specifically to large-scale, parallel jobs. On these systems, compute resources are often scheduled at the node-level and they either discourage or explicitly prohibit the queueing hundreds or thousands of jobs at a time in order to improve the scheduling performance of the system. Under these circumstances, the only way to run HTC workflows that consist of many serial (or small multi-core) jobs without being inherently wasteful and inefficient is to create *job bundles*, wherein a group of independent jobs or tasks are *packed* into and managed (usually in an ad-hoc way) by a single batch job script. 

### Linux-native scheduling

### GNU parallel

### MPI-based scheduling

### Advanced job bundling tools and utilities

Many HPC centers have developed their own custom job bundling tools to provide more advanced capabilties than the methods discuess thus far. In general, you can use these bundling utilties on other systems. However, they may take some time to setup and deploy on a new system. For example, one popular job bundling tool is the [Texas Advanced Computing Center (TACC) launcher](https://github.com/TACC/launcher), which has been used at SDSC in the past and is also available on [Georgia Tech's PACE cluster](https://docs.pace.gatech.edu/software/launcher). Other examples of job bundling tools and utilities include [NCSA's scheduler.x](https://github.com/ncsa/Scheduler) and [NIH's Swarm](https://hpc.nih.gov/apps/swarm.html).


https://dl.acm.org/doi/fullHtml/10.1145/3437359.3465569

#

Next - [Preemptible batch jobs](PREEMPTIBLE.md)
