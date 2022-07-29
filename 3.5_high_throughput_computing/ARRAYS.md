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


### Example problem: Estimating Pi

Login to Expanse.

```
$ ssh expanse
```

Clone the [4pi](https://github.com/mkandes/4pi.git) GitHub repository to your HOME directory on Expanse.

```
git clone https://github.com/mkandes/4pi.git
```

4pi is a collection of simple computer programs that estimate the value of Pi, the mathematical constant defined as the ratio of a circle's circumference to its diameter. Each program in the collection differs only in the programming language it was written in, the set of features of the language it utilized, and/or the fundamental underlying mathematical algorithm it implemented to approximate the value of Pi.

The principal aim of the 4pi project is to explore different aspects of each programming language and their feature sets from a scientific and high-performance computing perspective. For example, the first set of programs included in this initial commit to the project estimate the value of Pi via the Monte Carlo method. This solution is particularly useful for exploring different parallel programming models, languages, libraries, and APIs as it is an embarrassingly parallel (albeit inefficient) solution to the problem.

![Estimate the value of Pi via Monte Carlo](https://hpc.llnl.gov/sites/default/files/styles/no_sidebar_3_up/public/pi1.gif)

```
[xdtr108@login01 ~]$ git clone https://github.com/mkandes/4pi.git
Cloning into '4pi'...
remote: Enumerating objects: 14, done.
remote: Counting objects: 100% (14/14), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 14 (delta 1), reused 14 (delta 1), pack-reused 0
Unpacking objects: 100% (14/14), 4.64 KiB | 8.00 KiB/s, done.
[xdtr108@login01 ~]$ ls 4pi/
bash  c  fortran  LICENSE.md  python  README.md
[xdtr108@login01 ~]$ ls 4pi/python/
pi.py
[xdtr108@login01 ~]$
```

Next, download the example batch job script.

```
wget https://raw.githubusercontent.com/sdsc/sdsc-summer-institute-2022/main/3.5_high_throughput_computing/estimate-pi.sh
```

```
[xdtr108@login01 ~]$ wget https://raw.githubusercontent.com/sdsc/sdsc-summer-institute-2022/main/3.5_high_throughput_computing/estimate-pi.sh
--2022-07-29 13:48:19--  https://raw.githubusercontent.com/sdsc/sdsc-summer-institute-2022/main/3.5_high_throughput_computing/estimate-pi.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.109.133, 185.199.111.133, 185.199.108.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.109.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 311 [text/plain]
Saving to: ‘estimate-pi.sh’

estimate-pi.sh      100%[===================>]     311  --.-KB/s    in 0s      

2022-07-29 13:48:19 (36.4 MB/s) - ‘estimate-pi.sh’ saved [311/311]

[xdtr108@login01 ~]$ cat estimate-pi.sh 
#!/usr/bin/env bash

#SBATCH --job-name=estimate-pi
#SBATCH --account=sds184
#SBATCH --partition=debug
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:30:00
#SBATCH --output=%x.o%j.%N

module purge

time -p python3 "${HOME}/4pi/python/pi.py" 100000000
[xdtr108@login01 ~]$
```

#

Next - [Batch job dependencies](DEPENDENCIES.md)
