
# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)
- [Going parallel: Lustre basics](LUSTRE.md)
- [Back that data up: Data transfer tools](TRANSFER.md)

## More files, more problems: Advantages and limitations of different filesystems

```
git clone https://github.com/YoongiKim/CIFAR-10-images.git
```

```
Cloning into 'CIFAR-10-images'...
remote: Enumerating objects: 60027, done.
remote: Total 60027 (delta 0), reused 0 (delta 0), pack-reused 60027
Receiving objects: 100% (60027/60027), 19.94 MiB | 26.94 MiB/s, done.
Resolving deltas: 100% (59990/59990), done.
Updating files: 4% (2723/60001)
```

```
real 1724.19
user 1.01
sys 3.36
```

```
real 1.87
user 0.79
sys 1.08
```

```
cat /etc/auto.home | grep "${USER}"
```

```
xdtr###       -fstype=bind :/expanse/nfs/home#/xdtr###
```

```
cat: /etc/auto.home: No such file or directory
```

```
df -Th | grep "${USER}"
```

```
10.22.100.113:/pool#/home/xdtr###                       nfs       194T  9.3T  185T   5% /home/xdtr###
```

```
$ df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs   16G     0   16G   0% /dev
tmpfs          tmpfs     3.2G  2.3M  3.2G   1% /run
/dev/nvme0n1p3 ext4      1.9T  217G  1.6T  13% /
tmpfs          tmpfs      16G  172K   16G   1% /dev/shm
tmpfs          tmpfs     5.0M  4.0K  5.0M   1% /run/lock
tmpfs          tmpfs      16G     0   16G   0% /sys/fs/cgroup
/dev/loop0     squashfs  128K  128K     0 100% /snap/bare/5
/dev/loop2     squashfs  134M  134M     0 100% /snap/chromium/2033
/dev/loop3     squashfs  114M  114M     0 100% /snap/core/13425
/dev/loop1     squashfs  134M  134M     0 100% /snap/chromium/2020
/dev/loop6     squashfs  219M  219M     0 100% /snap/gnome-3-34-1804/77
/dev/loop8     squashfs   62M   62M     0 100% /snap/core20/1518
/dev/loop11    squashfs  401M  401M     0 100% /snap/gnome-3-38-2004/112
/dev/loop7     squashfs  255M  255M     0 100% /snap/gnome-3-38-2004/106
/dev/loop9     squashfs   56M   56M     0 100% /snap/core18/2538
/dev/loop4     squashfs  114M  114M     0 100% /snap/core/13308
/dev/loop5     squashfs  243M  243M     0 100% /snap/gnome-3-34-1804/27
/dev/loop14    squashfs   55M   55M     0 100% /snap/snap-store/558
/dev/loop10    squashfs   56M   56M     0 100% /snap/core18/2409
/dev/loop12    squashfs   82M   82M     0 100% /snap/gtk-common-themes/1534
/dev/loop13    squashfs   92M   92M     0 100% /snap/gtk-common-themes/1535
/dev/loop15    squashfs   62M   62M     0 100% /snap/core20/1581
/dev/nvme0n1p1 vfat      811M  101M  711M  13% /boot/efi
tmpfs          tmpfs     3.2G  2.4M  3.2G   1% /run/user/1001
```

https://en.wikipedia.org/wiki/File_system

https://en.wikipedia.org/wiki/Network_File_System

https://en.wikipedia.org/wiki/Tmpfs

https://en.wikipedia.org/wiki/Ext4

https://en.wikipedia.org/wiki/NVM_Express


```
srun --job-name=interactive --account=sds184 --partition=shared --nodes=1 --ntasks-per-node=1 --cpus-per-task=1 --mem=2G --time=00:30:00 --wait=0 --pty /bin/bash
```

```
srun: job 14729913 queued and waiting for resources
srun: job 14729913 has been allocated resources
[xdtr###@exp-#-## ~]$
```

```
[xdtr###@exp-1-31 ~]$ df -Th | grep nvme
/dev/nvme0n1p1                                          ext4      916G  3.2G  867G   1% /scratch
```

```
Filesystem                                              Type      Size  Used Avail Use% Mounted on
devtmpfs                                                devtmpfs  126G     0  126G   0% /dev
tmpfs                                                   tmpfs     126G  2.7M  126G   1% /run
/dev/sda2                                               ext4       63G   11G   49G  19% /
none                                                    tmpfs     126G  1.7M  126G   1% /dev/shm
tmpfs                                                   tmpfs     126G     0  126G   0% /sys/fs/cgroup
/dev/sda3                                               ext4       20G  600M   18G   4% /tmp
/dev/sda1                                               vfat      100M     0  100M   0% /boot/efi
/dev/nvme0n1p1                                          ext4      916G  3.2G  867G   1% /scratch
10.22.100.114:/pool4/home                               nfs       206T  9.3T  197T   5% /expanse/nfs/home4
10.22.100.113:/pool3/home                               nfs       194T  9.3T  185T   5% /expanse/nfs/home3
10.22.100.112:/pool2/home                               nfs       202T   11T  192T   6% /expanse/nfs/home2
ps-071.sdsc.edu:/ps-data/community-sw                   nfs       1.0T  300G  725G  30% /expanse/community
10.21.0.21:6789,10.21.11.7:6789,10.21.11.8:6789:/       ceph      1.7T  825G  832G  50% /cm/shared
192.168.43.5:6789,192.168.43.6:6789:/                   ceph      3.5P  344G  3.5P   1% /expanse/ceph
10.22.101.123@o2ib:10.22.101.124@o2ib:/expanse/scratch  lustre    9.8P  2.3P  7.6P  24% /expanse/lustre/scratch
10.22.101.123@o2ib:10.22.101.124@o2ib:/expanse/projects lustre    9.8P  2.3P  7.6P  24% /expanse/lustre/projects
10.22.100.113:/pool3/alt1                               nfs       194T  9.1T  185T   5% /expanse/nfs/home1
master:/home                                            nfs       140G   90G   50G  65% /expanse/nfs/mgr1/home
10.22.101.100:/itasser/vol                              nfs        53T   51T  2.6T  96% /expanse/projects/itasser
tmpfs                                                   tmpfs      26G     0   26G   0% /run/user/515496
10.22.100.112:/pool2/home/apike                         nfs       202T   11T  192T   6% /home/apike
10.22.100.112:/pool2/home/fyu9                          nfs       202T   11T  192T   6% /home/fyu9
...
```

