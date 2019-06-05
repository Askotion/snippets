#!/bin/bash

if [[ $# -eq 0 ]] ; then
    clear
    echo 'You have to define a agent!'
    echo 'Usage: ./add-agent.sh <agent> <server>'
    exit 0
fi

agent=$1
server=$2

key=$(sed -n "/$agent/p" agents.txt)

ssh root@$server "source <(curl -s https://raw.githubusercontent.com/Askotion/snippets/master/install-ossec.sh) $key"
