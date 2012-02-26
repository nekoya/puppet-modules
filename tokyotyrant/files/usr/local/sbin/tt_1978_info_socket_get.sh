#! /bin/sh

netstat -atnup | grep `ps aux | grep -e "ttserver -port 1978" | grep -v "grep" | awk '{print $2}'`/ttserver | awk '{print $6}' > /tmp/tt_1978_info_socket.log
