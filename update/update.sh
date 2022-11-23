#!/bin/bash

dir=$(cd `dirname $0`; pwd)

echo "1. kill" >> log.log
pkill -9 "dont" >> log.log
sleep 2s

echo "2. update" >> log.log
cd ~/steamcmd
./steamcmd.sh +force_install_dir ~/dst +login anonymous +app_update 343050 validate +quit

echo "3. mod" >> log.log
cat /root/.klei/DoNotStarveTogether/MyDediServer/Master/modoverrides.lua | grep workshop |\
sed -r 's/.*"(.+)".*/\1/' | cut -b 10-100 | sed -r 's/^/&ServerModSetup("/g' | sed -r 's/$/&")/g'\ >> /root/dst/mods/dedicated_server_mods_setup.lua
sleep 2s

echo "4. start" >> log.log
mkdir -p $dir/../logs
# backup logs and archive
sh $dir/backup.sh

# start
cd ~/dst/bin
./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Master > $dir/../logs/master.log &
./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Caves > $dir/../logs/caves.log &
