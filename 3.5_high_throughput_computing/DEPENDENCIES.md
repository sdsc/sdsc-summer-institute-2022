# High Throughput Computing

- [Parallel paradigms: HPC vs. HTC](PARALLEL.md)
- [Batch job arrays](ARRAYS.md)
- [Batch job dependencies](DEPENDENCIES.md)
- [Batch job bundling](BUNDLING.md)
- [Preemptible batch jobs](PREEMPTIBLE.md)
- [Distributed high-throughput computing](DHTC.md)

## Batch job dependencies

| Type | Description |
| ---- | ----------- |
| after      | This job can begin execution after the specified jobs have begun execution. |
| afterany   | This job can begin execution after the specified jobs have terminated. |
| aftercorr  | A task of this job array can begin execution after the corresponding task ID in the specified job has completed successfully (ran to completion with an exit code of zero).  |
| afternotok | This job can begin execution after the specified jobs have terminated in some failed state (non-zero exit code, node failure, timed out, etc). |
| afterok 	 | This job can begin execution after the specified jobs have successfully executed (ran to completion with an exit code of zero). |
| singleton  | This job can begin execution after any previously launched jobs sharing the same job name and user have terminated.  In other words, only one job by that name and owned by that user can be running or suspended at any point in time. |

#

Next - [Batch job bundling](BUNDLING.md)
