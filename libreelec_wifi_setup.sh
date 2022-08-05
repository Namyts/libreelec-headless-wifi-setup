#!/bin/sh

echo "Loading SSID and password from the config files..."
SSID=`cat /storage/wifi_ssid.txt`
PASSWORD=`cat /storage/wifi_password.txt`

echo "SSID:"
echo "$SSID"
echo "Password:"
echo "$PASSWORD"

echo "Enabling wifi..."
connmanctl enable wifi
echo "Scanning wifi..."
connmanctl scan wifi

echo "Results:"
SERVICES=`connmanctl services`
echo "$SERVICES"

HAS_WIFI_ALREADY=`echo "$SERVICES" | grep \*AO`
echo "$HAS_WIFI_ALREADY"

if [ -z "$HAS_WIFI_ALREADY" ]
then
	echo "Already connected to Wifi. Deleting previous config..."
	rm /storage/.cache/connman/*/ -rf
	exit 1
else
	echo "Connecting to new wifi..."
	CONNECTION=`echo "$SERVICES" | grep $SSID | head -n 1`
	REAL_SSID=`echo $CONNECTION | | awk '{print $2}'`

	echo "$CONNECTION"
	echo "$REAL_SSID"

	connmanctl connect $REAL_SSID <<!
$PASSWORD
!
fi