#!/bin/bash

# SETUP SYSTEM!
#
# FUNCTION: INITIALIZES PATCHED DIRECTORY
#
# SYNTAX: ./setup.sh "<original path>" <name of file that we want to patch>
#
# Ex: ./setup.sh "system/vold" Utils.cpp will create device/patches/yourvendor/yourdevice/patched/system/vold/Utils.cpp

# Set local path (Bash will do this automatically by using $(dirname $(readlink -f $0)) )
LOCAL_PATH=$(dirname $(readlink -f $0))

# Set  Android source TOP path, (usually 4 directories back from LOCAL_PATH)
TOP=$LOCAL_PATH/../../../..

# Make variable to where patched files are located just to make things easier
PTCH_DIR=${LOCAL_PATH}/patched

# Check if patched dir exists (Inside the patcher directory). If not, create it!
if [ ! -d ${LOCAL_PATH}/patched ]; then
	mkdir ${PTCH_DIR}
fi

# Creates identical directory to the original one inside the patched.
mkdir -p ${PTCH_DIR}/$1

# Copy original files to patched directory
cp ${TOP}/$1/$2 ${PTCH_DIR}/$1/
