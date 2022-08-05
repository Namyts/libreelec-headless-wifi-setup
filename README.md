# How to connect to WiFi on LibreElec (Headless)

- Plug the MicroSD into a PC. There are 2 partitions LIBREELEC and STORAGE. If the STORAGE is not visible, try using Ubuntu when plugging in the SD

- Create a wifi_ssid.txt in this folder with the WiFi SSID
- Create a wifi_password.txt in this folder with the WiFi password
- Copy this entire project into the STORAGE partition. This will put the files in the correct places.

- This autostart.sh should run once, which will run the connection script, and then delete itself if successful (so it doesn't run on every boot)

- The script outputs its logs should it not work correctly and require debugging
