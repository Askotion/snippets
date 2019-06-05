#!/bin/bash

IP="1.1.1.1"

if ping -c 1 $IP &> /dev/null
then
  echo "Server Online!"
else
  echo "Server was down.. reassigning floating-ip!"
./hcloud floating-ip assign 74917 agent02
  echo "done!"
sleep 5
fi
