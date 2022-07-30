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
| after      | This job can begin execution after the specified jobs have begun execution |
| afterany   | This job can begin execution after the specified jobs have terminated. |
| aftercorr  | A task of this job array can begin execution after the corresponding task ID in the specified job has completed successfully |
| afternotok | This job can begin execution after the specified jobs have terminated in some failed state |
| afterok 	 | This job can begin execution after the specified jobs have successfully executed |
| singleton  | This job can begin execution after any previously launched jobs sharing the same job name and user have terminated |

#

Next - [Batch job bundling](BUNDLING.md)
