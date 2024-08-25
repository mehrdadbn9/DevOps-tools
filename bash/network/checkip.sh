#!/usr/bin/env bash
#  this script will return public ip addr

MY_IP_ADDR=$(curl -s http://myip.enix.org/REMOTE_ADDR)
if [ "$MY_IP_ADDR" ]; then
  echo "My public IP address is: $MY_IP_ADDR"
else
  echo "Sorry, I could not figure out my public IP address."
  echo "(I use http://myip.enix.org/REMOTE_ADDR/ for that purpose.)"
  exit 1
fi