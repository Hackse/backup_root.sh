README

backup_root.sh - Backup of entire linux filesystem

Description:
============
Sometimes you just need a simple backup script so that you can backup (and later restore) your entire linux operating system. In some situations this is inevitable, like when you choose to encrypt your entire existing operating system including your root mountpoint. You might want to backup your plain/unencrypted harddisk, encrypt it and restore its contents to the encrypted mountpoint, or maybe you own a dedicated root-server / web-server and need consistent full backups. 

How it works:
=============
Well, it's really simple. The mountpoint "/" and its subdirectories are archived to a single tar-file which gets compressed on the fly to a tar.gz backupfile. All Fileowners, filemodes and symlinks are preserved. Some directories are skipped on purpose, because backing them up is not necessary.

Skipped directories:
====================
- /dev/                     (Devices)
- /lost+found/              (Corrupted data)
- /media/                   (Mountpoints (external disks, NFS-Servers, ...))
- /mnt/                     (Same as "/media", but obsolete)
- /proc/                    (Kernel runtime)
- /var/cache/apt/archives/  (Temporary downloaded Debian-Linux archives)
- /sys/                     (Virtual device and drivers)
- /tmp/                     (Temporary files)
- /usr/ports/               (Downloaded ports on FreeBSD)

Notes:
======
  - A consistent backup can be created in Single-User Mode
  - Backing up a running operating systems requires that your local databases are stopped
  - Never use a backup-target path which is part of the data to be backed up
  - Sockets are not backed up, as TAR does not archive them and we do not need to back them up

Usage:
======
./backup_root.sh PATH_FOR_BACKUPS

Example:
========
./backup_root.sh /media/my_nfs_server/backups/
Starting example.com's backup at Sat May 17 23:44:15 CEST 2014 ...
tar: Removing leading `/' from member names
tar: /var/spool/postfix/private/virtual: socket ignored
tar: /var/spool/postfix/private/mailman: socket ignored
real	21m23.585s
user	20m14.428s
sys	0m33.290s
example.com's backup ended successfully at Sun May 18 00:05:39 CEST 2014

