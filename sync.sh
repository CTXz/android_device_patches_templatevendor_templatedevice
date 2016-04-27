#!/bin/bash

# Set local path (Bash will do this automatically by using $(dirname $(readlink -f $0)) )
LOCAL_PATH=$(dirname $(readlink -f $0))

# Set  Android source TOP path, (usually 4 directories back from LOCAL_PATH)
TOP=${LOCAL_PATH}/../../../..

echo "Checking if patches have been overwritten by updates"

# Check if patch watermark exists on patched files.
# <PATH TO YOUR PATCHED FILE> could be ${TOP}/system/vold/Utils.cpp
if ! (grep -Fq "THIS FILE HAS BEEN PATCHED" <PATH TO YOUR PATCHED FILE>); then

	# If the file doesn't contain the watermark it must have been replaced. We're backing this file up
	# <PATH TO BACKUP DIR> could be ${TOP}/system/vold
	# <FILENAME> could be Utils.cpp
	mv <PATH TO YOUR PATCHED FILE> <PATH TO BACKUP DIR>/<FILE NAME>.backup

	# Replace originals with patched files again
	# <PATH TO PATCHED FILE IN PATCHER> could be ${LOCAL_PATH}/patched/system/vold/Utils.cpp
	# <PATH TO PATCHED DIR> could be ${TOP}/system/vold/
	cp <PATH TO PATCHED FILE IN PATCHER> <PATH TO PATCHED DIR>/
fi