```
xdtr108@exp-1-31 ~]$ cd /scratch/xdtr108/job_14729913/
[xdtr108@exp-1-31 job_14729913]$ time -p git clone https://github.com/YoongiKim/CIFAR-10-images.git
Cloning into 'CIFAR-10-images'...
remote: Enumerating objects: 60027, done.
remote: Total 60027 (delta 0), reused 0 (delta 0), pack-reused 60027
Receiving objects: 100% (60027/60027), 19.94 MiB | 4.53 MiB/s, done.
Resolving deltas: 100% (59990/59990), done.
real 6.11
user 0.62
sys 0.83
[xdtr108@exp-1-31 job_14729913]$ ls -lh
total 4.0K
drwxr-xr-x 5 xdtr108 uic157 4.0K Jul 24 12:37 CIFAR-10-images
```

```
zip -r CIFAR-10-images.zip CIFAR-10-images
```

```
[xdtr108@exp-1-31 job_14729913]$ ls -lh
total 78M
drwxr-xr-x 5 xdtr108 uic157 4.0K Jul 24 12:37 CIFAR-10-images
-rw-r--r-- 1 xdtr108 uic157  78M Jul 24 12:40 CIFAR-10-images.zip
```

```
[xdtr108@exp-1-31 job_14729913]$ du -h CIFAR-10-images
20M	CIFAR-10-images/train/truck
20M	CIFAR-10-images/train/deer
20M	CIFAR-10-images/train/frog
20M	CIFAR-10-images/train/bird
20M	CIFAR-10-images/train/ship
20M	CIFAR-10-images/train/automobile
20M	CIFAR-10-images/train/dog
20M	CIFAR-10-images/train/airplane
20M	CIFAR-10-images/train/horse
20M	CIFAR-10-images/train/cat
197M	CIFAR-10-images/train
4.0M	CIFAR-10-images/test/truck
4.0M	CIFAR-10-images/test/deer
4.0M	CIFAR-10-images/test/frog
4.0M	CIFAR-10-images/test/bird
4.0M	CIFAR-10-images/test/ship
4.0M	CIFAR-10-images/test/automobile
4.0M	CIFAR-10-images/test/dog
4.0M	CIFAR-10-images/test/airplane
4.0M	CIFAR-10-images/test/horse
4.0M	CIFAR-10-images/test/cat
40M	CIFAR-10-images/test
22M	CIFAR-10-images/.git/objects/pack
4.0K	CIFAR-10-images/.git/objects/info
22M	CIFAR-10-images/.git/objects
8.0K	CIFAR-10-images/.git/info
4.0K	CIFAR-10-images/.git/branches
60K	CIFAR-10-images/.git/hooks
8.0K	CIFAR-10-images/.git/logs/refs/heads
8.0K	CIFAR-10-images/.git/logs/refs/remotes/origin
12K	CIFAR-10-images/.git/logs/refs/remotes
24K	CIFAR-10-images/.git/logs/refs
32K	CIFAR-10-images/.git/logs
8.0K	CIFAR-10-images/.git/refs/heads
8.0K	CIFAR-10-images/.git/refs/remotes/origin
12K	CIFAR-10-images/.git/refs/remotes
4.0K	CIFAR-10-images/.git/refs/tags
28K	CIFAR-10-images/.git/refs
27M	CIFAR-10-images/.git
263M	CIFAR-10-images
[xdtr108@exp-1-31 job_14729913]$
```

```
rm -r "/scratch/${USER}/job_${SLURM_JOB_ID}/CIFAR-10-images"
```

```
unzip CIFAR-10-images.zip 'CIFAR-10-images/test/dog/*'
```

```
[xdtr108@exp-1-31 job_14729913]$ cp CIFAR-10-images.zip ~/
[xdtr108@exp-1-31 job_14729913]$ cd ~/
[xdtr108@exp-1-31 ~]$ ls -lh
total 373M
drwxr-xr-x 2 xdtr108 uic157   10 Jun  4  2009 cifar-10-batches-py
-rw-r--r-- 1 xdtr108 uic157  78M Jul 24 12:54 CIFAR-10-images.zip
-rw-r--r-- 1 xdtr108 uic157   57 Jul 24 11:39 cifar-10-python.md5
-rw-r--r-- 1 xdtr108 uic157   86 Jul 24 11:51 cifar-10-python.sha256
-rw-r--r-- 1 xdtr108 uic157 163M Jun  4  2009 cifar-10-python.tar.gz
-rw-r--r-- 1 xdtr108 uic157 163M Jul 24 11:47 cifar-10-python.tgz
[xdtr108@exp-1-31 ~]$ exit
exit
[xdtr108@login01 ~]$
```


https://www.nas.nasa.gov/hecc/support/kb/Lustre_Basics_224.html

#

Next - [Going parallel: Lustre basics](LUSTRE.md)
