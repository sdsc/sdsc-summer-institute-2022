# Session 4.1b Advanced Git & Github

You should be already familiar with creating Pull Requests, merging, and rebasing branches

- https://github.com/sdsc/sdsc-summer-institute-2021/tree/main/1.4b_Advanced_Github
- https://github.com/zonca/conversion_tofix
- https://www.youtube.com/playlist?list=PLSO-KmvudTTtQ19g7ATjnIJja2EsC2dQN


## Step - 1

Login to Expanse.

```
$ ssh expanse
```

Check the (default) loaded modules.

```
[xdtr108@login01 ~]$ module list

Currently Loaded Modules:
  1) shared       3) slurm/expanse/21.08.8   5) DefaultModules
  2) cpu/0.15.4   4) sdsc/1.0
```

If for whatever reason you don't see the above modules listed, then please reset your environment to the default set of modules.

```
[xdtr108@login01 ~]$ module reset
Resetting modules to system default. Reseting $MODULEPATH back to system default. All extra directories will be removed from $MODULEPATH.
[xdtr108@login01 ~]$
```

Now that your default software environment is set. We'll take a quick look at the [GitHub CLI](https://cli.github.com), which we'll use today as part of the exercise. 

#

[Marty Kandes](https://github.com/mkandes), Computational & Data Science Research Specialist, HPC User Services Group, SDSC
