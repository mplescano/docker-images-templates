#! /bin/sh
export JAVA_HOME="/opt/java"
 
startcmd='/opt/wso2/esb/bin/wso2server.sh start > /dev/null &'
restartcmd='/opt/wso2/esb/bin/wso2server.sh restart > /dev/null &'
stopcmd='/opt/wso2/esb/bin/wso2server.sh stop > /dev/null &'
 
case "$1" in
start)
   echo "Starting WSO2 ESB ..."
   su -c "${startcmd}" wso2
	SERVER=localhost PORT=9443
	while ! timeout 1 bash -c "echo > /dev/tcp/$SERVER/$PORT"
	do
		echo "** Waiting for WSO2 esb to Start **"
		sleep 30
	done
;;
restart)
   echo "Re-starting WSO2 ESB ..."
   su -c "${restartcmd}" wso2
;;
stop)
   echo "Stopping WSO2 ESB ..."
   su -c "${stopcmd}" wso2
;;
*)
   echo "Usage: $0 {start|stop|restart}"
exit 1
esac