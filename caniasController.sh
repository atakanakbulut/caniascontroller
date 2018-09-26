#!/bin/bash

echo "Bilkon Canias Controller you can see avaible commands via help"
if [ "$1" == "help"]
then
echo "help -->Show command list"
echo "restart -->Kill and restart to canias"
echo "kill -->Kill to canias"
echo "about -->About program"
echo "ping -->Ping servers"
fi

HOST=10.30.1.100
PC1=10.30.1.101
PC2=10.30.1.102
CURRENTDATE=`date +%Y-%m-%d`

if [ "$1" == "ping" ]
then
ping $HOST -c 2; echo $? 
ping $PC1 -c 2; echo $?
ping $PC2 -c 1; echo $?
fi

if [ "$1" == "restart" ]
then
ping $HOST -c 1; echo $? > /tmp/host1logs1.txt 2>&1
ping $PC1 -c 1; echo $? > /tmp/host1logs1.txt 2>&1
ping $PC2 -c 1; echo $? > /tmp/host2logs1.txt 2>&1
sleep 3
echo "killing programs"
sshpass -p 'bilkon' bilkon1@10.30.1.101 BilkonKiller.bat > /tmp/host1logs.txt 2>&1
sshpass -p 'bilkon' bilkon2@10.30.1.102 BilkonKiller.bat > /tmp/host2logs.txt 2>&1
sshpass -p 'ias' ias@10.30.1.100 kill_canias.sh > /tmp/caniaslogs.txt 2>&1

echo "starting canias"
sshpass -p 'bilkon' bilkon1@10.30.1.101 BilkonStarter.bat > /tmp/host1logs_"$CURRENTDATE".txt 2>&1
sshpass -p 'bilkon' bilkon2@10.30.1.102 BilkonStarter.bat > /tmp/host2logs_"$CURRENTDATE".txt 2>&1
sshpass -p 'ias' ias@10.30.1.100 canias_boot.sh > /tmp/caniaslogs_"$CURRENTDATE".txt 2>&1
echo "CANIAS RESTARTED"
fi

if [ "$1" == "kill" ]
then
echo "killing programs"
sshpass -p 'bilkon' bilkon1@10.30.1.101 BilkonKiller.bat > /tmp/host1logs.txt 2>&1
sshpass -p 'bilkon' bilkon2@10.30.1.102 BilkonKiller.bat > /tmp/host2logs.txt 2>&1
sshpass -p 'ias' ias@10.30.1.100 kill_canias.sh > /tmp/caniaslogs.txt 2>&1
fi

if [ "$1" == "start" ]
then
echo "starting canias"
sshpass -p 'bilkon' bilkon1@10.30.1.101 BilkonStarter.bat > /tmp/host1logs.txt 2>&1
sshpass -p 'bilkon' bilkon2@10.30.1.102 BilkonStarter.bat > /tmp/host2logs.txt 2>&1
sshpass -p 'ias' ias@10.30.1.100 canias_boot.sh > /tmp/caniaslogs.txt 2>&1
fi











