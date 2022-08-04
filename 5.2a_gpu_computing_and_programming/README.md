# 5.2a GPU Computing and Programming  #

**Date: Thursday, August 4, 2022**

[Andreas Goetz](https://www.sdsc.edu/research/researcher_spotlight/goetz_andreas.html) (agoetz at sdsc.edu)

Effective use of Linux based compute resources via the command line interface (CLI) can significantly increase researcher productivity. Assuming basic familiarity with the Linux CLI we cover some more advanced concepts with focus on the Bash shell. Among others this includes the filesystem hierarchy, file permissions, symbolic and hard links, wildcards and file globbing, finding commands and files, environment variables and modules, configuration files, aliases, history and tips for effective Bash shell scripting. 

**Presentation Slides**: [GPU Computing and Programming](SDSC_SI2022_GPU_Computing_Goetz.pdf)


**Source code**:
* [Official Nvidia CUDA samples](https://github.com/NVIDIA/cuda-samples)
* [Selection of Nvidia CUDA samples](nvidia-cuda-samples)
* [CUDA examples from slides](cuda-samples)
* [OpenACC examples from slides](openacc-samples)

## Accessing GPU nodes and running GPU jobs on SDSC Expanse:

We will log into an Expanse GPU node, compile and test some examples from the Nvidia CUDA samples.

### Log into Expanse, get onto a shared GPU node, and load required modules

First, log onto Expanse using your `xdtr` training account. You can do this either via the Expanse user portal or simply using ssh:
```
ssh xdtrXXX@login.expanse.sdsc.edu
```

Next we will use the alias for the `srun` command that is defined in your `.bashrc` file to access a single GPU on a shared GPU node:
```
srun-gpu-shared
```

Once we are on a GPU node, we load the `gpu` module to gain access to the GPU software stack. We will also load the `nvhpc` module, which provides the NVIDIA HPC SDK:
```
module load gpu
module load nvhpc
module list
```
You should see following output
```

Currently Loaded Modules:
  1) shared                  3) sdsc/1.0         5) gpu/0.15.4
  2) slurm/expanse/21.08.8   4) DefaultModules   6) nvhpc/22.2
```

We can use the `nvidia-smi` command to check for available GPUs and which processes are running on the GPU.
```
nvidia-smi
```
You should have a single V100 GPU available and there should be no processes running:
```
Mon Jun 27 08:39:33 2022       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 510.39.01    Driver Version: 510.39.01    CUDA Version: 11.6     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:18:00.0 Off |                    0 |
| N/A   39C    P0    41W / 300W |      0MiB / 32768MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```


