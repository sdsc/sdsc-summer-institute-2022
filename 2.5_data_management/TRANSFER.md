# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)
- [Going parallel: Lustre basics](LUSTRE.md)
- [Back that data up: Data transfer tools](TRANSFER.md)

## Back that data up: Data transfer tools


```
$ scp expanse:~/CIFAR-10-images.zip ./
CIFAR-10-images.zip                           100%   77MB  20.8MB/s   00:03    
$ ls
 CIFAR-10-images.zip   Downloads   Pictures   Templates
 Desktop               Dropbox     Public     Videos
 Documents             Music       snap      'VirtualBox VMs'
$ md5sum CIFAR-10-images.zip 
072722c0adb133f80ce1e96c60439470  CIFAR-10-images.zip
```

```
$ scp -r expanse:~/cifar-10-batches-py/ ./
test_batch                                    100%   30MB  16.4MB/s   00:01    
data_batch_3                                  100%   30MB  23.7MB/s   00:01    
data_batch_4                                  100%   30MB  23.2MB/s   00:01    
readme.html                                   100%   88     1.2KB/s   00:00    
data_batch_1                                  100%   30MB  22.4MB/s   00:01    
data_batch_5                                  100%   30MB  21.3MB/s   00:01    
batches.meta                                  100%  158     2.0KB/s   00:00    
data_batch_2                                  100%   30MB  22.6MB/s   00:01
$ ls
 cifar-10-batches-py   Documents   Music      snap       'VirtualBox VMs'
 CIFAR-10-images.zip   Downloads   Pictures   Templates
 Desktop               Dropbox     Public     Videos
```

```
$ sftp expanse
Connected to expanse.
sftp> pwd
Remote working directory: /home/xdtr108
sftp> lpwd
Local working directory: /home/mkandes
sftp> cd /expanse/lustre/scratch/xdtr108/temp_project/
sftp> ls
CIFAR-10-images.tar.gz    ILSVRC2012_img_val.tar    gene_info.gz              
striped                   
sftp> get gene_info.gz
Fetching /expanse/lustre/scratch/xdtr108/temp_project/gene_info.gz to gene_info.gz
/expanse/lustre/scratch/xdtr108/temp_project/ 100%  791MB  22.5MB/s   00:35    
sftp> put CIFAR-10-images.zip
Uploading CIFAR-10-images.zip to /expanse/lustre/scratch/xdtr108/temp_project/CIFAR-10-images.zip
CIFAR-10-images.zip                           100%   77MB   2.8MB/s   00:27    
sftp> ls
CIFAR-10-images.tar.gz    CIFAR-10-images.zip       ILSVRC2012_img_val.tar    
gene_info.gz              striped                   
sftp> exit
$ ls
 cifar-10-batches-py   Documents   gene_info.gz   Public      Videos
 CIFAR-10-images.zip   Downloads   Music          snap       'VirtualBox VMs'
 Desktop               Dropbox     Pictures       Templates
```



<img src='https://techgenix.com/tgwordpress/wp-content/uploads/2016/12/image32-e1482537824353.jpg' wdith='100%' height='100%' />

[Image Credit: Amazon Web Services](https://aws.amazon.com/snowmobile)
