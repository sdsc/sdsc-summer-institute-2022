# Session 2.4 Batch Computing #

**Date: Monday, August 1, 2022**

[Mary Thomas](https://www.sdsc.edu/research/researcher_spotlight/thomas_mary.html) (mpthomas at ucsd.edu)

As computational and data requirements grow, researchers may find that they need to make the transition from dedicated resources (e.g., laptops, desktops) to campus clusters or nationally allocated systems. Jobs on these shared resources are typically executed under the control of a batch submission system such as Slurm, PBS, LSF or SGE. This requires a different mindset since the job needs to be configured so that the application(s) can be run non-interactively and at a time determined by the scheduler. The user also needs to specify the job duration, account information, hardware requirements and partition or queue. The goals of this session is to introduce participants to the fundamentals of batch computing before diving into the details of any particular workload manager to help them become more proficient, help ease porting of applications to different resources, and to allow CI Users to understand concepts such as fair share scheduling and backfilling.
