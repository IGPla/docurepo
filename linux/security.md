# Linux Security and System Hardening

This document aims to define basic and useful practices to harden your linux setup. All examples will be focused on debian-based systems, but they also will be extendable to other linux flavours.

Tip: most of that tools should be run as root, to be aware of all system files

## Chkrootkit

A linux rootkit scanner

### Install

```
apt-get install chkrootkit
```

### Usage

```
chkrootkit
```

### Results

All results will be displayed in screen

## Rkhuner

Tool for scanning backdoors, rootkits and local exploits

### Install

```
apt-get install rkhunter
```

### Config

Add package manager in rkhunter configuration to prevent false positives.

Edit /etc/rkhunter.conf and add the following property (for debian, use the properly package manager for your distro)

```
PKGMGR=DPKG
```

### Usage

```
rkhunter -c
```

### Results

All results will be displayed in screen. For further details, a log is available in /var/log/rkhunter.log

## ClamAV

Antivirus engine

### Install

```
apt-get install clamav
```

### Usage

To update signatures

```
freshclam
```

To run clamav

```
clamscan -r -i DIRECTORY
```

## Lynis

Lynis is a system hardening auditing tool. It automates the audit of a given system and reports which kind of threats can be found in the system.

### Install

The recommended way to install it is just clone the latest version of its git repository

```
cd /usr/local
git clone https://github.com/CISOfy/lynis
```

### Usage

Just call "audit system" function from your lynis base folder

```
lynis audit system
```

To run lynis without pauses 

```
lynis audit system --quick
```

### Results

The results are displayed on screen, during the system scan.
Additional details can be found, after audit system function pass, in /var/log/lynis.log
You can also find all audit discovers in a report file located in /var/log/lynis-report.dat

## Suricata

IDS/IPS software

### Install

```
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
sudo apt-get install suricata 
```

### Configuration

All configuration will lie in /etc/suricata/suricata.yaml

Tip: at least, check that current interface is the desired one (default is eth0)

### Usage

With this installation, suricata will run in background. It can be found as a service

```
service suricata status
```

### Troubleshooting

Somethimes, trying to restart suricata service, pid file appears to be stalled. Just remove it

```
sudo rm /var/run/suricata.pid
```

And restart again

## SELinux

TODO
