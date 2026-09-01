#!/bin/bash

echo -e "Find all users that have an authorized_keys file";

authkeyfiles=(/home/*/.ssh/authorized_keys*)
rootauthkeyfiles=(/root/.ssh/authorized_keys*)

for i in "${authkeyfiles[@]}";
  do
    echo -e "Found: " $i"\n";
    cat $i;
    echo -e "";
  done;

echo -e "---------";

#Clear the authorized_keys files
for i in "${authkeyfiles[@]}";
  do
    echo -e "Clearing: " $i;
    cat /dev/null > $i;
  done;

echo -e "---------";

#Re-checking all found authorized_keys files
for i in "${authkeyfiles[@]}";
  do
    echo -e "Rechecking: " $i"\n";
    cat $i;
    echo -e "";
  done;

echo -e "---------";
echo -e "Checking root's authorized_keys file";

#Checking root's authorized_keys files
for i in "${rootauthkeyfiles[@]}";
  do
    echo -e "Found: " $i"\n";
    cat $i;
    echo -e "";
  done;

echo -e "---------";

#Clearing root's authorized_keys files
for i in "${rootauthkeyfiles[@]}";
  do
    echo -e "Clearing: " $i;
    cat /dev/null > $i;
  done;

echo -e "---------";

#Re-checking root's found authorized_keys files
for i in "${rootauthkeyfiles[@]}";
  do
    echo -e "Rechecking: " $i"\n";
    cat $i;
    echo -e "";
  done;