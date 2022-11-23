#!/bin/bash

dir=$(cd `dirname $0`; pwd)
tmpdir=$dir/over
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "\n\n\n======== [ Start update.sh at $start_time] =========\n" >> $dir/log.log

# 4点关服
currentHour=$(date +%H)
if [ $currentHour -eq 04 ]
then
	# 4 Hours
	echo "Now is $currentHour o'clock" >> log.log
	# get logs
	cat $dir/../logs/master.log | grep "Announcement" | awk '/Leave|Join/' > $tmpdir
	echo "Finish Getting Logs." >> log.log

	a=`cat $tmpdir | wc -l`
	b=`expr $a % 2`

	if [ $b -eq 0 ]
	then
		# No User, Update and Restart
		rm -f $tmpdir
		end_time=$(date "+%Y-%m-%d %H:%M:%S")
		echo "\n======== [ End upstart.sh at $end_time] =========\n\n\n" >> $dir/log.log
		sh $dir/update.sh
	else
		# Have User, cat user to logs
		cat $tmpdir | awk -F] '{print $3}' | tr -d " " > $dir/over1
	fi
else
	echo "Not 4 Hours, Skip!" >> log.log
fi

