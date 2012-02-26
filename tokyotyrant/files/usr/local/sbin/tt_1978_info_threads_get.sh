#! /bin/sh

cat /proc/`ps aux | grep -e "ttserver -port 1978" | grep -v "grep" | awk '{print $2}'`/status | grep -e "Threads:" | awk '{print $1 $2}' > /tmp/tt_1978_info_threads.log
