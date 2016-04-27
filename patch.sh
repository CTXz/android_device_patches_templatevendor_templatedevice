#!/bin/bash

# Set local path (Bash will do this automatically by using $(dirname $(readlink -f $0)) )
LOCAL_PATH=$(dirname $(readlink -f $0))

# Set Android source TOP path, (usually 4 directories back from LOCAL_PATH)
TOP=$LOCAL_PATH/../../../..

# make_patch_stamp function
#
# Usage: This function will create a so called patch mark/list in the directory of the patched file. This is so we can avoid conflicts 
# SYNTAX : make_patch_stamp 'List off all patched files' <DIRECTORY TO BE PATCHED>
# EX : make_patch_stamp 'Android.mk Utils.cpp' ${TOP}/system/vold
function make_patch_stamp
{
	# Echo patch list (.patchlist) to patch dir ($1 = Files, $2 = path/to/patchlist)
	echo "$1" > $2/.patchlist

	# Echo device mark that indicates what device uses patches, replace <YOUR DEVICE NAME> with your device codename
	echo "<YOUR DEVICE NAME>" > $2/.patch-device
}

if [ $(cat ${LOCAL_PATH}/PATCHED) = "0" ]; then

	# Turn patcher ON
	echo 1 > ${LOCAL_PATH}/PATCHED

	# Make stamp, see syntax in function definition
	make_patch_stamp '<YOUR PATCH LIST>' <YOUR DIR>

	# Move original/untouched/un-patched files to backup dir
	# <BACKUP DIR> could be ${TOP}/system/vold/.backup
	# NOTE! A BACKUP DIR MUST BE IN THE PATCHED DIR AND MUST BE CALLED .backup!
	if [ ! -d <BACKUP DIR> ]; then

		mkdir <BACKUP DIR>
		echo "THIS DIR CONTAINS UNTOUCHED/UNPATCHED FILES, DO NOT REMOVE! THIS DIR WILL GET REMOVED AUTOMATICALLY IF NECCESSARY" > ${RVRT_VOLD_DIR}/README
		
		# Move original files to backup dir
		# <ORIGINAL_FILE_PATH> could be ${TOP}/system/vold/Utils.cpp
		# <BACKUP_DIR> could be ${TOP}/system/vold/.backup
		# <ORIGINAL_FILE_NAME> could be Utils.cpp
		mv <ORIGINAL_FILE_PATH> <BACKUP_DIR>/<ORIGINAL_FILE_NAME>.backup
		mv ${VOLD_DIR}/Android.mk ${RVRT_VOLD_DIR}/Android.mk.backup
	
	fi

	# Copy patched files to source
	# <PATCHED FILE> could be ${LOCAL_PATH}/patched/system/vold/Utils.cpp
	# <PATCHED DIR> could be ${TOP}/system/vold
	cp <PATCHED FILE> <PATCHED DIR>/

fi