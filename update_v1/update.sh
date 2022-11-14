log_dir='/root/dst_update/ver_update.log'
touch $log_dir
now=`date`
echo "=== [Now : " $now " ] ===" >> $log_dir
echo "" >> $log_dir

new_ver=`/usr/bin/python3 ~/dst_update/getVersion.py`
now_ver=`cat ~/dst/version.txt`
pid_num=`ps -ef | grep "dont" | grep -v grep | wc -l`
update=0
restart=0
if [ $new_ver != $now_ver ] || [ $update -eq 1 ]; then
	restart=1
	echo "[Update !!!]" >> $log_dir
	echo "" >> $log_dir
	echo "Now version: " $now_ver >> $log_dir
	echo "New version: " $new_ver >> $log_dir
	echo "" >> $log_dir
	cd ~/steamcmd
	./steamcmd.sh +force_install_dir ~/dst +login anonymous +app_update 343050 validate +quit
	# mod
	cat /root/.klei/DoNotStarveTogether/MyDediServer/Master/modoverrides.lua | grep workshop |\
        sed -r 's/.*"(.+)".*/\1/' | cut -b 10-100 | sed -r 's/^/&ServerModSetup("/g' | sed -r 's/$/&")/g'\
        >> /root/dst/mods/dedicated_server_mods_setup.lua
fi
if [ $pid_num -lt 2 ] || [ $restart -eq 1 ]; then
        echo "Process num: " $pid_num " < 2, Restart !" >> $log_dir
        cd ~/dst/bin
        echo `pkill -9 "dont"` >> $log_dir
        echo `pkill -9 "dst"` >> $log_dir
        # mod
        cat /root/.klei/DoNotStarveTogether/MyDediServer/Master/modoverrides.lua | grep workshop |\
        sed -r 's/.*"(.+)".*/\1/' | cut -b 10-100 | sed -r 's/^/&ServerModSetup("/g' | sed -r 's/$/&")/g'\
        >> /root/dst/mods/dedicated_server_mods_setup.lua

        sleep 2s
        rm -f ~/dst_log/dst_overworld.log ~/dst_log/dst_caves.log
        sh dst_master.sh > ~/dst_log/dst_overworld.log &
        sh dst_caves.sh > ~/dst_log/dst_caves.log &
fi
exit
