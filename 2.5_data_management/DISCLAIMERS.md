# Data Management: Or how (not) to handle your data in an HPC environment

- [Before we begin: A few disclaimers](DISCLAIMERS.md)
- [Easy (remote) access: Setting up SSH keys](SSH.md)
- [CIFAR through the tubes: Downloading data from the internet](DOWNLOADING.md)
- [More files, more problems: Advantages and limitations of different filesystems](FILESYSTEMS.md)

## Before we begin: A few disclaimers

### :running: on :penguin:

HPC and advanced CI run on Linux. If you don't believe me, then look no further than the [latest statistics from the TOP500](https://www.top500.org/statistics/list) --- a list of the most powerful supercomputers in the world. As such, this session will use --- *almost exclusively* --- command-line tools and applications commonly found on [Unix-like](https://en.wikipedia.org/wiki/Unix-like) operating systems, such as Linux and macOS. While you will have remote access to a Linux environment on Expanse via the XSEDE training account you were provided for the Summer Institute this week, you may need access to a \*nix environment on your personal computer to complete some of the exercies we'll work through during this session. 

*Recommendation for Windows users*: Install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) on your personal computer.

### Data has a lifecycle. Data management is a lifestyle.

<img src='https://datamanagement.hms.harvard.edu/sites/g/files/mcu941/files/assets/Images/Lifecycle-wheel-2tier.png' width='50%' height='50%'/>

[Image Credit: Harvard Biomedical Data Management](https://datamanagement.hms.harvard.edu)
