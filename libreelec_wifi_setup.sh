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
echo "Reults concluded."

HAS_WIFI_ALREADY=`echo "$SERVICES" | grep \*A`
echo "$HAS_WIFI_ALREADY"

echo "Checking if wifi is already connected"

connmanctl agent on

if [ -n "$HAS_WIFI_ALREADY" ]; then
	echo "Already connected to Wifi. Deleting previous config..."
	rm /storage/.cache/connman/*/ -rf
	exit 1
fi

echo "Connecting to new wifi..."
CONNECTION=`echo "$SERVICES" | grep $SSID | head -n 1`
REAL_SSID=`echo "$CONNECTION" | awk '{print $2}'`
SHORT_SSID=`echo "$REAL_SSID" | cut -d '_' -f3`

echo "$CONNECTION"
echo "$REAL_SSID"
echo "$SHORT_SSID"

mkdir -p /storage/.cache/connman/$REAL_SSID
SETTINGS_FILE=/storage/.cache/connman/$REAL_SSID/settings

echo "$SETTINGS_FILE"

echo "[$REAL_SSID]" >> $SETTINGS_FILE
echo "Type=wifi" >> $SETTINGS_FILE
echo "Name=$SSID" >> $SETTINGS_FILE
echo "SSID=$SHORT_SSID" >> $SETTINGS_FILE
echo "Favorite=true" >> $SETTINGS_FILE
echo "AutoConnect=true" >> $SETTINGS_FILE
echo "Passphrase=$PASSWORD" >> $SETTINGS_FILE
echo "IPv4.method=dhcp" >> $SETTINGS_FILE
echo "IPv6.method=off" >> $SETTINGS_FILE
echo "IPv6.privacy=disabled" >> $SETTINGS_FILE
