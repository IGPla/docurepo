# Burn images

There's an easy way to do it, and it is just use "dd" command

The steps to do it are the following

- Be sure to umount your partition. 
- Apply dd command with your image as input parameter and device as an output parameter

Following is an example (given that sdc1 is the mounted one)

```
umount sdc1
dd bs=4M if=/path/to/your/file.img of=/dev/sdc status=progress conv=fsync 
```
