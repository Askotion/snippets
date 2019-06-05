#!/bin/bash

# Test if the user puts a Argument
if [[ $# -eq 0 ]] ; then
    clear
    echo 'You have to define a key!'
    echo 'Usage: ./add-agent.sh <key> '
    exit 0
fi

key=$1
export VER="3.3.0"


LOG=/root/setup.log

clear

function delay()
{
    sleep 0.2;
}

#
# Description : print out executing progress
# 
CURRENT_PROGRESS=0
function progress()
{
    PARAM_PROGRESS=$1;
    PARAM_STATUS=$2;

    if [ $CURRENT_PROGRESS -le 0 -a $PARAM_PROGRESS -ge 0 ]  ; then echo -ne "[..........................] (0%)  $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 5 -a $PARAM_PROGRESS -ge 5 ]  ; then echo -ne "[#.........................] (5%)  $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 10 -a $PARAM_PROGRESS -ge 10 ]; then echo -ne "[##........................] (10%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 15 -a $PARAM_PROGRESS -ge 15 ]; then echo -ne "[###.......................] (15%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 20 -a $PARAM_PROGRESS -ge 20 ]; then echo -ne "[####......................] (20%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 25 -a $PARAM_PROGRESS -ge 25 ]; then echo -ne "[#####.....................] (25%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 30 -a $PARAM_PROGRESS -ge 30 ]; then echo -ne "[######....................] (30%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 35 -a $PARAM_PROGRESS -ge 35 ]; then echo -ne "[#######...................] (35%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 40 -a $PARAM_PROGRESS -ge 40 ]; then echo -ne "[########..................] (40%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 45 -a $PARAM_PROGRESS -ge 45 ]; then echo -ne "[#########.................] (45%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 50 -a $PARAM_PROGRESS -ge 50 ]; then echo -ne "[##########................] (50%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 55 -a $PARAM_PROGRESS -ge 55 ]; then echo -ne "[###########...............] (55%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 60 -a $PARAM_PROGRESS -ge 60 ]; then echo -ne "[############..............] (60%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 65 -a $PARAM_PROGRESS -ge 65 ]; then echo -ne "[#############.............] (65%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 70 -a $PARAM_PROGRESS -ge 70 ]; then echo -ne "[###############...........] (70%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 75 -a $PARAM_PROGRESS -ge 75 ]; then echo -ne "[#################.........] (75%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 80 -a $PARAM_PROGRESS -ge 80 ]; then echo -ne "[####################......] (80%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 85 -a $PARAM_PROGRESS -ge 85 ]; then echo -ne "[#######################...] (90%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 90 -a $PARAM_PROGRESS -ge 90 ]; then echo -ne "[##########################] (100%) $PARAM_PHASE \r" ; delay; fi;
    if [ $CURRENT_PROGRESS -le 100 -a $PARAM_PROGRESS -ge 100 ];then echo -ne 'Done!                                            \n' ; delay; fi;

    CURRENT_PROGRESS=$PARAM_PROGRESS;

}


echo "Tasks are in progress, please wait a few minutes"

progress 10 "Initialize"

progress 15 "Phase 1      "

apt update >> $LOG 2>&1
sleep 1


progress 20 "Phase 2      "
apt -y upgrade >> $LOG 2>&1
sleep 1


progress 30 "Phase 2      "
apt -y dist-upgrade >> $LOG 2>&1
sleep 1


progress 40 "Phase 3      "
apt -y autoremove >> $LOG 2>&1
sleep 2


progress 50 "Phase 4      "
apt install -y wget unzip make gcc build-essential libssl-dev >> $LOG 2>&1
sleep 1


progress 60 "Phase 5      "
wget https://github.com/ossec/ossec-hids/archive/${VER}.tar.gz >> $LOG 2>&1
sleep 1


progress 70
tar -xvzf ${VER}.tar.gz >> $LOG 2>&1
cd ossec-hids-${VER} >> $LOG 2>&1

progress 80
wget https://ftp.pcre.org/pub/pcre/pcre2-10.32.tar.gz >> $LOG 2>&1
tar xzf pcre2-10.32.tar.gz -C src/external >> $LOG 2>&1

progress 90
sudo apt install -y libpcre2-dev zlib1g-dev >> $LOG 2>&1
wget https://raw.githubusercontent.com/Askotion/snippets/master/preloaded-vars.conf -P etc/ >> $LOG 2>&1
sudo PCRE2_SYSTEM=yes ./install.sh >> $LOG 2>&1

progress 100
yes | /var/ossec/bin/manage_agents -i $key
echo "Done!"
