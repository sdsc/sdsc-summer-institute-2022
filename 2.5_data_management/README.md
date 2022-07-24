# Session 2.5 - Data Management: Or how (not) to handle your data in an HPC environment

**Date: Monday, August 1st, 2022**

[Marty Kandes](https://github.com/mkandes), Computational and Data Science Research Specialist, HPC User Services Group, SDSC

Proper data management is essential to make effective use of high-performance computing (HPC) systems and other advanced cyberinfrastructure (CI) resources. This session will cover an overview of filesystems, data compression, archives (tar files), checksums and MD5 digests, downloading data using wget and curl, data transfer and long-term storage solutions.

## Before we begin: A few disclaimers

### :running: on :penguin:

HPC and advanced CI run on Linux. If you don't believe me, then look no further than the [latest statistics from the TOP500](https://www.top500.org/statistics/list) --- a list of the most powerful supercomputers in the world. As such, this session will use --- *almost exclusively* --- command-line tools and applications commonly found on [Unix-like](https://en.wikipedia.org/wiki/Unix-like) operating systems, such as Linux and macOS. While you will have remote access to a Linux environment on Expanse via the XSEDE training account you were provided for the Summer Institute this week, you may need access to a \*nix environment on your personal computer to complete some of the exercies we'll work through during this session. 

*Recommendation for Windows users*: Install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) on your personal computer.

### Data has a lifecycle. Data management is a lifestyle.

<img src='https://datamanagement.hms.harvard.edu/sites/g/files/mcu941/files/assets/Images/Lifecycle-wheel-2tier.png' width='50%' height='50%'/>

