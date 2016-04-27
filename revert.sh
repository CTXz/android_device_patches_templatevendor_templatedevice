#!/bin/bash

# Set local path (Bash will do this automatically by using $(dirname $(readlink -f $0)) )
LOCAL_PATH=$(dirname $(readlink -f $0))

# Set  Android source TOP path, (usually 4 directories back from LOCAL_PATH)
TOP=$LOCAL_PATH/../../../..

# Check if PATCHED returns 1 (true). If that's the case it means that patches have been aplied and will start the revert script.
# The revert script will only work if the device ISN'T the patch required device.
if [ $(cat ${LOCAL_PATH}/PATCHED) = "1" ]; then
    
    # Set PATCHED to 0 (OFF) to indicate that the patcher has been disabled/turned off.
	echo 0 > ${LOCAL_PATH}/PATCHED
   
   # Check if your targeted patched directory already contains a patchlist. This is to check for similarities.
   # Replace <YOUR PATCHED DIR> with the directory that contains patched file
   # Ex <YOUR PATCHED DIR> could be frameworks/av or system/vold etc.
   if [ -f <YOUR PATCHED DIR>/.patchlist ]; then

   		 # Check .patchlist for similarities with other patchers. Replace <YOUR PATCHED FILE> with the name of your patched file and 
   		 # <YOUR PATCHED DIR> with the directory that contains patched file.
   		 #
  		 # Ex. 
  		 # <YOUR PATCHED FILE> could be audio.cpp or test.java or phone.h etc.
  		 # <YOUR PATCHED DIR> could be frameworks/av or system/vold etc.
   		if (grep -Fq "<YOUR PATCHED FILE>" <YOUR PATCHED DIR>/.patchlist); then

   			# Check .patch-device if patches are for your device, else it will keep them 
   			# and let them be replaced by the other devices patches.
   			# Replace <YOUR DEVICE CODENAME> with your device codename
   			# Ex. <YOUR DEVICE CODENAME> could be zerolte or gts28wifi or kitakami or degaswifi etc.
   			if [ $(cat <YOUR PATCHED DIR>/.patch-device) = "<YOUR DEVICE CODENAME>" ]; then
   			
   				# Restore original files by using the temporary backup directory
				mv <PATH TO YOUR BACKUP DIR OF PATCHED DIR>/<NAME OF YOUR PATCHEDFILE>.backup <PATH TO YOUR ORIGINAL DIR>/<NAME OF YOUR ORIGINAL FILE>
			
				# Once we're done reverting we will clean up the mess of the patcher.
				# NOTE: IF YOU HAVE MORE THAN ONE PATCHED FILE IN ONE DIRECTORY, MOVE THE NEXT 3 ORDERS ONTO THE LAST CHECKED PATCHLIST GREP
				rm -R <PATH TO YOUR BACKUP DIR OF PATCHED DIR>
				rm <YOUR PATCHED DIR>/.patchlist
				rm <YOUR PATCHED DIR>/.patch-device
			fi
		
		else

			# If there aren't any simillarities we're restoring un-patched files.
			mv <PATH TO YOUR BACKUP DIR OF PATCHED DIR>/<NAME OF YOUR PATCHEDFILE>.backup <PATH TO YOUR ORIGINAL DIR>/<NAME OF YOUR ORIGINAL FILE>

			# Delte backup dir if its empty
			# NOTE: IF YOU HAVE MORE THAN ONE PATCHED FILE IN ONE DIRECTORY, MOVE THE NEXT 3 ORDERS ONTO THE LAST CHECKED PATCHLIST GREP
			if [ ! "$(ls -A ${RVRT_VOLD_DIR})" ]; then
				rm -R <PATH TO YOUR BACKUP DIR OF PATCHED DIR>
			fi

		fi
		
	fi
fi
