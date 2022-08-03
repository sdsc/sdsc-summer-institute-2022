# Session 4.1b Advanced Git & Github

You should be already familiar with creating Pull Requests, merging, and rebasing branches

- https://github.com/sdsc/sdsc-summer-institute-2021/tree/main/1.4b_Advanced_Github
- https://github.com/zonca/conversion_tofix
- https://www.youtube.com/playlist?list=PLSO-KmvudTTtQ19g7ATjnIJja2EsC2dQN


## Step 0 - Preparation

Login to Expanse.

```
$ ssh expanse
```

Check the (default) loaded modules.

```
[xdtr108@login01 ~]$ module list

Currently Loaded Modules:
  1) shared       3) slurm/expanse/21.08.8   5) DefaultModules
  2) cpu/0.15.4   4) sdsc/1.0
```

If for whatever reason you don't see the above modules listed, then please reset your environment to the default set of modules.

```
[xdtr108@login01 ~]$ module reset
Resetting modules to system default. Reseting $MODULEPATH back to system default. All extra directories will be removed from $MODULEPATH.
[xdtr108@login01 ~]$
```

Now that your default software environment is set. We'll take a quick look at the [GitHub CLI](https://cli.github.com), which we have installed on Expanse in a module ...

```
[xdtr108@login01 ~]$ module load gh
[xdtr108@login01 ~]$ gh --version
gh version 1.13.1 (2021-07-20)
https://github.com/cli/cli/releases/tag/v1.13.1


A new release of gh is available: 1.13.1 → v2.14.3
https://github.com/cli/cli/releases/tag/v2.14.3
```

... and use today as part of the exercise. With the `gh` module loaded, go ahead and run the following command to being the authentication process with GitHub.

```
[xdtr108@login01 ~]$ gh auth login
? What account do you want to log into?  [Use arrows to move, type to filter]
> GitHub.com
  GitHub Enterprise Server
```

One important change that I would recommend here is that you **add a passphrase** to your SSH keys for additional security. 

```
[xdtr108@login01 ~]$ gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? SSH
? Generate a new SSH key to add to your GitHub account? Yes
? Enter a passphrase for your new SSH key (Optional) *******
```

Then, when you reach the time to enter your one-time code, here is the link to complete the authentication process. 

- https://github.com/login/device

Your final output after completing the GitHub CLI authentication process should look something like what you see here below. 

```
[xdtr108@login01 ~]$ gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? SSH
? Generate a new SSH key to add to your GitHub account? Yes
? Enter a passphrase for your new SSH key (Optional) *******
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: 210E-C460
- Press Enter to open github.com in your browser... 
! Failed opening a web browser at https://github.com/login/device
  exec: "xdg-open,x-www-browser,www-browser,wslview": executable file not found in $PATH
  Please try entering the URL in your browser manually
✓ Authentication complete. Press Enter to continue...

- gh config set -h github.com git_protocol ssh
✓ Configured git protocol
✓ Uploaded the SSH key to your GitHub account: /home/xdtr108/.ssh/id_ed25519.pub
✓ Logged in as mkandes
```

Once you've completed the authentication process. You can clone the example repository with the following command.

```
gh repo clone zonca/conversion_tofix
```

If you've secured your new SSH keypair with a passphrase, you'll be asked to enter it now. 

```
[xdtr108@login01 ~]$ gh repo clone zonca/conversion_tofix
Cloning into 'conversion_tofix'...
The authenticity of host 'github.com (192.30.255.112)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,192.30.255.112' (ECDSA) to the list of known hosts.
Enter passphrase for key '/home/xdtr108/.ssh/id_ed25519': 
remote: Enumerating objects: 102, done.
remote: Counting objects: 100% (26/26), done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 102 (delta 22), reused 15 (delta 15), pack-reused 76
Receiving objects: 100% (102/102), 19.14 KiB | 2.73 MiB/s, done.
Resolving deltas: 100% (55/55), done.
```

You should now have a copy of the example repository cloned to your HOME directory.

```
[xdtr108@login01 ~]$ ls
conversion_tofix
[xdtr108@login01 ~]$ cd conversion_tofix/
[xdtr108@login01 conversion_tofix]$ ls
conversion.py  LICENSE  README.md  test_conversion.py
[xdtr108@login01 conversion_tofix]$ pwd
/home/xdtr108/conversion_tofix
```

The final step of preparation for this session is to configure your standard `git` configuration variables, namely, your `user.name`, your `user.email`, and your preferred `core.editor`.

```
[xdtr108@login01 conversion_tofix]$ git config --global user.name 'Marty Kandes'
[xdtr108@login01 conversion_tofix]$ git config --global user.email 'mkandes@sdsc.edu'
[xdtr108@login01 conversion_tofix]$ git config --global core.editor 'vim'
[xdtr108@login01 conversion_tofix]$ git config --list
user.name=Marty Kandes
user.email=mkandes@sdsc.edu
core.editor=vim
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=git@github.com:zonca/conversion_tofix.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
```

## Step 1 - Make a test

Once you've configured everything in your HOME directory, you can begin the series of exercies. Start by running the test, which should fail.

