#! /bin/sh

/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_NUM" "socket_num:`cat /tmp/tt_1978_info_socket.log | wc -l`";
/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_ESTABLISHED" "ESTABLISHED:`cat /tmp/tt_1978_info_socket.log | grep \"ESTABLISHED\" | wc -l`";
/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_TIME_WAIT" "TIME_WAIT:`cat /tmp/tt_1978_info_socket.log | grep \"TIME_WAIT\" | wc -l`";
/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_CLOSED" "CLOSED:`cat /tmp/tt_1978_info_socket.log | grep \"CLOSED\" | wc -l`";
/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_CLOSE_WAIT" "CLOSE_WAIT:`cat /tmp/tt_1978_info_socket.log | grep \"CLOSE_WAIT\" | wc -l`";
/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_LISTEN" "LISTEN:`cat /tmp/tt_1978_info_socket.log | grep \"LISTEN\" | wc -l`";
/usr/bin/tcrmgr put -port 1978 127.0.0.1 "tt_1978_info_socket_CLOSING" "CLOSING:`cat /tmp/tt_1978_info_socket.log | grep \"CLOSING\" | wc -l`";
