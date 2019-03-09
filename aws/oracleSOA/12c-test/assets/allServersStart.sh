#!/bin/bash

echo "############################"
echo "# All Servers are STARTING #"
echo "############################"
export SOA_DOMAIN_HOME=/u01/app/oracle/user_projects/domains/soa_devdomain

/usr/sbin/startup.sh
#-Dtangosol.coherence.wka=localhost -Dtangosol.coherence.ttl=0 -Dtangosol.coherence.localhost=127.0.0.1
su - oracle -c "export JAVA_OPTIONS='-Djava.security.egd=file:/dev/./urandom' && export TZ='UTC' && nohup ${SOA_DOMAIN_HOME}/bin/startWebLogic.sh > ${SOA_DOMAIN_HOME}/servers/AdminServer/logs/AdminServer.out &"
su - oracle -c "export TZ='UTC' && nohup $SOA_DOMAIN_HOME/bin/startNodeManager.sh > ${SOA_DOMAIN_HOME}/nodemanager/logs/nodemanager.out &"
SERVER=127.0.0.1 PORT=7001
while !(: < /dev/tcp/$SERVER/$PORT) 2>/dev/null
do
    echo "** Waiting for Admin Server to Start **"
    sleep 30
done

su - oracle -c "export JAVA_OPTIONS='-Djava.security.egd=file:/dev/./urandom' && export TZ='UTC' && ${SOA_DOMAIN_HOME}/bin/startManagedWebLogic.sh bam_server1 \"http://\${HOSTNAME}:7001\"  > ${SOA_DOMAIN_HOME}/servers/bam_server1/logs/bam_server1.out &"
SERVER=127.0.0.1 PORT=7005
while !(: < /dev/tcp/$SERVER/$PORT) 2>/dev/null
do
    echo "** Waiting for bam_server1 to Start **"
    sleep 30
done

#su - oracle -c "export JAVA_OPTIONS='-Djava.security.egd=file:/dev/./urandom' && export TZ='UTC' && ${SOA_DOMAIN_HOME}/bin/startManagedWebLogic.sh osb_server1 \"http://\${HOSTNAME}:7001\"  > ${SOA_DOMAIN_HOME}/servers/osb_server1/logs/osb_server1.out &"
#SERVER=127.0.0.1 PORT=7003
#while !(: < /dev/tcp/$SERVER/$PORT) 2>/dev/null
#do
#    echo "** Waiting for osb_server1 to Start **"
#    sleep 30
#done

su - oracle -c "export JAVA_OPTIONS='-Djava.security.egd=file:/dev/./urandom' && export TZ='UTC' && ${SOA_DOMAIN_HOME}/bin/startManagedWebLogic.sh soa_server1 \"http://\${HOSTNAME}:7001\"  > ${SOA_DOMAIN_HOME}/servers/soa_server1/logs/soa_server1.out &"
SERVER=127.0.0.1 PORT=7004
while !(: < /dev/tcp/$SERVER/$PORT) 2>/dev/null
do
    echo "** Waiting for soa_server1 to Start **"
    sleep 30
done

#for JAVA_OPTIONS=-Djava.security.egd=file:/dev/./urandom
#@see http://docs.huihoo.com/oracle/middleware/weblogic/12c/doc.1211/e26593/issues.htm 
#@see http://stackoverflow.com/questions/2327220/oracle-jdbc-intermittent-connection-issue
#servers/bam_server1/logs/bam_server1.log
#su - oracle -c "nohup $SOA_DOMAIN_HOME/bin/stopWebLogic.sh > $SOA_DOMAIN_HOME/servers/AdminServer/logs/AdminServer.out"
#su - oracle -c "export TZ='UTC' && nohup $SOA_DOMAIN_HOME/bin/stopNodeManager.sh > ${SOA_DOMAIN_HOME}/nodemanager/logs/nodemanager.out &"
#su - oracle -c "export TZ='UTC' && ${SOA_DOMAIN_HOME}/bin/stopManagedWebLogic.sh bam_server1 \"http://\${HOSTNAME}:7001\"  > ${SOA_DOMAIN_HOME}/servers/bam_server1/logs/bam_server1.out &"
#${SOA_DOMAIN_HOME}/nodemanager/nodemanager.domains
#Once all the servers are in running state access the consoles.
#1. WebLogic: http://localhost:7001/console
#2. Enterprise Manager: http://localhost:7001/em
#3. BAM http://localhost:9001/OracleBAM