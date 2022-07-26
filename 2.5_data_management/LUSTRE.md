# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)
- [Going parallel: Lustre basics](LUSTRE.md)
- [Back that data up: Data transfer tools](TRANSFER.md)

## Going parallel: Lustre basics

https://en.wikipedia.org/wiki/Clustered_file_system

```
cd "/expanse/lustre/scratch/${USER}/temp_project"
```

```
[xdtr108@login01 temp_project]$ pwd
/expanse/lustre/scratch/xdtr108/temp_project
[xdtr108@login01 temp_project]$ ls -lh
total 40M
-rw-r--r-- 1 xdtr108 uic157 42M Jul 26 09:41 CIFAR-10-images.tar.gz
```

```
wget https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
```

```
total 40M
-rw-r--r-- 1 xdtr108 uic157 42M Jul 26 09:41 CIFAR-10-images.tar.gz
[xdtr108@login01 temp_project]$ wget https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
--2022-07-26 09:45:16--  https://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
Resolving ftp.ncbi.nlm.nih.gov (ftp.ncbi.nlm.nih.gov)... 165.112.9.230, 130.14.250.7, 2607:f220:41e:250::13, ...
Connecting to ftp.ncbi.nlm.nih.gov (ftp.ncbi.nlm.nih.gov)|165.112.9.230|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 829161809 (791M) [application/x-gzip]
Saving to: ‘gene_info.gz’

gene_info.gz                  100%[================================================>] 790.75M  47.0MB/s    in 17s     

2022-07-26 09:45:33 (46.0 MB/s) - ‘gene_info.gz’ saved [829161809/829161809]
```

```
[xdtr108@login01 temp_project]$ ls -lh
total 793M
-rw-r--r-- 1 xdtr108 uic157  42M Jul 26 09:41 CIFAR-10-images.tar.gz
-rw-r--r-- 1 xdtr108 uic157 791M Jul 25 20:25 gene_info.gz
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
[xdtr108@login01 temp_project]$ ls -lh ../
total 224K
drwxr-x--T 2 xdtr108 uic157 224K Jul 26 09:45 temp_project
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

```
lfs getstripe CIFAR-10-images.tar.gz
```

```
CIFAR-10-images.tar.gz
lmm_stripe_count:  1
lmm_stripe_size:   1048576
lmm_pattern:       raid0
lmm_layout_gen:    0
lmm_stripe_offset: 5
	obdidx		 objid		 objid		 group
	     5	      19156534	    0x1244e36	   0x800000400
```

```
lfs getstripe -d ../
```

```
stripe_count:  1 stripe_size:   1048576 pattern:       0 stripe_offset: -1
```

```
lfs getstripe: cannot get lov name: Inappropriate ioctl for device (25)
error: getstripe failed for ../.
```


```
[xdtr108@login01 temp_project]$ lfs df -h /expanse/lustre/scratch 
UUID                       bytes        Used   Available Use% Mounted on
expanse-MDT0000_UUID       26.0T        3.8T       22.2T  15% /expanse/lustre/scratch[MDT:0]
expanse-MDT0001_UUID       29.7T        1.6T       28.1T   6% /expanse/lustre/scratch[MDT:1]
expanse-MDT0002_UUID       29.7T        1.6T       28.1T   6% /expanse/lustre/scratch[MDT:2]
expanse-MDT0003_UUID       29.7T        1.6T       28.1T   6% /expanse/lustre/scratch[MDT:3]
expanse-OST0000_UUID      143.5T       32.3T      111.2T  23% /expanse/lustre/scratch[OST:0]
expanse-OST0001_UUID      143.7T       34.9T      108.8T  25% /expanse/lustre/scratch[OST:1]
expanse-OST0002_UUID      144.0T       32.1T      111.9T  23% /expanse/lustre/scratch[OST:2]
...
expanse-OST0046_UUID      143.4T       34.6T      108.9T  25% /expanse/lustre/scratch[OST:70]
expanse-OST0047_UUID      144.2T       33.1T      111.1T  23% /expanse/lustre/scratch[OST:71]

filesystem_summary:         9.8P        2.3P        7.5P  24% /expanse/lustre/scratch
```


```
[xdtr108@login01 temp_project]$ lfs quota -h -v -u "${USER}" ./
Disk quotas for usr xdtr108 (uid 514559):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
             ./  792.3M      0k  9.537T       -       9       0 2000000       -
expanse-MDT0000_UUID
                   167k*      -    167k       -       3*      -       3       -
expanse-MDT0001_UUID
                    56k*      -     56k       -       2*      -       1       -
expanse-MDT0002_UUID
                    56k*      -     56k       -       1*      -       1       -
expanse-MDT0003_UUID
                   112k*      -    111k       -       3*      -       2       -
expanse-OST0000_UUID
                     0k       -      0k       -       -       -       -       -
expanse-OST0001_UUID
                     0k       -      0k       -       -       -       -       -
expanse-OST0002_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0005_UUID
                 39.72M       -      0k       -       -       -       -       -
expanse-OST0006_UUID
                     0k       -      0k       -       -       -       -       -
