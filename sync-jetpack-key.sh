#!/bin/bash -xe

LIST="
jetpack-0
jetpack-1
jetpack-2
jetpack-3
jetpack-4
jetpack-5-ubu22
jetpack-6-ubu22
jetpack-7-ubu22
jetpack-8-ubu22
jetpack-9-ubu22
jetpack-10-ubu22
"

for i in $LIST; do
  scp ~/.ssh/id_rsa_bitbucket $i:.ssh/
  ssh $i "sudo cat /root/.ssh/id_rsa"
  ssh $i "sudo cp /home/ubuntu/.ssh/id_rsa_bitbucket /root/.ssh/id_rsa"
  ssh $i "sudo cat /root/.ssh/id_rsa"
done
