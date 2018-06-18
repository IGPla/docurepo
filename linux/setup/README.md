# Setup tricks and tips

## Acer Preadtor Helios 300

### Linux flavour install

- Shrink windows partition (to desired space for your linux distribution)
- Make bootable stick with GPT/FAT32 (hint: use Rufus)
- Reset and enter BIOS (press F2 on boot)
- Disable secure boot
- Enable boot manager (F12)
- Save BIOS and reboot
- Introduce your linux stick into your left USB port
- Tap F12 to view boot manager
- Select boot from usb
- Install your linux distribution
- Restart
- Remove usb stick
- Press F2 to enter BIOS again
- Re-enable secure boot
- Under secure boot settings, select your new linux UEFI file to boot (HDDD -> EFI -> ubuntu -> grubx64.efi)
- Select ubuntu as the first one to boot (this will be enable grub to allow you to choose between ubuntu and windows installation)
- Save and restart
- Boot into windows to check that system still works
- Restart
- You can now enter your new linux distribution :D


## Debian

### Drivers

If something does not work in your debian distribution, probably will be due to the lack of official drivers. They are considered "non-free" mostly, so if for example, your wifi is not recognized, the first place to look at is the drivers.

#### Atheros wifi support

If your card comes from Atheros manufacturer, probably your system will try to use the proper firmware. It expects to be in /lib/firmware/athXXXk, usually on /lib/firmware/ath10k

Check your wifi installed card with the following command

```
lspci -nnk | grep -iA2 net
```

After it, you can check in dmesg if something went wrong loading the driver

```
dmesg | grep ath10k
```

If it's the case, you will need only to install the right package. It usually comes from non-free repositories, so lets install them.

1. Open with your editor (for example, vim) the following file

```
vim /etc/apt/sources.list
```

2. Add the following lines

```
deb http://ftp.es.debian.org/debian/ DISTRO main contrib non-free
deb-src http://ftp.es.debian.org/debian/ DISTRO main contrib non-free
```

Replacing DISTRO by your distribution name

3. Update the packages

```
apt-get update
```

4. Install atheros firmware

```
apt-get install firmware-atheros -y
```

5. Reboot, allowing system to reload all firmware

It's done, your wireless card should work now

#### Bumblebee

This is the project that allows laptops with dual setup (integrated intel card plus nvidia card) work "smoothly" in your system. Follow the following steps, and it will work after shutdown:

1. apt-get install bumblebee-nvidia primus
2. adduser $USER bumblebee
3. Edit this file: /etc/bumblebee/xorg.conf.nvidia with the following content (remember to backup each file you edit)

```
Section "ServerLayout"
    Identifier  "Layout0"
    Option      "AutoAddDevices" "false"
    Option      "AutoAddGPU" "false"
    Screen      0  "nvidia"
    Inactive       "intel"
EndSection

Section "Device"
    Identifier  "nvidia"
    Driver      "nvidia"
    VendorName  "NVIDIA Corporation"

#   If the X server does not automatically detect your VGA device,
#   you can manually set it here.
#   To get the BusID prop, run `lspci | egrep 'VGA|3D'` and input the data
#   as you see in the commented example.
#   This Setting may be needed in some platforms with more than one
#   nvidia card, which may confuse the proprietary driver (e.g.,
#   trying to take ownership of the wrong device). Also needed on Ubuntu 13.04.
#   BusID "PCI:01:00:0"

#   Setting ProbeAllGpus to false prevents the new proprietary driver
#   instance spawned to try to control the integrated graphics card,
#   which is already being managed outside bumblebee.
#   This option doesn't hurt and it is required on platforms running
#   more than one nvidia graphics card with the proprietary driver.
#   (E.g. Macbook Pro pre-2010 with nVidia 9400M + 9600M GT).
#   If this option is not set, the new Xorg may blacken the screen and
#   render it unusable (unless you have some way to run killall Xorg).
    Option "ProbeAllGpus" "false"

    BusID  "PCI:1:0:0"
    Option "AllowEmptyInitialConfiguration"
    Option "NoLogo" "true"
    Option "UseEDID" "true"
EndSection

Section "Device"
    Identifier     "intel"
    Driver         "dummy"
    BusID          "PCI:0:2:0"
EndSection

Section "Screen"
    Identifier     "nvidia"
    Device         "nvidia"
EndSection
```

4. Edit this file: /etc/X11/xorg.conf.d/xorg.conf with the following content

