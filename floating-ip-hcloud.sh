#!/bin/bash

while true; do
        if fping -c1 -t2000 $IP &> /dev/null
        then
         sleep 1
        else
          echo "Server was down.. reassigning floating-ip!"
          hcloud floating-ip assign 84894 test2
          echo "done!"
        fi
done
