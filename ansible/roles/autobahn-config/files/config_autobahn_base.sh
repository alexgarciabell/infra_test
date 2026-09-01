#!/bin/bash

#Run as root

#Check to see if the Autobahn public keys were already downloaded
if [ -f /etc/ssh/autobahn_ca_keys.pub ]
then
  echo -e "Autobahn Public Keys Already Exist (/etc/ssh/autobahn_ca_keys.pub)";
else
  echo -e "Downloading Autobahn Public Keys";
  wget https://yumrepo.sys.comcast.net/productsecurity/autobahn/ca.pub -O /etc/ssh/autobahn_ca_keys.pub;
  chmod 644 /etc/ssh/autobahn_ca_keys.pub;
fi

#Note: There is a difference in the file name for the Autobahn public key for AWS and CCP, but they are the same contents.
# In CCP it is named autobahn_ca_keys.pub and it seems to be set in the sshd_config for TrustedUserCAKeys as /etc/ssh/autobahn_ca_keys.pub
# In AWS, it is named ca.pub and it seems to be set in the sshd_config for TrustedUserCAKeys as /etc/ssh/ca.pub
# This was probably a miscommunication from their internal groups or something created at distant times.
# For now, we can use the CCP based setup though it is technically unnecessary.

#Set TrustedUserCAKeys for Autobahn public keys if not exist
if grep -q "^TrustedUserCAKeys.*/etc/ssh/autobahn_ca_keys.pub" /etc/ssh/sshd_config;
then
  echo -e "Autobahn Public Key File Already Set In sshd_config";
else
  echo -e "Setting Autobahn Public Key File In sshd_config"
  echo -e "TrustedUserCAKeys /etc/ssh/autobahn_ca_keys.pub" >> /etc/ssh/sshd_config;
fi

#Disable our implementation of TrustedUserCAKeys for what is there (based on CCP CSI)
if grep -q "^TrustedUserCAKeys.*/etc/ssh/ca.pub" /etc/ssh/sshd_config;
then
  echo -e "Commenting Our Autobahn Public Key File Configs In sshd_config"
  sed -i -e 's/^TrustedUserCAKeys.*\/etc\/ssh\/ca.pub/#TrustedUserCAKeys \/etc\/ssh\/ca.pub/g' /etc/ssh/sshd_config;
fi

#Setting up AuthorizedPrincipalsFile for users if not already present. Checking for OpenSSH Match blocks first.
if grep -q -z -P "(?s)Match User.*?AuthorizedPrincipalsFile.*/etc/ssh/authorized_principals/%u.*?Match all" /etc/ssh/sshd_config;
then
  if grep -q "^Match User.*xdeploy,xvpcs,coast" /etc/ssh/sshd_config;
  then
    echo -e "Already Created AuthorizedPrincipalsFile Match User Block For Additional Users";
  else
    echo -e "Setting AuthorizedPrincipalsFile Match User Block In sshd_config"
    echo -e "#BEGIN XVP CS AUTOBAHN MANUAL CONFIG SCRIPT" >> /etc/ssh/sshd_config;
    echo -e "Match User xdeploy,xvpcs,coast" >> /etc/ssh/sshd_config;
    echo -e "AuthorizedPrincipalsFile /etc/ssh/authorized_principals/%u" >> /etc/ssh/sshd_config;
    echo -e "Match all" >> /etc/ssh/sshd_config;
    echo -e "#END XVP CS AUTOBAHN MANUAL CONFIG SCRIPT" >> /etc/ssh/sshd_config;
  fi
else
  if grep -q "^AuthorizedPrincipalsFile.*/etc/ssh/authorized_principals/%u" /etc/ssh/sshd_config;
  then
    echo -e "Already Created AuthorizedPrincipalsFile Global Config";
  else
    echo -e "Setting AuthorizedPrincipalsFile Globally In sshd_config"
    echo -e "#BEGIN XVP CS AUTOBAHN MANUAL CONFIG SCRIPT" >> /etc/ssh/sshd_config;
    echo -e "AuthorizedPrincipalsFile /etc/ssh/authorized_principals/%u" >> /etc/ssh/sshd_config;
    echo -e "#END XVP CS AUTOBAHN MANUAL CONFIG SCRIPT" >> /etc/ssh/sshd_config;
  fi
fi