```
Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "intel"
    Inactive       "nvidia"
EndSection
 
Section "Monitor"
    Identifier     "Monitor0"
    Option         "DPMS"
EndSection
 
Section "Device"
    Identifier     "nvidia"
    Driver         "dummy"
    BusID          "PCI:1:0:0"
EndSection
 
Section "Device"
    Identifier     "intel"
    Driver         "intel"
    Option         "TearFree"    "true"
    Option         "DRI" "3"

    BusID          "PCI:0:2:0"
EndSection
 
Section "Screen"
    Identifier     "nvidia"
    Device         "nvidia"
EndSection
 
Section "Screen"
    Identifier     "intel"
    Device         "intel"
    Monitor        "Monitor0"
EndSection
```

5. Edit this file: /etc/bumblebee/bumblebee.conf with the following content

```
# Configuration file for Bumblebee. Values should **not** be put between quotes

## Server options. Any change made in this section will need a server restart
# to take effect.
[bumblebeed]
# The secondary Xorg server DISPLAY number
VirtualDisplay=:8
# Should the unused Xorg server be kept running? Set this to true if waiting
# for X to be ready is too long and don't need power management at all.
KeepUnusedXServer=false
# The name of the Bumbleblee server group name (GID name)
ServerGroup=bumblebee
# Card power state at exit. Set to false if the card shoud be ON when Bumblebee
# server exits.
TurnCardOffAtExit=false
# The default behavior of '-f' option on optirun. If set to "true", '-f' will
# be ignored.
NoEcoModeOverride=false
# The Driver used by Bumblebee server. If this value is not set (or empty),
# auto-detection is performed. The available drivers are nvidia and nouveau
# (See also the driver-specific sections below)
Driver=nvidia
# Directory with a dummy config file to pass as a -configdir to secondary X
XorgConfDir=/etc/bumblebee/xorg.conf.d

## Client options. Will take effect on the next optirun executed.
[optirun]
# Acceleration/ rendering bridge, possible values are auto, virtualgl and
# primus.
Bridge=auto
# The method used for VirtualGL to transport frames between X servers.
# Possible values are proxy, jpeg, rgb, xv and yuv.
VGLTransport=proxy
# List of paths which are searched for the primus libGL.so.1 when using
# the primus bridge
PrimusLibraryPath=/usr/lib/primus:/usr/lib32/primus
# Should the program run under optirun even if Bumblebee server or nvidia card
# is not available?
AllowFallbackToIGC=false


# Driver-specific settings are grouped under [driver-NAME]. The sections are
# parsed if the Driver setting in [bumblebeed] is set to NAME (or if auto-
# detection resolves to NAME).
# PMMethod: method to use for saving power by disabling the nvidia card, valid
# values are: auto - automatically detect which PM method to use
#         bbswitch - new in BB 3, recommended if available
#       switcheroo - vga_switcheroo method, use at your own risk
#             none - disable PM completely
# https://github.com/Bumblebee-Project/Bumblebee/wiki/Comparison-of-PM-methods

## Section with nvidia driver specific options, only parsed if Driver=nvidia
[driver-nvidia]
# Module name to load, defaults to Driver if empty or unset
KernelDriver=nvidia
PMMethod=bbswitch
# colon-separated path to the nvidia libraries
LibraryPath=/usr/lib64/opengl/nvidia/lib:/usr/lib32/opengl/nvidia/lib:/usr/lib/opengl/nvidia/lib
# comma-separated path of the directory containing nvidia_drv.so and the
# default Xorg modules path
#XorgModulePath=/usr/lib64/opengl/nvidia/lib,/usr/lib64/opengl/nvidia/extensions,/usr/lib64/xorg/modules/drivers,/usr/lib64/xorg/modules
XorgModulePath=/usr/lib64/opengl/nvidia,/usr/lib64/xorg/modules
XorgConfFile=/etc/bumblebee/xorg.conf.nvidia

## Section with nouveau driver specific options, only parsed if Driver=nouveau
[driver-nouveau]
KernelDriver=nouveau
PMMethod=auto
XorgConfFile=/etc/bumblebee/xorg.conf.nouveau
```

Note: each option that provides paths should be adapted to your system. Check the previous configuration on your bumblebee.conf file and copy them from there

6. Create the following script (it will work after restart): nvidia_on.sh 

```
#!/bin/bash
optirun true
intel-virtual-output -f
```

7. Create the following script: nvidia_off.sh

```
#!/bin/bash
rmmod nvidia_drm; rmmod nvidia_modeset; rmmod nvidia; /etc/init.d/bumblebee restart ; cat /proc/acpi/bbswitch 
```

8. Restart
9. After restart, you can run (with superuser rights) the nvidia_on\.sh script, and your second monitor will start working. When you want to turn off it, just cntrl+c your current script and run nvidia_off\.sh to turn off your nvidia card (saving power resources)
