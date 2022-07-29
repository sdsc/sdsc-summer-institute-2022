# High Throughput Computing

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays](ARRAYS.md)
- [Batch job dependencies](DEPENDENCIES.md)
- [Batch job bundling](BUNDLING.md)
- [Preemptible batch jobs](PREEMPTIBLE.md)
- [Distributed high-throughput computing](DHTC.md)

## Batch job arrays

https://slurm.schedmd.com/job_array.html

https://crc.ku.edu/hpc/how-to/arrays

https://rcc.uchicago.edu/docs/running-jobs/array/index.html

https://in.nau.edu/hpc/overview/using-the-cluster-advanced/job-arrays-old/

https://researchit.las.iastate.edu/how-create-slurm-job-array-script

https://cdn.vanderbilt.edu/vu-wp0/wp-content/uploads/sites/157/2017/10/26210640/UsingArrayJobs.pdf


https://hpc.llnl.gov/documentation/tutorials/introduction-parallel-computing-tutorial##ExamplesPI


### Example job: Estimating Pi

[4pi](https://github.com/mkandes/4pi)

```
git clone https://github.com/mkandes/4pi.git
```

![Estimate the value of Pi via Monte Carlo](https://hpc.llnl.gov/sites/default/files/styles/no_sidebar_3_up/public/pi1.gif)

```
[xdtr108@login01 ~]$ git clone https://github.com/mkandes/4pi.git
Cloning into '4pi'...
remote: Enumerating objects: 14, done.
remote: Counting objects: 100% (14/14), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 14 (delta 1), reused 14 (delta 1), pack-reused 0
Unpacking objects: 100% (14/14), 4.64 KiB | 8.00 KiB/s, done.
[xdtr108@login01 ~]$ cd 4pi/
[xdtr108@login01 4pi]$ ls
bash  c  fortran  LICENSE.md  python  README.md
```

#

Next - [Batch job dependencies](DEPENDENCIES.md)
