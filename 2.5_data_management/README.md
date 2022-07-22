# Session 2.5 - Data Management: Or how (not) to handle your data in an HPC environment

**Date: Monday, August 1st, 2022**

[Marty Kandes](https://github.com/mkandes), Computational and Data Science Research Specialist, HPC User Services Group, SDSC

Proper data management is essential to make effective use of high-performance computing (HPC) systems and other advanced cyberinfrastructure (CI) resources. This session will cover an overview of filesystems, data compression, archives (tar files), checksums and MD5 digests, downloading data using wget and curl, data transfer and long-term storage solutions.

## Disclaimer: :running: on :penguin:

HPC and advanced CI run on Linux. If you don't believe me, then look no further than the [latest statistics from the TOP500](https://www.top500.org/statistics/list) --- a list of the most powerful supercomputers in the world. As such, this session will use --- *almost exclusively* --- command-line tools and applications commonly found on [\*nix-based](https://en.wikipedia.org/wiki/Unix-like) operating systems, such as Linux, FreeBSD, and macOS. While you will have remote access to a Linux environment on Expanse via the XSEDE training account you were provided for the Summer Institute this week, you may need access to a \*nix environment on your personal computer to complete some of the exercies we'll work through during this session. 

*Recommendation for Windows users*: Install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) on your personal computer.

## Easy access: Or how to setup SSH keys and your SSH config

Provide instructions on how to setup SSH keys to make logins to XSEDE training accounts simpler during SI22. Use modifided version of Digital Ocean documentation to create this section. Recommend windows users try setting up putty, if necessary. Or simply use Expanse User Portal to access the interactive terminal application --- may not get full experience using only Expanse Portal though. 

- https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04
- https://docs.digitalocean.com/products/droplets/how-to/connect-with-ssh/putty/
