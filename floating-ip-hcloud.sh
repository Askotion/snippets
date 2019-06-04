#!/bin/bash

if ping -c 1 116.203.5.186 &> /dev/null
then
  echo "Server Online!"
else
  echo "Server was down.. reassigning floating-ip!"
./hcloud floating-ip assign 74917 agent02
  echo "done!"
sleep 5
fi
