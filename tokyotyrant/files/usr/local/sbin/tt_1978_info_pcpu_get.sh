#! /bin/sh

echo "pcpu:`ps -e -o pcpu,command | grep -e \"ttserver -port 1978\" | grep -v \"grep\" | awk '{print $1}'`" > /tmp/tt_1978_info_pcpu.log
