#!/bin/bash

# SETUP SYSTEM!
#
# FUNCTION: COPIES DIFF FILE TO DIFF DIR
#
# SYNTAX: ./mkdiff.sh "<PATCHED DIR>" <PATCHED FILE NAME>
#
# Ex: ./mkdiff "system/vold" Utils.cpp will create device/patches/yourvendor/yourdevice/diff/Utils.cpp.diff

# Set local path (Bash will do this automatically by using $(dirname $(readlink -f $0)) )
LOCAL_PATH=$(dirname $(readlink -f $0))

# Set  Android source TOP path, (usually 4 directories back from LOCAL_PATH)
TOP=$LOCAL_PATH/../../../..

# Make variable to where diff files should be located just to make things easier
DIFF_DIR=${LOCAL_PATH}/diff

# Check if "diff" dir exists (Inside the patcher directory). If not, create it!
if [ ! -d $DIFF_DIR ]; then
	mkdir $DIFF_DIR
fi

# Make diff file
git diff ${TOP}/$1/$2 > $DIFF_DIR/$2.diff