```
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
Traceback (most recent call last):
  File "test_conversion.py", line 7, in <module>
    assert conversion.gallons2liters(1) == 3.78541
AssertionError
```

Yup! There is a bug! 

As a quick check, let's roll back the code to the previous commit and re-run the test to see if the bug is still there.

```
git checkout HEAD~1
```

```
[xdtr108@login01 conversion_tofix]$ git checkout HEAD~1
Note: switching to 'HEAD~1'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at c4379b9 module load gh
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
Traceback (most recent call last):
  File "test_conversion.py", line 7, in <module>
    assert conversion.gallons2liters(1) == 3.78541
AssertionError
[xdtr108@login01 conversion_tofix]$
```

Unfortuantely, we find that the bug is still there. So, let's reset the repository to its original state before we proceed with the next step in our debugging process.

```
[xdtr108@login01 conversion_tofix]$ git checkout main
Previous HEAD position was c4379b9 module load gh
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
```

## Step 2 - Find the commit with the bug

You can find the problematic commit reference in Andrea's notes. However, let's try `git bisect` --- it might be helpful for some of us not familiar with this approach. To get started, we need to have reasonable guess as to when the conversion function worked as expected, prior to the bug being introduced. If we review the `git log` or commit history on GitHub, can you find a commit that might be a candidate? For example, what about this commit?

- https://github.com/zonca/conversion_tofix/commit/15d81c7667e288a3d1f934e2e96414fb65af817b

It looks like Google might agree this is using the correct conversion factor.

- https://www.google.com/search?channel=fs&client=ubuntu&q=gallons+to+litres

So, let's proceed assuming that at this commit, the bug had not yet been introduced. Start your bisect ...

```
git bisect start
```

... and then label the current commit the **bad** commit ...

```
git bisect bad
```

... while labeling the one we found in the commit history above the **good** commit ...

```
git bisect good 15d81c7667e288a3d1f934e2e96414fb65af817b
```

You should now find yourself here ...

```
[xdtr108@login01 conversion_tofix]$ git bisect start
[xdtr108@login01 conversion_tofix]$ git bisect bad
[xdtr108@login01 conversion_tofix]$ git bisect good 15d81c7667e288a3d1f934e2e96414fb65af817b
Bisecting: 8 revisions left to test after this (roughly 3 steps)
[1b32d7ba32ddce225444b43ecc8750b754dc58a4] mention git log --graph
[xdtr108@login01 conversion_tofix]
```

Unfortunately, when you re-run the test at the bisected commit, you find it is still bad, so mark it as so ...

```
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
Traceback (most recent call last):
  File "test_conversion.py", line 7, in <module>
    assert conversion.gallons2liters(1) == 3.78541
AssertionError
[xdtr108@login01 conversion_tofix]$ git bisect bad
```

... and again as needed until the test passes ...


```
[xdtr108@login01 conversion_tofix]$ git bisect start
[xdtr108@login01 conversion_tofix]$ git bisect bad
[xdtr108@login01 conversion_tofix]$ git bisect good 15d81c7667e288a3d1f934e2e96414fb65af817b
Bisecting: 8 revisions left to test after this (roughly 3 steps)
[1b32d7ba32ddce225444b43ecc8750b754dc58a4] mention git log --graph
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
Traceback (most recent call last):
  File "test_conversion.py", line 7, in <module>
    assert conversion.gallons2liters(1) == 3.78541
AssertionError
[xdtr108@login01 conversion_tofix]$ git bisect bad
Bisecting: 3 revisions left to test after this (roughly 2 steps)
[9f82cb99df91bab4ed2a36c6e469efc7f9d170ad] how to create pull requests
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
Traceback (most recent call last):
  File "test_conversion.py", line 7, in <module>
    assert conversion.gallons2liters(1) == 3.78541
AssertionError
[xdtr108@login01 conversion_tofix]$ git bisect bad
Bisecting: 1 revision left to test after this (roughly 1 step)
[363a5723a33f65afa189ea643fa04a39327bf0c4] remove extra digits
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
Traceback (most recent call last):
  File "test_conversion.py", line 7, in <module>
    assert conversion.gallons2liters(1) == 3.78541
AssertionError
[xdtr108@login01 conversion_tofix]$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[81c6aecffa27183d4f504648a79a3ce6f6328253] add docstrings
[xdtr108@login01 conversion_tofix]$ python3 test_conversion.py 
[xdtr108@login01 conversion_tofix]$ echo $?
0
[xdtr108@login01 conversion_tofix]$
```

The test passed! Mark the last bisected commit as good and you've found the commit where the bug was introduced.

```
[xdtr108@login01 conversion_tofix]$ git bisect good
363a5723a33f65afa189ea643fa04a39327bf0c4 is the first bad commit
commit 363a5723a33f65afa189ea643fa04a39327bf0c4
Author: Andrea Zonca <code@andreazonca.com>
Date:   Tue Aug 1 08:54:27 2017 -0700

    remove extra digits

 conversion.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
[xdtr108@login01 conversion_tofix]$
```

#

[Marty Kandes](https://github.com/mkandes), Computational & Data Science Research Specialist, HPC User Services Group, SDSC
