#!/bin/bash

IP="116.203.82.111"



while true; do
        if ping -c 1 $IP &> /dev/null
        then
          echo "Server online!"
        else
          echo "Server was down.. reassigning floating-ip!"
          hcloud floating-ip assign 84894 test2
          sleep 10
          echo "done!"
        fi
        sleep 1
done
