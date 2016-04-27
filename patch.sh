#!/bin/bash

# Set local path (Bash will do this automatically by using $(dirname $(readlink -f $0)) )
LOCAL_PATH=$(dirname $(readlink -f $0))

# Set Android source TOP path, (usually 4 directories back from LOCAL_PATH)
TOP=$LOCAL_PATH/../../../..

# make_patch_stamp function
#
# Usage: This function will create a so called patch mark/list in the directory of the patched file. This is so we can avoid conflicts 
# SYNTAX : make_patch_stamp 
function make_patch_stamp
{
	# Echo patch list (.patchlist) to patch dir ($1 = Files, $2 = path/to/patchlist)
	echo "$1" > $2/.patchlist

	# Echo device mark that indicates what device uses patches, replace <YOUR DEVICE NAME> with your device codename
	echo "<YOUR DEVICE NAME>" > $2/.patch-device
}

if [ $(cat ${LOCAL_PATH}/PATCHED) = "0" ]; then

	echo 1 > ${LOCAL_PATH}/PATCHED

	echo "Applying Vold patch!"

		make_patch_stamp 'Utils.cpp Android.mk' ${VOLD_DIR}

	# Move original/untouched/un-patched files to backup dir
	if [ ! -d ${RVRT_VOLD_DIR} ]; then

		mkdir ${RVRT_VOLD_DIR}
		echo "THIS DIR CONTAINS UNTOUCHED/UNPATCHED FILES, DO NOT REMOVE! THIS DIR WILL GET REMOVED AUTOMATICALLY IF NECCESSARY" > ${RVRT_VOLD_DIR}/README
		mv ${VOLD_DIR}/Utils.cpp ${RVRT_VOLD_DIR}/Utils.cpp.backup
		mv ${VOLD_DIR}/Android.mk ${RVRT_VOLD_DIR}/Android.mk.backup
	
	fi

	# Copy patched files to CM source
	cp ${PATCHED_VOLD_DIR}/Utils.cpp ${VOLD_DIR}/
	cp ${PATCHED_VOLD_DIR}/Android.mk ${VOLD_DIR}/

	echo "Applying torch patch!"

	if [ ! -f ${TORCH_DIR}/.patchlist ]; then
		make_patch_stamp 'FlashlightTile.java' ${TORCH_DIR}
	fi

	# Move original/untouched/un-patched files to backup dir
	if [ ! -d ${RVRT_TORCH_DIR} ]; then

		mkdir ${RVRT_TORCH_DIR}
		echo "THIS DIR CONTAINS UNTOUCHED/UNPATCHED FILES, DO NOT REMOVE! THIS DIR WILL GET REMOVED AUTOMATICALLY IF NECCESSARY" > ${RVRT_TORCH_DIR}/README
		mv ${TORCH_DIR}/FlashlightTile.java ${RVRT_TORCH_DIR}/FlashlightTile.java.backup
	
	fi

	# Copy patched files to CM source
	cp ${PATCHED_TORCH_DIR}/FlashlightTile.java ${TORCH_DIR}/

fi