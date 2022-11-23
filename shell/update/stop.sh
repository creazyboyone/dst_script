#!/bin/bash

dir=$(cd `dirname $0`; pwd)

echo "1. kill" >> log.log
pkill -9 "dont" >> log.log