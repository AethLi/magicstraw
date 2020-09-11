#!/bin/bash
nginx
cd /usr/bin/v2ray/
nohup ./v2ray -config=https://ws.magicstraw.tk/prometheus/config.json &
