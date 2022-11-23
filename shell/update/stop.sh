#!/bin/bash

dir=$(cd `dirname $0`; pwd)

echo "Stop DST by shell !!!" >> $dir/log.log
pkill -9 "dont" >> log.log