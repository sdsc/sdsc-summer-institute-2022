# Session 6.2 Scaling up Interactive Data Analysis in Jupyter Lab: From Laptop to HPC #

**Friday, August 5, 2022**

[Peter Rose](https://www.sdsc.edu/research/researcher_spotlight/rose_peter.html) 

In this session we will demonstrate scaling up data analysis to larger than memory (out-of-core) datasets and processing them in parallel on CPU and GPU nodes. In the hands-on exercise we will compare Pandas, Dask, Spark, cuDF, and Dask-cuDF dataframe libraries for handling large datasets. We also cover setting up reproducible and transferable software environments for data analysis. 

Resources:

* Git Repository [df-parallel](https://github.com/sbl-sdsc/df-parallel): Comparison of Dataframe libraries for parallel processing of large tabular files

* [Ten simple rules](https://doi.org/10.1371/journal.pcbi.1007007) for writing and sharing computational analyses in Jupyter Notebooks

-----
## TASK 1: Launch Jupyter Lab on Expanse using a CONDA environment
1. Open a Terminal Window ("expanse Shell Access") through the [Expanse Portal](https://portal.expanse.sdsc.edu/) (use your trainxx login credentials)
  * Note: At this point in time, the portal's Jupyter App form does not currently support all of the latest galyleo command-line options so you will learn to launch a notebook on Expanse using the Galyleo script.  

2. Clone the Git repository df-parallel in your home directory
```
git clone https://github.com/sbl-sdsc/df-parallel.git
```
  
3. Launch Jupyter Lab using the Galyleo script

   This script will generate a URL for your Jupyter Lab session.
```
galyleo launch --account <acount_number> --partition gpu-shared --cpus 10 --memory 92 --gpus 1 --time-limit 01:00:00 --conda-env df-parallel-gpu --conda-yml "${HOME}/df-parallel/environment-gpu.yml" --mamba
```

4. Open a new tab in your web browser and paste the Jupyter Lab URL.  

> You should see the Satellite Reserver Proxy Service page launch in your browser.

5. In your Zoom session, select "Yes" under Reactions after you complete these steps.

------
## TASK 2: Run Notebooks in Jupyter Lab

For this task you will compare the runtime for a simple data analysis using 5 dataframe libraries.

1. Go to the Jupyter Lab session launched in TASK 1

    Navigate to the ```df-parallel/notebooks``` directory.

2. Copy data files

    Run the ```1-DownloadData.ipynb``` and ```1a-Csv2Parquet.ipynb``` notebooks to copy datasets to the local scratch disk on the GPU node.

3. Run the Dataframe notebooks with a csv input file

    Run the following Dataframe notebooks and write down the runtime shown at the bottom of each notebook.
    
> To get exact timings, run the notebook with the **```>>```** (Run All) button!
    
```
2-PandasDataframe.ipynb
3-DaskDataframe.ipynb
4-SparkDataframe.ipynb
5-CudaDataframe.ipynb
6-DaskCudaDataframe.ipynb
```

4. Run Cuda Dataframe notebook with a parquet input file

    In the 5-CudaDataframe.ipynb notebook, change the file format to parquet: ```file_format = "parquet"```
    
> To get exact timings, run the notebook with the **```>>```** (Run All) button!
    
    
    Write down the runtime for Cuda with the parquet format.
    
5. Shutdown Jupyter Lab

    ```File -> Shutdown``` to terminate the process

6. In your Zoom session, select "Yes" under "Reactions" after you complete these steps.
