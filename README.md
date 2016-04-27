# Patcher template

I've designed an alternate patcher to avoid problems that i've encountered while using the git diff patcher. This patcher allows for extremely flexible patching and simple reverting. However because this patcher is rather complex, it must be adjusted to everyones device/devices. This repository is exactly for that by providing a template and a hopefully understandable small documentary to every developer who's willing to use this patcher.

# Before you start

We're expecting you to know the following things already:

- How to use Linux
- How to use the Linux shell
- How to write bash

# IMPORTANT NOTE

EACH AND EVERY PATCHED FILE MUST BEGIN WITH THE FOLLOWING WATERMARK ON TOP OF IT AS A COMMENT

```
THIS FILE HAS BEEN PATCHED
```

Usually I make them like this

```
/*=====================================================================*/
/* WARNING! THIS FILE HAS BEEN PATCHED BY THE <DEVICENAME> PATCHER !!! */
/*=====================================================================*/
```

# How to adjust to my device

I've added comments to all scripts which should make adjusting more understandable

# Dirs/Files

Directories

- Diffs | Directory that will contain all visible git diffs of patched files. This is not required but makes the patches easier visible
- patched | This directory will only appear once the setup script has been used. It is responsible to hold all patched files that will replace the original ones

Files

- Android.mk | Gets included on build and tells what script to run and checks the device name. MUST BE ADJUSTED TO DEVICE !
- patch.sh | Main patcher script responsible for replacing original with patched files. MUST BE ADJUSTED TO DEVICE!
- PATCHED | Default contains 0. It is responsible to tell wether patches have been applied or not. Learn more by looking at the file.
- revert.sh | Reverts patches if necessary. MUST BE ADJUSTED TO DEVICE!
- setup.sh | Responsible for setting the patched directory. To use it, please take a look in the syntax help which is located inside the file.
- sync.sh | Checks if patched files have been overwritten by an updated one. It will backup the updated one and re-apply the patched one. MUST BE ADJUSTED TO DEVICE.

# Examples how to adjust this patcher
Will come soon!