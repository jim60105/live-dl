#!/bin/bash
./live-dl --init
find /Auto/ -maxdepth 1 -type f -exec bash {} \;

python -u /usr/src/app/youtube-dl-server.py

while true; do
  sleep 1000
done