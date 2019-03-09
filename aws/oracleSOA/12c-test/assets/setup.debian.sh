#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive
export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom
export MW_HOME=/u01/app/oracle/middleware
export WL_HOME=/u01/app/oracle/middleware/wlserver
export JAVA_HOME=/opt/java
export TZ='UTC'
export SOA_DOMAIN_HOME=/u01/app/oracle/user_projects/domains/soa_devdomain
echo 'export SOA_DOMAIN_HOME=/u01/app/oracle/user_projects/domains/soa_devdomain' >> /etc/bash.bashrc &&

#apt-get update -q &&
#apt-get install -q -y expect expect-dev &&

#see http://majid-hussain.blogspot.pe/2012/10/installation-and-configuration-of-soa.html
#see https://docs.oracle.com/cd/E23943_01/web.1111/e14140/console_mode.htm#WLDCW236
#see https://docs.oracle.com/cd/E21764_01/install.1111/e13925/configure.htm#INSOA220
#./config.sh -log=log_filename
/usr/sbin/startup.sh &&

#su - oracle -c "export JAVA_HOME=/opt/java && export TZ='UTC' && printf 'welcome1\nwelcome1\n'|/u01/app/oracle/middleware/oracle_common/bin/rcu -silent -createRepository -databaseType ORACLE -connectString localhost:1521:XE -dbUser SYS -dbRole SYSDBA -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -selectDependentsForComponents true -variables SOA_PROFILE_TYPE=SMALL,HEALTHCARE_INTEGRATION=NO -component MDS -component IAU -component IAU_APPEND -component IAU_VIEWER -component OPSS -component UCSUMS -component WLS -component STB -component ESS -component SOAINFRA" &&

su - oracle -c "export TZ='UTC' && export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom && /u01/app/oracle/middleware/wlserver/common/bin/wlst.sh -skipWLSModuleScanning /assets/create-soa-domain.py" &&

sed -i "s/${HOSTNAME}/localhost/g" "${SOA_DOMAIN_HOME}/bin/stopWebLogic.sh" &&

#chmod +x /assets/expected.config.sh &&
#su - oracle -c "export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom && /assets/expected.config.sh" &&
#see http://frankfu-oracle-soa-adapter.blogspot.pe/
#su - oracle -c "ln -s ${MW_HOME}/oracle_common/modules/com.oracle.weblogic.sca.engine.jar ${MW_HOME}/modules/com.oracle.weblogic.sca.engine_1.3.0.0.jar" &&
#su - oracle -c "ln -s ${MW_HOME}/oracle_common/modules/ws.databinding.jar ${MW_HOME}/modules/ws.databinding_1.2.0.0.jar" &&
#su - oracle -c "ln -s ${MW_HOME}/oracle_common/modules/ws.databinding.plugins.jar ${MW_HOME}/modules/ws.databinding.plugins_1.2.0.0.jar" &&
################
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/AdminServer/logs" &&

su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/nodemanager/logs" &&

su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/bam_server1" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/bam_server1/logs" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/bam_server1/security" &&
su - oracle -c "touch ${SOA_DOMAIN_HOME}/servers/bam_server1/security/boot.properties" &&
su - oracle -c "echo \"username=weblogic\" > ${SOA_DOMAIN_HOME}/servers/bam_server1/security/boot.properties" &&
su - oracle -c "echo \"password=welcome1\" >> ${SOA_DOMAIN_HOME}/servers/bam_server1/security/boot.properties" &&

su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/osb_server1" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/osb_server1/logs" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/osb_server1/security" &&
su - oracle -c "touch ${SOA_DOMAIN_HOME}/servers/osb_server1/security/boot.properties" &&
su - oracle -c "echo \"username=weblogic\" > ${SOA_DOMAIN_HOME}/servers/osb_server1/security/boot.properties" &&
su - oracle -c "echo \"password=welcome1\" >> ${SOA_DOMAIN_HOME}/servers/osb_server1/security/boot.properties" &&

su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/soa_server1" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/soa_server1/logs" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/soa_server1/security" &&
su - oracle -c "touch ${SOA_DOMAIN_HOME}/servers/soa_server1/security/boot.properties" &&
su - oracle -c "echo \"username=weblogic\" > ${SOA_DOMAIN_HOME}/servers/soa_server1/security/boot.properties" &&
su - oracle -c "echo \"password=welcome1\" >> ${SOA_DOMAIN_HOME}/servers/soa_server1/security/boot.properties" &&

cp -rf /assets/allServersStart.sh /usr/sbin/ &&
chmod +x /usr/sbin/allServersStart.sh

rm -rf /assets

exit $?
