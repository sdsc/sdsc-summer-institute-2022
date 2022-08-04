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

## Hands-on exercises on SDSC Expanse – CUDA

This Github repository contains the CUDA examples that were discussed during the presentation (directory `cuda-samples`) as well as a few select examples from the Nvidia CUDA samples (directory `nvidia-cuda-samples`).

If you are interested in additional CUDA samples, take a look at the [official Nvidia CUDA samples Github repository](https://github.com/NVIDIA/cuda-samples).

We are now ready to look at the CUDA samples.
It can be instructive to look at the source code if you want to learn about CUDA.


### Compile and run the `deviceQuery` CUDA sample

The first sample we will look at is `device_query`. This is a utility that demonstrates how to query Nvidia GPU properties. It often comes in handy to check information on the GPU that you have available.

First, we check that we have an appropriate NVIDIA CUDA compiler available. The CUDA samples require at least version 11.3. Because we loaded the `nvhpc` module above, we should have the `nvcc` compiler available:
```
nvcc --version
```
should give the following output
```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2021 NVIDIA Corporation
Built on Fri_Dec_17_18:16:03_PST_2021
Cuda compilation tools, release 11.6, V11.6.55
Build cuda_11.6.r11.6/compiler.30794723_0
```

We have version 11.6 installed so we are good to go. 
The CUDA samples also require the path to CUDA, which we need to set manually with the current NVHPC installation:
```
export CUDA_PATH=$NVHPCHOME/Linux_x86_64/22.2/cuda
```

We can now move into the `device_query` source directory and compile the code with the `make` command. By default the Makefile will compile for all possible Nvidia GPU architectures. We restrict it to use SM version 7.0, which is the architecture of the V100 GPUs in Expanse:
```
cd cuda-samples/Samples/1_Utilities/deviceQuery
```
```
make SMS=70
```

You now should have an executable `deviceQuery` in the directory. If you execute it: 
```
./deviceQuery
```
you should see an output with details about the GPU that is available. In our case on Expanse it is a Tesla V100-SXM2-32GB GPU:
```
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "Tesla V100-SXM2-32GB"
  CUDA Driver Version / Runtime Version          11.6 / 11.2
  CUDA Capability Major/Minor version number:    7.0
  Total amount of global memory:                 32511 MBytes (34089926656 bytes)
  (080) Multiprocessors, (064) CUDA Cores/MP:    5120 CUDA Cores
  GPU Max Clock rate:                            1530 MHz (1.53 GHz)
  Memory Clock rate:                             877 Mhz
  Memory Bus Width:                              4096-bit
  L2 Cache Size:                                 6291456 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total shared memory per multiprocessor:        98304 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 5 copy engine(s)
  Run time limit on kernels:                     No
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Enabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Managed Memory:                Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 11.6, CUDA Runtime Version = 11.2, NumDevs = 1
Result = PASS
```

### Compile and run the matrix multiplication

It is instructive to look at two different matrix multiplication examples and compare the performance.

First we will look at a hand-written matrix multiplication. This implementation features several performance optimizations such as minimize data transfer from GPU RAM to the GPU processors and increase floating point performance.
```
cd cuda-samples/Samples/0_Introduction/matrixMul
```
```
make SMS=70
```
We now have the executable `matrixMul` available. If we execute it,
```
./matrixMul
```
a matrix multiplication will be performed and the performance reported
```
[Matrix Multiply Using CUDA] - Starting...
GPU Device 0: "Volta" with compute capability 7.0

MatrixA(320,320), MatrixB(640,320)
Computing result using CUDA Kernel...
done
Performance= 2796.59 GFlop/s, Time= 0.047 msec, Size= 131072000 Ops, WorkgroupSize= 1024 threads/block
Checking computed result for correctness: Result = PASS

NOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.
```

### Compile and run matrix multiplication with CUBLAS library

Finally, let us look at a matrix multiplication that uses Nvidia's CUBLAS library, which is a highly optimized version of the Basic Linear Algebra System for Nvidia GPUs.

Note: The `nvhpc` module currently does not set the paths to the Nvidia math libraries. This will be fixed but for now we thus set the paths manually using following commands:
```
export CPATH=$CPATH:$NVHPCHOME/Linux_x86_64/22.2/math_libs/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NVHPCHOME/Linux_x86_64/22.2/math_libs/lib64
export LIBRARY_PATH=$LIBRARY_PATH:$NVHPCHOME/Linux_x86_64/22.2/math_libs/lib64
```

We are now ready to compile the example:
```
cd cuda-samples/Samples/4_CUDA_Libraries/matrixMulCUBLAS
```
```
make SMS=70
```
If we run the executable
```
./matrixMulCUBLAS
```
we should get following output:
```
[Matrix Multiply CUBLAS] - Starting...
GPU Device 0: "Volta" with compute capability 7.0

GPU Device 0: "Tesla V100-SXM2-32GB" with compute capability 7.0

MatrixA(640,480), MatrixB(480,320), MatrixC(640,320)
Computing result using CUBLAS...done.
Performance= 7032.97 GFlop/s, Time= 0.028 msec, Size= 196608000 Ops
Computing result using host CPU...done.
Comparing CUBLAS Matrix Multiply with CPU results: PASS

NOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.
```

How does the performance compare to the hand written (but optimized) matrix multiplication?

[Back to Top](#top)
