#!/bin/bash

agent=$1

key=$(sed -n "/$agent/p" /var/ossec/etc/client.keys)

echo $key
