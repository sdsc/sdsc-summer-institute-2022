# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy (remote) access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)
- [Going paralllel: Some Lustre basics](LUSTRE.md)

## Going parallel: Some Lustre basics

https://en.wikipedia.org/wiki/Clustered_file_system

https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz

```
[xdtr108@login02 ~]$ cd /expanse/lustre/scratch/xdtr108/temp_project/
[xdtr108@login02 temp_project]$ ls -lh
total 40M
-rw-r--r-- 1 xdtr108 uic157 42M Jul 24 13:05 CIFAR-10-images.tar.gz
```
