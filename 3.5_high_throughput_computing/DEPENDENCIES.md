# High Throughput Computing

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays](ARRAYS.md)
- [Batch job dependencies](DEPENDENCIES.md)
- [Batch job bundling](BUNDLING.md)
- [Preemptible batch jobs](PREEMPTIBLE.md)
- [Distributed high-throughput computing](DHTC.md)

## Batch job dependencies

Batch job dependencies are useful when you need to run multiple jobs in a particular order.  A standard example of this is a workflow or pipeline in which the output from one or more jobs is used as the input to the next.  Rather than manually checking the job queue yourself from time to time to see if one job has ended and then manually submit the next, all the jobs in the workflow can be submitted at once. The scheduler will then manage the jobs for you and run them in the proper order based on the conditions you have applied to the jobs.  

SLURM's built-in job dependencies are used to defer the start of a job until the specified dependencies have been satisfied. They are specified with the `-d | --dependency` option to the `sbatch` command.

```
sbatch --dependency=<dependency_list>
```

The format of the `<dependency_list>` is of the form  `<type:job_id[:job_id][,type:job_id[:job_id]]>` or `<type:job_id[:job_id][?type:job_id[:job_id]]>`. Note that all dependencies must be satisfied if the `,` separator is used. In contrast, any dependency may be satisfied if the `?` separator is used. Only one separator may be used. Many jobs can share the same dependency and these jobs may even belong to different users. Once a job dependency fails due to the termination state of a preceding job, *the dependent job will never be run.*

Dependency types:

- **after** - This job can begin execution after the specified jobs have begun execution. 
- **afterany** - This job can begin execution after the specified jobs have terminated.
- **aftercorr** - A task of this job array can begin execution after the corresponding task ID in the specified job has completed successfully (ran to completion with an exit code of zero).
- **afternotok** - This job can begin execution after the specified jobs have terminated in some failed state (non-zero exit code, node failure, timed out, etc). 
- **afterok** - This job can begin execution after the specified jobs have successfully executed (ran to completion with an exit code of zero).
- **singleton** - This job can begin execution after any previously launched jobs sharing the same job name and user have terminated.  In other words, only one job by that name and owned by that user can be running or suspended at any point in time.


### Manually create your first job dependency

Let's start by first cleaning up our HOME directory, deleting all of the standard output files from t

shrinking our large array job down to size and simplifying it a bit.

```
job_id="$(sbatch ${job_name}.sh | grep -o '[[:digit:]]*')"
```

#

Next - [Batch job bundling](BUNDLING.md)
