#!/bin/sh
export JAVA_HOME="/opt/java"
export JVM_MEM_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"

startcmd='/opt/wso2/ei/bin/integrator.sh start > /dev/null &'
debugstartcmd='/opt/wso2/ei/bin/integrator.sh -Desb.debug > /dev/null &'
restartcmd='/opt/wso2/ei/bin/integrator.sh restart > /dev/null &'
stopcmd='/opt/wso2/ei/bin/integrator.sh stop > /dev/null &'
#start-analytics-cmd='/opt/wso2/ei/wso2/analytics/bin/wso2server.sh start > /dev/null &'
#restart-analytics-cmd='/opt/wso2/ei/wso2/analytics/bin/wso2server.sh restart > /dev/null &'
#stop-analytics-cmd='/opt/wso2/ei/wso2/analytics/bin/wso2server.sh stop > /dev/null &'
startbusinessprocesscmd='/opt/wso2/ei/wso2/business-process/bin/wso2server.sh start > /dev/null &'
restartbusinessprocesscmd='/opt/wso2/ei/wso2/business-process/bin/wso2server.sh restart > /dev/null &'
stopbusinessprocesscmd='/opt/wso2/ei/wso2/business-process/bin/wso2server.sh stop > /dev/null &'
startbrokercmd='/opt/wso2/ei/wso2/broker/bin/wso2server.sh start > /dev/null &'
restartbrokercmd='/opt/wso2/ei/wso2/broker/bin/wso2server.sh restart > /dev/null &'
stopbrokercmd='/opt/wso2/ei/wso2/broker/bin/wso2server.sh stop > /dev/null &'

case "$1" in
debug)
   echo "Start Debugging WSO2 EI ..."
   su -c "export JVM_MEM_OPTS=\"${JVM_MEM_OPTS}\" && ${debugstartcmd}" wso2
	SERVER=localhost PORT=9443
	while ! timeout 1 bash -c "echo > /dev/tcp/$SERVER/$PORT"
	do
		echo "** Waiting for WSO2 Debugging EI to Start **"
		sleep 30
	done
;;
start)
   echo "Starting WSO2 EI ..."
   su -c "export JVM_MEM_OPTS=\"${JVM_MEM_OPTS}\" && ${startcmd}" wso2
	SERVER=localhost PORT=9443
	while ! timeout 1 bash -c "echo > /dev/tcp/$SERVER/$PORT"
	do
		echo "** Waiting for WSO2 EI to Start **"
		sleep 30
	done
	
	
	#PORT=9444
	#while ! timeout 1 bash -c "echo > /dev/tcp/$SERVER/$PORT"
	#do
	#	echo "** Waiting for WSO2 DAS to Start **"
	#	sleep 30
	#done
	
	su -c "export JVM_MEM_OPTS=\"${JVM_MEM_OPTS}\" && ${startbusinessprocesscmd}" wso2
	PORT=9445
	while ! timeout 1 bash -c "echo > /dev/tcp/$SERVER/$PORT"
	do
		echo "** Waiting for WSO2 BPS to Start **"
		sleep 30
	done
	
	su -c "export JVM_MEM_OPTS=\"${JVM_MEM_OPTS}\" && ${startbrokercmd}" wso2
	PORT=9446
	while ! timeout 1 bash -c "echo > /dev/tcp/$SERVER/$PORT"
	do
		echo "** Waiting for WSO2 MB to Start **"
		sleep 30
	done
;;
restart)
   echo "Re-starting WSO2 EI ..."
   su -c "${restartcmd}" wso2
   su -c "${restartbusinessprocesscmd}" wso2
   su -c "${restartbrokercmd}" wso2
   
;;
stop)
   echo "Stopping WSO2 EI ..."
   su -c "${stopcmd}" wso2
   su -c "${stopbusinessprocesscmd}" wso2
   su -c "${stopbrokercmd}" wso2
   
;;
*)
   echo "Usage: $0 {start|stop|restart}"
exit 1
esac