expanse-OST0007_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0020_UUID
                 752.2M       -      0k       -       -       -       -       -
expanse-OST0021_UUID
                     0k       -      0k       -       -       -       -       -
expanse-OST0022_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0047_UUID
                     0k       -      0k       -       -       -       -       -
Total allocated inode limit: 7, total allocated block limit: 0k
```

```
cp /cm/shared/examples/sdsc/si/2022/ILSVRC2012_img_val.tar ./
```

```
[xdtr108@login01 temp_project]$ ls -lh
total 6.4G
-rw-r--r-- 1 xdtr108 uic157  42M Jul 26 09:41 CIFAR-10-images.tar.gz
-rw-r--r-- 1 xdtr108 uic157 791M Jul 25 20:25 gene_info.gz
-rw-r--r-- 1 xdtr108 uic157 6.3G Jul 26 11:40 ILSVRC2012_img_val.tar
```

```
[xdtr108@login01 temp_project]$ lfs getstripe ILSVRC2012_img_val.tar 
ILSVRC2012_img_val.tar
lmm_stripe_count:  1
lmm_stripe_size:   1048576
lmm_pattern:       raid0
lmm_layout_gen:    0
lmm_stripe_offset: 50
	obdidx		 objid		 objid		 group
	    50	      18850755	    0x11fa3c3	  0x1180000400

[xdtr108@login01 temp_project]$ mkdir striped
[xdtr108@login01 temp_project]$ ls -lh
total 6.8G
-rw-r--r-- 1 xdtr108 uic157  42M Jul 26 09:41 CIFAR-10-images.tar.gz
-rw-r--r-- 1 xdtr108 uic157 791M Jul 25 20:25 gene_info.gz
-rw-r--r-- 1 xdtr108 uic157 6.3G Jul 26 11:40 ILSVRC2012_img_val.tar
drwxr-xr-x 2 xdtr108 uic157 224K Jul 26 11:41 striped
[xdtr108@login01 temp_project]$ lfs getstripe striped
striped
stripe_count:  1 stripe_size:   1048576 pattern:       0 stripe_offset: -1
```

```
[xdtr108@login01 temp_project]$ lfs setstripe -c 4 striped/
[xdtr108@login01 temp_project]$ lfs getstripe striped/
striped/
stripe_count:  4 stripe_size:   1048576 pattern:       raid0 stripe_offset: -1

[xdtr108@login01 temp_project]$ cp ILSVRC2012_img_val.tar striped/
[xdtr108@login01 temp_project]$ ls -lh ILSVRC2012_img_val.tar striped/
-rw-r--r-- 1 xdtr108 uic157 6.3G Jul 26 11:40 ILSVRC2012_img_val.tar

striped/:
total 5.7G
-rw-r--r-- 1 xdtr108 uic157 6.3G Jul 26 11:44 ILSVRC2012_img_val.tar
[xdtr108@login01 temp_project]$ lfs getstripe striped/ILSVRC2012_img_val.tar 
striped/ILSVRC2012_img_val.tar
lmm_stripe_count:  4
lmm_stripe_size:   1048576
lmm_pattern:       raid0
lmm_layout_gen:    0
lmm_stripe_offset: 65
	obdidx		 objid		 objid		 group
	    65	      17358232	    0x108dd98	   0xec0000400
	    18	      19165212	    0x124701c	   0x340000400
	    61	      19238165	    0x1258d15	   0xac0000401
	    11	      19141033	    0x12411a9	   0xe00000401
```

```
[xdtr108@login01 temp_project]$ lfs quota -h -v -u "${USER}" ./
Disk quotas for usr xdtr108 (uid 514559):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
             ./  12.73G      0k  9.537T       -      16       0 2000000       -
expanse-MDT0000_UUID
                   222k*      -    167k       -       4*      -       3       -
expanse-MDT0001_UUID
                   112k*      -     56k       -       4*      -       1       -
expanse-MDT0002_UUID
                   112k*      -     56k       -       3*      -       1       -
expanse-MDT0003_UUID
                   222k*      -    111k       -       5*      -       2       -
expanse-OST0000_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST000b_UUID
                 1.495G       -      0k       -       -       -       -       -
expanse-OST000c_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0012_UUID
                 1.495G       -      0k       -       -       -       -       -
expanse-OST0013_UUID
                     0k       -      0k       -       -       -       -       -
expanse-OST0014_UUID
                 752.7M       -      0k       -       -       -       -       -
expanse-OST0015_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0021_UUID
                 39.75M       -      0k       -       -       -       -       -
expanse-OST0022_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0032_UUID
                 5.979G       -      0k       -       -       -       -       -
expanse-OST0033_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST003d_UUID
                 1.495G       -      0k       -       -       -       -       -
expanse-OST003e_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0041_UUID
                 1.495G       -      0k       -       -       -       -       -
expanse-OST0042_UUID
                     0k       -      0k       -       -       -       -       -
...
expanse-OST0047_UUID
                     0k       -      0k       -       -       -       -       -
Total allocated inode limit: 7, total allocated block limit: 0k
```


#

Next - [Back that data up: Data transfer tools](TRANSFER.md)
