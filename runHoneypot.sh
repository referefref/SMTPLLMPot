#!/bin/bash

if [ -z $(which socat) ]; 
then 
  echo "socat is required, attempting install..."
  sudo apt install -y socat
  exit 0
else 
  echo "requirements met, starting"
  socat tcp-l:25,fork system:./smtppot.sh
fi
