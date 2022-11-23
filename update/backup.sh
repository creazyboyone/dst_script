#!/bin/bash

dir=$(cd `dirname $0`; pwd)
day=`date +%Y%m%d_%H%M%S`

zipdir=$dir/../zip
mkdir -p $zipdir
cd $zipdir

# logs
zip -r -q -o dst_log_$day.zip $dir/../logs/*
rm -f $dir/../logs/*


# archive
zip -r -q -o dst_$day.zip ~/.klei/DoNotStarveTogether/MyDediServer