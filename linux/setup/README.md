# Setup tricks and tips

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