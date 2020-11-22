#!/bin/bash

#remove # in below line, change URL channel and location/name log file (if need). Yes, you can add multi channel.
mkdir -p /youtube-dl/logs
nohup /bin/bash /usr/src/app/live-dl https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw &>/youtube-dl/logs/live-dl-tama.$(date +%d%b%y-%H%M%S).log &