[Image Credit: Harvard Biomedical Data Management](https://datamanagement.hms.harvard.edu)

## Easy (remote) access: Setting up SSH keys :key:

SSH, or [Secure SHell](https://en.wikipedia.org/wiki/Secure_Shell), is a cryptographically secure network protocol used to administer and communicate with remote computer systems distributed over an unsecured network like the public internet. Based on a [client–server](https://en.wikipedia.org/wiki/Client%E2%80%93server_model) architecture, the protocol supports several different methods of [authentication](https://en.wikipedia.org/wiki/Authentication) to establish trust between client and server and uses strong encryption to protect the data they exhange. The most popular application of SSH is logging into and executing commands on a remote machine like Expanse from your personal computer.

In general, password-based authentication is the default authentication mechanism used to establish trust and open an SSH connection between a client and server. This is true of Expanse. However, SSH supports 

Today, many systems also require two-factor authentication.

- https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04
- https://docs.digitalocean.com/products/droplets/how-to/connect-with-ssh/putty/
- https://www.appviewx.com/education-center/ssh-authentication-methods
- https://www.golinuxcloud.com/openssh-authentication-methods-sshd-config/
- https://bytexd.com/ssh-authentication-methods/

### Step 1 - Generate an SSH key pair (with a passphrase) on your personal computer

```
ssh-keygen -t rsa -b 4096 -a 128 -f ~/.ssh/sdsc-si22
```

```
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
```

```
Enter same passphrase again:
```

```
Your identification has been saved in /home/your_local_username/.ssh/sdsc-si22
Your public key has been saved in /home/your_local_username/.ssh/sdsc-si22.pub
The key fingerprint is:
SHA256:doNjZ99n+cFG7DBeMtBIdDroNkQF7C70Rd9yxysgCH4 myour_local_username@your_local_hostname
The key's randomart image is:
+---[RSA 4096]----+
|        .o++ .   |
|     .  ..o.=    |
|    . . oo.=.... |
|     . Eo+ ooo.oo|
|      o S+B .=o+o|
|       +.B.o.oX..|
|        .   ..o*o|
|              .oo|
|                .|
+----[SHA256]-----+
```

```
Generating public/private rsa key pair.
/home/your_local_username/.ssh/sdsc-si22 already exists.
Overwrite (y/n)? n
```

```
$ ls ~/.ssh
config  id_rsa  id_rsa.pub  known_hosts  sdsc-si22  sdsc-si22.pub
```

### Step 2 - Copy your public SSH key to Expanse

```
ssh-copy-id -i ~/.ssh/sdsc-si22 xdtr#@login.expanse.sdsc.edu
```

```
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/your_local_username/.ssh/sdsc-si22.pub"
The authenticity of host 'login.expanse.sdsc.edu (198.202.100.14)' can't be established.
ED25519 key fingerprint is SHA256:L2aPmUWNAwHOBbYNYX/E0P/hPIoyJzq9Wt6g/PFDjJ8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
```

```
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
Password:
```

```
Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'xdtr#@login.expanse.sdsc.edu'"
and check to make sure that only the key(s) you wanted were added.
```

```
Verification code:
```

### Step 3 - Login to Expanse using your SSH keys

```
ssh -i ~/.ssh/sdsc-si22 xdtr#@login.expanse.sdsc.edu
```

```
Welcome to Bright release         9.0

                                                         Based on Rocky Linux 8
                                                                    ID: #000002

--------------------------------------------------------------------------------

                                 WELCOME TO
                  _______  __ ____  ___    _   _______ ______
                 / ____/ |/ // __ \/   |  / | / / ___// ____/
                / __/  |   // /_/ / /| | /  |/ /\__ \/ __/
               / /___ /   |/ ____/ ___ |/ /|  /___/ / /___
              /_____//_/|_/_/   /_/  |_/_/ |_//____/_____/

--------------------------------------------------------------------------------

Use the following commands to adjust your environment:

'module avail'            - show available modules
'module add <module>'     - adds a module to your environment for this session
'module initadd <module>' - configure module to be loaded at every login

-------------------------------------------------------------------------------
Last login: Fri Jul 22 07:09:42 2022 from 208.58.214.56
[xdtr###@login01 ~]$
```

```
$ ssh-add -l
4096 SHA256:doNjZ99n+cFG7DBeMtBIdDroNkQF7C70Rd9yxysgCH4 your_local_username@your_local_hostname (RSA)
```

```
$ cat ~/.ssh/sdsc-si22.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjZ/DRrsFmb6GOBrxBo+QuFpN4r2lf8ZnXxe1YZUR/jo210Vu2IAbjg0Uj4TVMGg8YdqV11RUGIuoMt4qRsbh9xArt2pabgaAdirVELe8ieOTii0V58uq48fku8Kvpi0lIyfRX/6YO+65oIUexdiLrNyDx2NkRefwsDUVAa3tSZZsTzOMqFKjxCVtMxZ5oBjrSra3Ns2dvSld77Nf1aRZ1ls42OXjsqne2BavtHr/rvMbTIAZKbDeaK60vxfX4EpkOGvG1RqDEWIL3RBjQIS+77fNsB56Df+zqz509duSi81YgeZC5UA9UOVhceBW9hk8UwL8uWPwN+wmUOxVdvlvwEAMHv1J/kDANLLYMNDmy9TcCrH0LYISGe70BdQwSZrXTO5UzrgrXtfGdNSp9Jh468s2qv1ufcCs5xFUgIT8t1dUuBUZNt1Lv3oFUvKVmBZK5hTDehiKj2KBw+X/ADa/d1Xb3ohtQdOQv5Vi/rKRnwTAkkq7a2i5QxLw66GBmmS9tC9fEGqoeuTdps2et5tZWszzze/8LYs3S+3pTOH3eyZEL0WFntxOj5A7L8CqnBbKbMwCiGyhinnt8+Q5JkU6NLMOCf6f5i/CJvY0dhFX7WIikgqJJfIhqUeZ1KWhNNmuIb5bTKq64MAA7fcMagIVm07GVyDDPjE+oTwBUD8tLpQ== your_local_username@your_local_hostname
```

```
[xdtr###@login01 ~]$ cat ~/.ssh/authorized_keys 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjZ/DRrsFmb6GOBrxBo+QuFpN4r2lf8ZnXxe1YZUR/jo210Vu2IAbjg0Uj4TVMGg8YdqV11RUGIuoMt4qRsbh9xArt2pabgaAdirVELe8ieOTii0V58uq48fku8Kvpi0lIyfRX/6YO+65oIUexdiLrNyDx2NkRefwsDUVAa3tSZZsTzOMqFKjxCVtMxZ5oBjrSra3Ns2dvSld77Nf1aRZ1ls42OXjsqne2BavtHr/rvMbTIAZKbDeaK60vxfX4EpkOGvG1RqDEWIL3RBjQIS+77fNsB56Df+zqz509duSi81YgeZC5UA9UOVhceBW9hk8UwL8uWPwN+wmUOxVdvlvwEAMHv1J/kDANLLYMNDmy9TcCrH0LYISGe70BdQwSZrXTO5UzrgrXtfGdNSp9Jh468s2qv1ufcCs5xFUgIT8t1dUuBUZNt1Lv3oFUvKVmBZK5hTDehiKj2KBw+X/ADa/d1Xb3ohtQdOQv5Vi/rKRnwTAkkq7a2i5QxLw66GBmmS9tC9fEGqoeuTdps2et5tZWszzze/8LYs3S+3pTOH3eyZEL0WFntxOj5A7L8CqnBbKbMwCiGyhinnt8+Q5JkU6NLMOCf6f5i/CJvY0dhFX7WIikgqJJfIhqUeZ1KWhNNmuIb5bTKq64MAA7fcMagIVm07GVyDDPjE+oTwBUD8tLpQ== your_local_username@your_local_hostname
```

```
[xdtr###@login02 ~]$ ssh-keygen -l -f ~/.ssh/authorized_keys 
4096 SHA256:doNjZ99n+cFG7DBeMtBIdDroNkQF7C70Rd9yxysgCH4 your_local_username@your_local_hostname (RSA)
```

### Step 4 - Simplify things by creating a local SSH configuration file

```
$ touch ~/.ssh/config
```

```
$ chmod u+rw ~/.ssh/config
$ chmod go-rwx ~/.ssh/config
$ ls -lh ~/.ssh/config 
-rw------- 1 your_local_username your_local_groupname 398 Jun 27 05:33 /home/your_local_username/.ssh/config
```

```
Host expanse
Hostname login.expanse.sdsc.edu
User xdtr###
IdentityFile ~/.ssh/sdsc-si22
```

```
$ ssh expanse
```



## CIFAR through the tubes: Downloading data from the internet [:notes:](https://www.youtube.com/watch?v=_cZC67wXUTs)

[CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html)

```
$ ssh expanse
```

```
wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
```

```
--2022-07-24 11:32:04--  https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
Resolving www.cs.toronto.edu (www.cs.toronto.edu)... 128.100.3.30
Connecting to www.cs.toronto.edu (www.cs.toronto.edu)|128.100.3.30|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 170498071 (163M) [application/x-gzip]
Saving to: ‘cifar-10-python.tar.gz’

cifar-10-python.tar 100%[===================>] 162.60M  33.4MB/s    in 5.4s    

2022-07-24 11:32:10 (30.1 MB/s) - ‘cifar-10-python.tar.gz’ saved [170498071/170498071]
```

```
[xdtr###@login02 ~]$ ls -lh
total 163M
-rw-r--r-- 1 xdtr### abc### 163M Jun  4  2009 cifar-10-python.tar.gz
```

```
tar -xf cifar-10-python.tar.gz
```

```
[xdtr###@login02 ~]$ ls -lh
total 163M
drwxr-xr-x 2 xdtr### abc###   10 Jun  4  2009 cifar-10-batches-py
-rw-r--r-- 1 xdtr### abc### 163M Jun  4  2009 cifar-10-python.tar.gz
```

```
[xdtr#@login02 ~]$ ls -lh cifar-10-batches-py/
total 177M
-rw-r--r-- 1 xdtr### abc### 158 Mar 30  2009 batches.meta
-rw-r--r-- 1 xdtr### abc### 30M Mar 30  2009 data_batch_1
-rw-r--r-- 1 xdtr### abc### 30M Mar 30  2009 data_batch_2
-rw-r--r-- 1 xdtr### abc### 30M Mar 30  2009 data_batch_3
-rw-r--r-- 1 xdtr### abc### 30M Mar 30  2009 data_batch_4
-rw-r--r-- 1 xdtr### abc### 30M Mar 30  2009 data_batch_5
-rw-r--r-- 1 xdtr### abc###  88 Jun  4  2009 readme.html
-rw-r--r-- 1 xdtr### abc### 30M Mar 30  2009 test_batch
```

```
md5sum cifar-10-python.tar.gz
```

```
c58f30108f718f92721af3b95e74349a  cifar-10-python.tar.gz
```

```
md5sum cifar-10-python.tar.gz > cifar-10-python.md5
```

```
[xdtr###@login02 ~]$ ls -lh
total 163M
drwxr-xr-x 2 xdtr### abc###   10 Jun  4  2009 cifar-10-batches-py
-rw-r--r-- 1 xdtr### abc###   57 Jul 24 11:39 cifar-10-python.md5
-rw-r--r-- 1 xdtr### abc### 163M Jun  4  2009 cifar-10-python.tar.gz
```

```
[xdtr###@login02 ~]$ md5sum -c cifar-10-python.md5 
cifar-10-python.tar.gz: OK
```

```
curl https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz -o cifar-10-python.tgz
```

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  162M  100  162M    0     0  28.1M      0  0:00:05  0:00:05 --:--:-- 33.3M
```

```
[xdtr###@login02 ~]$ ls -lh
total 326M
drwxr-xr-x 2 xdtr### abc###   10 Jun  4  2009 cifar-10-batches-py
-rw-r--r-- 1 xdtr### abc###   57 Jul 24 11:39 cifar-10-python.md5
-rw-r--r-- 1 xdtr### abc### 163M Jun  4  2009 cifar-10-python.tar.gz
-rw-r--r-- 1 xdtr### abc### 163M Jul 24 11:47 cifar-10-python.tgz
```

```
wget https://raw.githubusercontent.com/sdsc/sdsc-summer-institute-2022/main/2.5_data_management/cifar-10-python.sha256
```

```
[xdtr###@login02 ~]$ sha256sum -c cifar-10-python.sha256 
cifar-10-python.tgz: OK
```

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
Updating files: 100% (60001/60001), done.
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

## Data transfer

## Backuping up data
