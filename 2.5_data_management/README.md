# Session 2.5 - Data Management: Or how (not) to handle your data in an HPC environment

**Date: Monday, August 1st, 2022**

[Marty Kandes](https://github.com/mkandes), Computational and Data Science Research Specialist, HPC User Services Group, SDSC

Proper data management is essential to make effective use of high-performance computing (HPC) systems and other advanced cyberinfrastructure (CI) resources. This session will cover an overview of filesystems, data compression, archives (tar files), checksums and MD5 digests, downloading data using wget and curl, data transfer and long-term storage solutions.

## Disclaimer: :running: on :penguin:

HPC and advanced CI run on Linux. If you don't believe me, then look no further than the [latest statistics from the TOP500](https://www.top500.org/statistics/list) --- a list of the most powerful supercomputers in the world. As such, this session will use --- *almost exclusively* --- command-line tools and applications commonly found on [\*nix-based](https://en.wikipedia.org/wiki/Unix-like) operating systems, such as Linux, FreeBSD, and macOS.

*Recommendation for Windows users*: Install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) on your personal computer.
