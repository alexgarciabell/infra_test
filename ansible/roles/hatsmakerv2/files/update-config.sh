#!/bin/bash
exec="/usr/sbin/haproxy"
prog=$(basename $exec)
cp "$1" /etc/$prog/$prog.cfg
STATUS=`systemctl is-active $prog.service`
if [[ ${STATUS} == 'active' ]]; then
  echo -n $"Reloading $prog"
  sudo systemctl reload $prog.service
else
  echo -n $"Service not running....starting $prog"
  sudo systemctl start $prog.service
fi