# High Throughput Computing

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays](ARRAYS.md)
- [Batch job dependencies](DEPENDENCIES.md)
- [Batch job bundling](BUNDLING.md)
- [Preemptible batch jobs](PREEMPTIBLE.md)
- [Distributed high-throughput computing](DHTC.md)

## Batch job dependencies

Batch job dependencies are useful when you need to run multiple jobs in a particular order.  A standard example of this is a workflow in which the output from one or more jobs is used as the input to the next.  Rather than manually checking in yourself from tiem to time to see if one job has ended and then manually submit the next, all the jobs in the workflow can be submitted at once. The scheduler will then manage the jobs for you and run them in the proper order based on the conditions you have applied to the jobs.  

When using SLURM, job dependencies are used to defer the start of a job until the specified dependencies have been satisfied. They are specified with the --dependency option to sbatch,

```
sbatch --dependency=<type:job_id[:job_id][,type:job_id[:job_id]]> ...
```
Dependency `type`s include:
- **after** - This job can begin execution after the specified jobs have begun execution. 
- **afterany** - This job can begin execution after the specified jobs have terminated.
- **aftercorr** - A task of this job array can begin execution after the corresponding task ID in the specified job has completed successfully (ran to completion with an exit code of zero).
- **afternotok** - This job can begin execution after the specified jobs have terminated in some failed state (non-zero exit code, node failure, timed out, etc). 
- **afterok** - This job can begin execution after the specified jobs have successfully executed (ran to completion with an exit code of zero).
- **singleton** - This job can begin execution after any previously launched jobs sharing the same job name and user have terminated.  In other words, only one job by that name and owned by that user can be running or suspended at any point in time.

```
job_id="$(sbatch ${job_name}.sh | grep -o '[[:digit:]]*')"
```

#

Next - [Batch job bundling](BUNDLING.md)
