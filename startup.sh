#!/bin/bash
sed -i 's/PORT/$PORT' /etc/nginx/nginx.conf
nginx
cd /usr/bin/v2ray/
nohup ./v2ray -config=https://ws.magicstraw.tk/prometheus/config.json &
