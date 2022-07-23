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

## Easy (remote) access: Setting up SSH keys

SSH, or [Secure SHell](https://en.wikipedia.org/wiki/Secure_Shell), is a cryptographically secure network protocol used to administer and communicate with remote computer systems distributed over an unsecured network like the public internet. Based on a [client–server](https://en.wikipedia.org/wiki/Client%E2%80%93server_model) architecture, the protocol supports several different methods of [authentication](https://en.wikipedia.org/wiki/Authentication) to establish trust between client and server and uses strong encryption to protect the data they exhange. The most popular SSH application is logging into and executing commands on a remote machine like Expanse from your personal computer.

In general, password-based authentication is the default authentication mechanism used to establish trust and open an SSH connection between a client and server. This is true of Expanse. However, SSH supports 

Today, many systems also require two-factor authentication.

- https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04
- https://docs.digitalocean.com/products/droplets/how-to/connect-with-ssh/putty/
- https://www.appviewx.com/education-center/ssh-authentication-methods
- https://www.golinuxcloud.com/openssh-authentication-methods-sshd-config/
- https://bytexd.com/ssh-authentication-methods/


## CIFAR through the tubes: Downloading data from the internet

## More files, more problems: Advantages and limitations of different filesystems

## Data transfer

## Backuping up data
