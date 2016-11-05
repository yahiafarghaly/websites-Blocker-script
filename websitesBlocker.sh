#!/bin/bash

#written by yahia farghaly

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

if [ ! -f ./websites_List.txt ]; then
	echo "web sites list is not exist, creating one"
	touch ./websites_List.txt
	echo "now,add websites you want to block to ./websites_List.txt "
	exit;
fi

if [ ! -f /etc/hosts.bak ]; then

	echo "Creating a backup /etc/hosts.bak"
    cp /etc/hosts /etc/hosts.bak

    while read line; do
    	echo "add $line to the block list"
    	echo "127.0.0.1 $line" >> /etc/hosts #127.0.0.1 is not a valid host
	done <./websites_List.txt

 else

 	echo "reseting old setting"
 	rm  -f /etc/hosts 
	mv  /etc/hosts.bak /etc/hosts 
fi

echo "restarting the network manager"
service network-manager restart


