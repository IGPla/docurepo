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
