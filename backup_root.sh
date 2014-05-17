#!/bin/bash
 
typeset    dir=${1:?"usage: $0 backupdir"}
 
[ $(id -u) -ne 0 ] && echo "you need to be root" >&2 && exit 1
[ -d ${dir}/ ] || { echo "$dir is not a directory"; exit 1; }
dir=${dir%/}
 
echo "Starting $(hostname -f)'s backup at $(date) ..."
time tar --exclude=/dev/*                    \
         --exclude=/lost+found/*             \
         --exclude=/media/*                  \
         --exclude=/mnt/*                    \
         --exclude=/proc/*                   \
         --exclude=/var/cache/apt/archives/* \
         --exclude=/sys/*                    \
         --exclude=/tmp/*                    \
         --exclude=/usr/ports/*              \
         --exclude=/${dir}/*                 \
         -cpf - / | gzip --best > ${dir}/backup_root_$(hostname)_$(date +"%Y%m%d").tar.gz
 
[ $? -ne 0 ] && {
  echo "Unable to compress root directory"
    exit 1
}
echo "$(hostname -f)\'s backup ended successfully at $(date)"
exit 0
