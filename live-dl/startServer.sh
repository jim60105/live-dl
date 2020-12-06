#!/bin/bash
find /Auto/ -maxdepth 1 -type f -exec bash {} \;

python -u /usr/src/app/youtube-dl-server.py &

tail -f /dev/null