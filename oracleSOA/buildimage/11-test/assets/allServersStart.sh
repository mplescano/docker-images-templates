#!/bin/bash

echo "############################"
echo "# All Servers are STARTING #"
echo "############################"
export SOA_DOMAIN_HOME=/u01/app/oracle/middleware/user_projects/domains/soa_devdomain

/usr/sbin/startup.sh
su - oracle -c "nohup ${SOA_DOMAIN_HOME}/bin/startWebLogic.sh > ${SOA_DOMAIN_HOME}/servers/AdminServer/logs/AdminServer.out &"
#su - oracle -c "nohup $SOA_DOMAIN_HOME/bin/startNodeManager.sh > ${SOA_DOMAIN_HOME}/nodemanager/logs/nodemanager.out &"

SERVER=127.0.0.1 PORT=7001
while !(: < /dev/tcp/$SERVER/$PORT) 2>/dev/null
do
    echo "** Waiting for Admin Server to Start **"
    sleep 30
done

su - oracle -c "${SOA_DOMAIN_HOME}/bin/startManagedWebLogic.sh bam_server1 \"http://\${HOSTNAME}:7001\"  > ${SOA_DOMAIN_HOME}/servers/bam_server1/logs/bam_server1.out &"

#servers/bam_server1/logs/bam_server1.log
#su - oracle -c "nohup $SOA_DOMAIN_HOME/bin/stopWebLogic.sh > $SOA_DOMAIN_HOME/servers/AdminServer/logs/AdminServer.out"
#Once all the servers are in running state access the consoles.
#1. WebLogic: http://localhost:7001/console
#2. Enterprise Manager: http://localhost:7001/em
#3. BAM http://localhost:9001/OracleBAM