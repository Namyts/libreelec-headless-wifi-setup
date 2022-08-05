#!/bin/sh

SSID=`cat wifi_ssid.txt`
PASSWORD=`cat wifi_password.txt`

echo "$SSID"
echo "$PASSWORD"

connmanctl enable wifi
connmanctl scan wifi

HAS_WIFI_ALREADY=`connmanctl services | grep \*AO`
if [ -z "$HAS_WIFI_ALREADY" ]
then
	rm */ -r
	echo "Already connected to Wifi"
	exit 1
else
	CONNECTION=`connmanctl services | grep $SSID | head -n 1`
	REAL_SSID=`echo $CONNECTION | | awk '{print $2}'`

	connmanctl connect $REAL_SSID <<!
$PASSWORD
!
fi