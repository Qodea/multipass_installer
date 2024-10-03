#! /bin/bash

# simple x11 forwarding example.
# 192.168.64.10 is the Docker VM in Multipass.
# 192.168.61.1 is the local machine.
# Disable authentication and enable nework connections in XQuartz.

open /Applications/Utilities/XQuartz.app
xhost "$(multipass ls --format csv | grep docker | cut -d ',' -f 3)"                          # 192.168.64.10
docker run -e DISPLAY="$(ifconfig bridge100 | grep 'inet ' | cut -f 2 -d ' '):0" jess/firefox # 192.168.61.1
