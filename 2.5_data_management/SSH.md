# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)
- [Going parallel: Lustre basics](LUSTRE.md)
- [Back that data up: Data transfer tools](TRANSFER.md)

## Easy access: Setting up SSH keys :key:

SSH, or [Secure SHell](https://en.wikipedia.org/wiki/Secure_Shell), is a cryptographically secure network protocol used to administer and communicate with remote computer systems distributed over an unsecured network like the public internet. Based on a [client–server](https://en.wikipedia.org/wiki/Client%E2%80%93server_model) architecture, the protocol supports several different methods of [authentication](https://en.wikipedia.org/wiki/Authentication) to establish trust between client and server and uses strong encryption to protect the data they exhange. The most popular application of SSH is logging into and executing commands on a remote machine like Expanse from your personal computer.

<img src='https://upload.wikimedia.org/wikipedia/en/6/65/OpenSSH_logo.png' width='25%' height='25%' />

[Image Credit: OpenSSH | Wikipedia](https://en.wikipedia.org/wiki/OpenSSH)

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

#

- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
