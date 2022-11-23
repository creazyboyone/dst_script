#!/bin/bash
# Install Steam and DST

dpkg --add-architecture i386
sudo apt update
sudo apt-get install zip unzip lib32gcc1 screen libsdl2-2.0-0:i386 libcurl4-gnutls-dev:i386
mkdir ~/steamcmd
cd ~/steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +force_install_dir ~/dst +login anonymous +app_update 343050 validate +quit
cp ~/steamcmd/linux32/libstdc++.so.6 ~/dst/bin/lib32/
# reboot