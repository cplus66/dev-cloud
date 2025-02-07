#!/bin/bash -xe
# Date: Nov 03, 2020
# Author: cplus.shen
# Description: backup project documents and datasheets

BACKUP_SERVER=cplus@172.17.5.195:/home/backup/snoopy
LOG=log/snoopy_$(date +%F).log

sudo rsync -avL /opt/prjdoc/ ${BACKUP_SERVER}/prjdoc | tee $LOG
sudo rsync -avL /opt/ICs/ ${BACKUP_SERVER}/ICs | tee -a $LOG
sudo rsync -avL /bin/ ${BACKUP_SERVER}/bin | tee -a $LOG
sudo rsync -avL /boot/ ${BACKUP_SERVER}/boot | tee -a $LOG
sudo rsync -avL /etc/ ${BACKUP_SERVER}/etc | tee -a $LOG
sudo rsync -avL /lib/ ${BACKUP_SERVER}/lib | tee -a $LOG
sudo rsync -avL /sbin/ ${BACKUP_SERVER}/sbin | tee -a $LOG
sudo rsync -avL /usr/ ${BACKUP_SERVER}/usr | tee -a $LOG
sudo rsync -avL /var/ ${BACKUP_SERVER}/var | tee -a $LOG
echo "Done" | tee -a $LOG
