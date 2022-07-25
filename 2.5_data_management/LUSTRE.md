# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy (remote) access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)
- [Going parallel: Lustre basics](LUSTRE.md)

## Going parallel: Some Lustre basics

https://en.wikipedia.org/wiki/Clustered_file_system

https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz

```
[xdtr108@login02 ~]$ cd "/expanse/lustre/scratch/${USER}/temp_project"
[xdtr108@login02 temp_project]$ ls -lh
total 40M
-rw-r--r-- 1 xdtr108 uic157 42M Jul 24 13:05 CIFAR-10-images.tar.gz
```

```
wget https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
```

```
--2022-07-24 14:56:30--  https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
Resolving ftp.ncbi.nlm.nih.gov (ftp.ncbi.nlm.nih.gov)... 165.112.9.228, 165.112.9.230, 2607:f220:41e:250::10, ...
Connecting to ftp.ncbi.nlm.nih.gov (ftp.ncbi.nlm.nih.gov)|165.112.9.228|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 828637027 (790M) [application/x-gzip]
Saving to: ‘gene_info.gz’

gene_info.gz        100%[===================>] 790.25M  48.0MB/s    in 17s     

2022-07-24 14:56:48 (46.5 MB/s) - ‘gene_info.gz’ saved [828637027/828637027]
```

```
[xdtr108@login02 temp_project]$ ls -lh
total 792M
-rw-r--r-- 1 xdtr108 uic157  42M Jul 24 13:05 CIFAR-10-images.tar.gz
-rw-r--r-- 1 xdtr108 uic157 791M Jul 23 20:35 gene_info.gz
```

```
lfs quota -h -u "${USER}" ./
```

```
lfs quota: '/home/xdtr108' not on a mounted Lustre filesystem
```

```
Disk quotas for usr xdtr108 (uid 514559):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
             ./  792.3M      0k  9.537T       -       9       0 2000000       -
```

```
[xdtr108@login02 temp_project]$ ls -lh ../
total 224K
drwxr-x--T 2 xdtr108 uic157 224K Jul 24 14:56 temp_project
```

```
lfs quota -h -g sds184 ./
```

```
Disk quotas for grp sds184 (gid 11905):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
             ./   5.95G      0k     50T       -   60751       0       0       -
gid 11905 is using default file quota setting
```
