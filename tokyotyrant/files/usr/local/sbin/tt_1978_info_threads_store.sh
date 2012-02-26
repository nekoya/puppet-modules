#! /bin/sh

/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_threads" "`cat /tmp/tt_1978_info_threads.log`";
