#!/bin/bash

#Run as root

#Set AuthorizedKeysFile for all users if not already present
if grep -q "^AuthorizedKeysFile.*/etc/ssh/authorized_keys/%u" /etc/ssh/sshd_config;
then
  echo -e "AuthorizedKeysFile Already Configured In sshd_config";
else
  echo -e "Setting AuthorizedKeysFile For Autobahn In sshd_config"
  echo -e "#BEGIN XVP CS AUTOBAHN MANUAL CONFIG SCRIPT" >> /etc/ssh/sshd_config;
  echo -e "AuthorizedKeysFile /etc/ssh/authorized_keys/%u" >> /etc/ssh/sshd_config;
  echo -e "#END XVP CS AUTOBAHN MANUAL CONFIG SCRIPT" >> /etc/ssh/sshd_config;
fi

#Commenting user local authorized_keys reference in sshd_config
if grep -q "^AuthorizedKeysFile.*\.ssh/authorized_keys" /etc/ssh/sshd_config;
then
  echo -e "Commenting Out Local authorized_keys Reference In sshd_config";
  sed -i -e 's/^AuthorizedKeysFile.*\.ssh\/authorized_keys/#BEGIN XVP CS AUTOBAHN MANUAL CONFIG SCRIPT\n#AuthorizedKeysFile .ssh\/authorized_keys\n#END XVP CS AUTOBAHN MANUAL CONFIG SCRIPT/g' /etc/ssh/sshd_config;
fi