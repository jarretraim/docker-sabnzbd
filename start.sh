#! /bin/sh

/usr/bin/sabnzbdplus --daemon --config-file /mnt/config --server :8080
sleep 5

tail -f /mnt/config/logs/sabnzbd.*
