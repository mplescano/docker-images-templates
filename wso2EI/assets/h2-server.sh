#!/bin/sh
export JAVA_HOME="/opt/java"
export JVM_MEM_OPTS="-Xms512m -Xmx512m -XX:PermSize=256m -XX:MaxPermSize=256m"

starth2='/opt/java/bin/java -cp /opt/wso2/h2/lib/h2*.jar org.h2.tools.Server -tcp -tcpAllowOthers > /dev/null &'
stoph2='/opt/java/bin/java -cp /opt/wso2/h2/lib/h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:9092 > /dev/null &'

case "$1" in
start)
   echo "Starting H2 Server ..."
   su -c "${starth2}" wso2
;;
restart)
   echo "Re-starting H2 Server ..."
   su -c "${stoph2}" wso2
   su -c "${starth2}" wso2
;;
stop)
   echo "Stopping H2 Server ..."
   su -c "${stoph2}" wso2
;;
*)
   echo "Usage: $0 {start|stop|restart}"
exit 1
esac