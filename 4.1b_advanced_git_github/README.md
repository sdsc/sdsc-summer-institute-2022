# Session 4.1b Advanced Git & Github

You should be already familiar with creating Pull Requests, merging, and rebasing branches

- https://github.com/sdsc/sdsc-summer-institute-2021/tree/main/1.4b_Advanced_Github
- https://github.com/zonca/conversion_tofix
- https://www.youtube.com/playlist?list=PLSO-KmvudTTtQ19g7ATjnIJja2EsC2dQN


## Step 0 - Preparation

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

Now that your default software environment is set. We'll take a quick look at the [GitHub CLI](https://cli.github.com), which we have installed on Expanse in a module ...

```
[xdtr108@login01 ~]$ module load gh
[xdtr108@login01 ~]$ gh --version
gh version 1.13.1 (2021-07-20)
https://github.com/cli/cli/releases/tag/v1.13.1


A new release of gh is available: 1.13.1 → v2.14.3
https://github.com/cli/cli/releases/tag/v2.14.3
```

... and use today as part of the exercise. With the `gh` module loaded, go ahead and run the following command to being the authentication process with GitHub.

```
[xdtr108@login01 ~]$ gh auth login
? What account do you want to log into?  [Use arrows to move, type to filter]
> GitHub.com
  GitHub Enterprise Server
```

When you reach the time to enter your one-time code, here is the link to complete the authentication process. 

- https://github.com/login/device

#

[Marty Kandes](https://github.com/mkandes), Computational & Data Science Research Specialist, HPC User Services Group, SDSC
