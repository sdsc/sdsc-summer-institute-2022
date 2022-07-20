# Preparing for the SDSC Summer Institute 2022

You will get the most out of the SDSC Summer Institute if you prepare prior to the event. By brushing up on your knowledge of Linux and installing all necessary software on your laptop before we start, you’ll be able to focus your attention on the skills and topics that are most relevant to high performance and data intensive computing.

This section contains a set of detailed start-up instructions for setting up your account, connecting to Expanse and configuring your laptop to run the visualization software. Please read the documents and exercises carefully, and complete all necessary steps before event. Feel free to ask questions or if you have any problems with the start-up tasks.


<a name="top">Contents
* [Expanse User Guide](#expanse-guide)
* [HPC Systems Accounts](#accounts)
   * [Logging onto the Expanse Portal](#logon-portal)
   * [Logging onto Expanse HPC Cluster](#logon-expanse)
* [Computer Requirements](#computer-req)
* [Remote access via GitHub, Zoom, and Slack](#remote)
* [Software Requirements](#software)
* [Preparation Activities](#prep-activities)
   * [Basic HPC Skills](#basic-skills)
   * [Launching Jupyter Notebooks](#jup-ntbks)

  
## Expanse User Guide <a name="expanse-guide"></a>
Please read the Expanse user guide and familiarize yourself with the hardware, file systems, batch job submission, compilers and modules. The guide can be found here:
* [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html)

[Back to Top](#top)
<hr>

##  HPC Systems Accounts: <a name="accounts"></a>
* For the CIML Institute, we have created TWO types of **Training** accounts for you: 
  * **(1) XSEDE and Expanse portal ID** (trainXX)
  * **(2) Local Expanse user account** (xdtrXX)
* Note: The two topics below will be covered on the Preparation day (1.2 Accounts, Login, Environment, Running Jobs and Logging into Expanse User Portal).

### Logging onto the Expanse Portal (portal.expanse.sdsc.edu): <a name="logon-portal"></a>
* XSEDE training accounts to access the Expanse portal have already been created for you. Please do not create a new one on your own. See email sent from cwong@sdsc.edu for your XSEDE & Expanse acount with the subject link "SDSC 2022 Summer Institute: Account Set-Up". 
* Use username "train##" and password provided via link sent
* Once you have received your XSEDE and Expanse portal ID information, go to https://portal.expanse.sdsc.edu, to confirm your login.
* For a short (18 min) video on using the Expanse portal, see [here](https://education.sdsc.edu/training/interactive/sdsc_si21/1.3_Expanse_User_Portal/).

### Logging onto Expanse using your "Local Expanse user account" (SSH/terminal): <a name="logon-expanse"></a>
* You will be given an account on the SDSC Expanse computer. Information on the account will be sent to you via email. Please complete the process of activating your account before the institute begins. To log onto the Expase cluster, see these instructions: https://github.com/sdsc-hpc-training-org/hpc-security/blob/master/connecting-to-hpc-systems/connect-to-expanse.md
* Use username "xdtr##" and password provided via link sent

[Back to Top](#top)
<hr>

 ## Computer Requirements: <a name="computer-req"></a>
* After you access your account information, confirm that you can login (SSH) to Expanse using the device you plan to use during the SDSC Summer Institute (laptop, workstation, etc...).  Detailed instructions on connecting to Expanse using SSH can be found [here](https://github.com/sdsc-hpc-training-org/basic_skills/tree/master/connecting-to-hpc-systems).  
* We recommend a second screen for the hands-on sessions. The first to view the presentation, the second for hands-on.
* For visualization tutorial a mouse with scroll wheel is highly recommended (laptop track pads are very difficult to use for 3D navigation).

[Back to Top](#top)
<hr>

##  Remote access via GitHub, Zoom, and Slack <a name="remote"></a>

* For the institute, we will coordinate our remote access using GitHub, Zoom, and Slack.
* When setting up your “display name” on both Zoom & Slack, please use your FIRST name, LAST name, and institution (i.e., Harry Potter (SDSC)).

### Github: <a name="github"></a>
* Training material will be located on the SDSC Summer Institute [GitHub repo](https://github.com/sdsc/sdsc-summer-institute-2022) and one of the Wednesday sessions will require a GitHub account.
* If you do not already have one, you can create a free personal GitHub account [here](https://docs.github.com/en/github/getting-started-with-github/signing-up-for-github/signing-up-for-a-new-github-account).  
* For basic GitHub usage on SDSC systems, see here: https://github.com/sdsc-hpc-training-org/basic_skills/tree/master/using_github

### Zoom:  <a name="zoom"></a>
* You will need to install the latest [Zoom](https://zoom.us/download) client, which is available for Windows, MacOS and Linux. Once installed, you can test your microphone and camera interface with Zoom [here](https://zoom.us/test). You can find more information on Zoom system requirements, including bandwidth requirements [here](https://support.zoom.us/hc/en-us/articles/201362023-System-Requirements-for-PC-Mac-and-Linux).  

Connection details were sent as a calendar invite to all HPC/DS participants. You should have received TWO invites (1) preparation day and (2) instruction days. If you did not receive this as noted, please contact cwong@sdsc.edu.

### Slack:  <a name="slack"></a>
* We will also be using Slack as our main platform for announcements, where participants can communicate and ask for help. Download ([Windows](https://slack.com/downloads/windows), [MacOS](https://slack.com/downloads/mac), or [Linux](https://slack.com/downloads/linux)) and [get started](https://slack.com/help/articles/218080037-Getting-started-for-new-Slack-users). Zoom chat will be disabled. Make sure to turn on your Slack notifications to receive alerts. 
  
**You have access to FOUR channels:**
* **Main Room**: Used for announcements, team-wide conversations, and any questions during sessions. For assistance with your account, go to #help-desk channel 
* **Breakout Room**: Used for instructions occurring in the Zoom “breakout room” during parallel sessions. 
* **Help-desk**: Used to troubleshoot any issues related to account access or login 
* **Introduce-yourself**: With everyone attending virtually, getting the opportunity to introduce each other is hard. Please use this space to introduce yourself, so we can get to know each other.

[Back to Top](#top)

## Software Requirements: <a name="software"></a>
The document below contains a list of software being used at the institute and installation instructions:
* [Software_Requirements](https://github.com/sdsc/sdsc-summer-institute-2022/blob/main/0_Preparation/software_requirements.md)

[Back to Top](#top)
<hr>

## Preparation Activities: <a name="prep-activities"></a>
The Summer Institute is a combination of in-depth lectures and hands-on learning. The following documents will guide you through the necessary steps needed to be prepared to get to work when you arrive at the Institute.

### Basic HPC Skills: <a name="basic-skills">
* [Connecting Securely to SDSC HPC Systems](https://github.com/sdsc-hpc-training-org/hpc-security)
    * WATCH - [Indispensable Security: Tips to Use SDSC's HPC Resources Securely](https://education.sdsc.edu/training/interactive/202007_security_tips/index.php)
* [Basic_Linux_Skills](https://github.com/sdsc-hpc-training-org/basic_skills/tree/master/basic_linux_skills_expanse)
* [Interactive Computing](https://github.com/sdsc-hpc-training-org/basic_skills/tree/master/interactive_computing)
* [Using GitHub on Expanse](https://github.com/sdsc-hpc-training-org/basic_skills/tree/master/using_github)

### Launching Jupyter Notebooks: <a name="jup-ntbks">
* View the presentation: [Running Secure Jupyter Notebooks on Expanse](https://github.com/sdsc/sdsc-summer-institute-2021/blob/main/0_Preparation/MThomas-Running-Secure-Jupyter-Notebooks-on-Expanse.pdf)
* Follow the guide here: [Launching Jupyter Notebooks - SI20 Instructions](https://github.com/sdsc/sdsc-summer-institute-2021/blob/main/0_Preparation/launching_jupyter_notebooks.md)
* Read the full tutorial here: [Notebooks-101 Tutorial](https://hpc-training.sdsc.edu/notebooks-101/)


[Back to Top](#top)
<hr>
