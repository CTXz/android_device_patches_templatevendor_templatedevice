
# PATCHER TEMPLATE
# THIS IS ONLY A TEMPLATE FILE! PLEASE ADJUST THE FILE ACCORDING TO YOUR DEVICE/DEVICES!


# Define local path (device/patches/<YOUR VENDOR NAME>/<YOUR DEVICE/PLATFORM CODENAME>)
# Ex:

# LOCAL_PATH := device/patches/samsung/zerolte | Galaxy S6

# LOCAL_PATH := device/patches/sony/kitakami | Sony Kitakami platform (Z5/Z5C/Z5P/Z3+/Z4/Z4 Tablet)

# LOCAL_PATH := device/patches/huawei/angler | Google Huawei Nexus 6p

LOCAL_PATH :=

# Setting device filters using conditions set by device names
#
# Start off by making a condition that checks if the device/devices that requires patches, is being build
# Ex:

# ifeq ($(TARGET_DEVICE), zerolte)

# ifeq ($(TARGET_DEVICE), angler)

# ifeq ($(SOMC_PLATFORM), kitakami) | SOMC_PLATFORM MUST BE SET TO KITAKAMI IN THIS CASE (in device tree SOMC_PLATFORM := kitakami)

# ifeq ($(filter-out ivy karin karin_windy satsuki sumire suzuran,$(TARGET_DEVICE)),) | FILTER OUT MORE THAN ONE DEVICE

ifeq ($(TARGET_DEVICE), <YOUR DEVICE CODENAME>)

# Start patcher using :
$(info $(shell ($(LOCAL_PATH)/patch.sh)))
$(info $(shell ($(LOCAL_PATH)/sync.sh)))

# If you're not building for a device that uses patches it will revert any leftovers unless another device uses the same patches :
else
$(info $(shell ($(LOCAL_PATH)/revert.sh)))

# End condition
endif

# All toghether :

LOCAL_PATH := <YOUR LOCAL PATH>

ifeq ($(TARGET_DEVICE), <YOUR DEVICE CODENAME>)
$(info $(shell ($(LOCAL_PATH)/patch.sh)))
$(info $(shell ($(LOCAL_PATH)/sync.sh)))
else
$(info $(shell ($(LOCAL_PATH)/revert.sh)))
endif
