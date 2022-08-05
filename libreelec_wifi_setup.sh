#!/bin/sh

SSID=`cat /storage/wifi_ssid.txt`
PASSWORD=`cat /storage/wifi_password.txt`

echo "$SSID"
echo "$PASSWORD"

connmanctl enable wifi
connmanctl scan wifi

SERVICES=`connmanctl services`
echo "$SERVICES"

HAS_WIFI_ALREADY=`echo "$SERVICES" | grep \*AO`

if [ -z "$HAS_WIFI_ALREADY" ]
then
	rm */ -r
	echo "Already connected to Wifi"
	exit 1
else
	CONNECTION=`echo "$SERVICES" | grep $SSID | head -n 1`
	REAL_SSID=`echo $CONNECTION | | awk '{print $2}'`

	echo "$CONNECTION"
	echo "$REAL_SSID"

	connmanctl connect $REAL_SSID <<!
$PASSWORD
!
fi