# High Throughput Computing

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays](ARRAYS.md)
- [Batch job dependencies](DEPENDENCIES.md)
- [Batch job bundling](BUNDLING.md)
- [Preemptible batch jobs](PREEMPTIBLE.md)
- [Distributed high-throughput computing](DHTC.md)

## Batch job bundling

While Expanse was designed to be supportive of HTC-like workflows, most HPC systems are built to accomodate large-scale, parallel jobs. On these systems, compute resources are often scheduled at the node-level and they either discourage or explicitly prohibit the queueing hundreds or thousands of jobs at a time in order to improve the scheduling performance of the system. Under these circumstances, the only way to run HTC workflows that consist of many serial (or small multi-core) jobs without being inherently wasteful and inefficient is to create *job bundles*, wherein a group of independent jobs or tasks are *packed* into and managed (usually in an ad-hoc way) by a single batch job. 

### Linux-native scheduling

The simplest and most straightforward approach to bundling jobs is with the [Linux scheduler](https://en.wikipedia.org/wiki/Completely_Fair_Scheduler). When you execute a command in a batch job script, you can force the process that is started into the *background* to run independently of other processes that may also be created as part of the job. The Linux scheduler will (automagically) distribute the (child) processes across the compute resources available to run the job. 

```
#!/usr/bin/env bash

#SBATCH --job-name=estimate-pi
#SBATCH --account=crl155
#SBATCH --reservation=SI2022DAY2
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:30:00
#SBATCH --output=%x.o%j.%N

module purge

python3 "${HOME}/4pi/python/pi.py" 100000000 &
python3 "${HOME}/4pi/python/pi.py" 100000000 &
python3 "${HOME}/4pi/python/pi.py" 100000000 &
python3 "${HOME}/4pi/python/pi.py" 100000000 &
```

```
wait
```

The Linux scheduler works well for simple workflows. However, for a large number of jobs, especially when each may be running with multiple processes, its performance may be unsatisfying, due to unbalanced workloads from different running jobs, improper process/thread affinity settings, etc.

```
[xdtr108@login02 ~]$ ls
4pi  compute-pi-stats.sh  estimate-pi.sh  run-pi-workflow.sh
[xdtr108@login02 ~]$ cd 4pi/
[xdtr108@login02 4pi]$ ls
bash  c  fortran  LICENSE.md  python  README.md
[xdtr108@login02 4pi]$ cd fortran/
[xdtr108@login02 fortran]$ ls
Makefile  pi.f90  pi_omp.f90
[xdtr108@login02 fortran]$ cat Makefile 
COMPILER := gfortran
COMPILER_OPTIONS := -ffree-form -ffree-line-length-none -fimplicit-none \
                    -O3 -mtune=native -fdefault-integer-8 -fdefault-real-8

all: pi.x pi_omp.x

pi.x: pi.o
	$(COMPILER) $(COMPILER_OPTIONS) -o pi.x pi.o

pi.o: pi.f90
	$(COMPILER) $(COMPILER_OPTIONS) -c pi.f90

pi_omp.x: pi_omp.o
	$(COMPILER) $(COMPILER_OPTIONS) -fopenmp -o pi_omp.x pi_omp.o

pi_omp.o: pi_omp.f90
	$(COMPILER) $(COMPILER_OPTIONS) -fopenmp -c pi_omp.f90

.PHONY: clean
clean:
	rm *.x *.o
```


http://www.hpc.acad.bg/numactl/

https://cvw.cac.cornell.edu/hybrid/numactl

https://www.glennklockwood.com/hpc-howtos/process-affinity.html

### GNU parallel

### MPI-based scheduling

### Advanced job bundling tools and utilities

Many HPC centers have developed their own custom job bundling tools to provide more advanced capabilties than the methods discuess thus far. In general, you can use these bundling utilties on other systems. However, they may take some time to setup and deploy on a new system. For example, one popular job bundling tool is the [Texas Advanced Computing Center (TACC) launcher](https://github.com/TACC/launcher), which has been used at SDSC in the past and is also available on [Georgia Tech's PACE cluster](https://docs.pace.gatech.edu/software/launcher). Other examples of job bundling tools and utilities include [NCSA's scheduler.x](https://github.com/ncsa/Scheduler) and [NIH's Swarm](https://hpc.nih.gov/apps/swarm.html).


https://dl.acm.org/doi/fullHtml/10.1145/3437359.3465569

#

Next - [Preemptible batch jobs](PREEMPTIBLE.md)
