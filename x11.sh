#! /bin/bash

# simple x11 forwarding example.
# 192.168.64.10 is the Docker VM in Multipass.
# 192.168.61.1 is the local machine.
# Disable authentication and enable nework connections in XQuartz.

xhost 192.168.64.10
docker run -e DISPLAY=192.168.64.1:0 jess/firefox
