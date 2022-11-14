#!/bin/bash

dir=$(cd `dirname $0`; pwd)
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "\n\n\n======== [ Start upstart.sh at $start_time] =========\n" >> log.log

# 4点关服
currentHour=$(date +%H)
if [ $currentHour -eq 04 ]
then
	# 4 Hours
	echo "Now is $currentHour o'clock" >> log.log
	# get logs
	cat $dir/../logs/master.log | grep "Announcement" | awk '/Leave|Join/' > $dir/../logs/over
	echo "Finish Getting Logs, Go to python! Wait 2s" >> log.log
	sleep 2s

	# if file exist
	test -e $dir/user
	if [ $? -eq 0 ]
	then
	# Python ok
		if [ `cat $dir/user | wc -l` -eq 0 ]
		then
			# No User, Update and Restart
			rm -f $dir/user
			sh $dir/update.sh
		else
			# Have User, cat user to logs
			cat $dir/user > ?
		fi
	else
		# File no exist, cause Python error.
		echo "File no exist, cause Python error." >> log.log
	fi
else
	echo "Not 4 Hours, Skip!" >> log.log
fi

end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "\n======== [ End upstart.sh at $end_time] =========\n\n\n" >> log.log
