#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive
export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom
export MW_HOME=/u01/app/oracle/middleware
export WL_HOME=/u01/app/oracle/middleware/weblogic
export SOA_DOMAIN_HOME=/u01/app/oracle/middleware/user_projects/domains/soa_devdomain
echo 'export SOA_DOMAIN_HOME=/u01/app/oracle/middleware/user_projects/domains/soa_devdomain' >> /etc/bash.bashrc &&

apt-get update -q &&
apt-get install -q -y expect expect-dev &&

#see http://majid-hussain.blogspot.pe/2012/10/installation-and-configuration-of-soa.html
#see https://docs.oracle.com/cd/E23943_01/web.1111/e14140/console_mode.htm#WLDCW236
#see https://docs.oracle.com/cd/E21764_01/install.1111/e13925/configure.htm#INSOA220
#./config.sh -log=log_filename
/usr/sbin/startup.sh &&
chmod +x /assets/expected.config.sh &&
su - oracle -c "export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom && /assets/expected.config.sh" &&
#see http://frankfu-oracle-soa-adapter.blogspot.pe/
su - oracle -c "ln -s ${MW_HOME}/oracle_common/modules/com.oracle.weblogic.sca.engine.jar ${MW_HOME}/modules/com.oracle.weblogic.sca.engine_1.3.0.0.jar" &&
su - oracle -c "ln -s ${MW_HOME}/oracle_common/modules/ws.databinding.jar ${MW_HOME}/modules/ws.databinding_1.2.0.0.jar" &&
su - oracle -c "ln -s ${MW_HOME}/oracle_common/modules/ws.databinding.plugins.jar ${MW_HOME}/modules/ws.databinding.plugins_1.2.0.0.jar" &&
################
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/AdminServer/logs" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/bam_server1" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/bam_server1/logs" &&
su - oracle -c "mkdir ${SOA_DOMAIN_HOME}/servers/bam_server1/security" &&
su - oracle -c "touch ${SOA_DOMAIN_HOME}/servers/bam_server1/security/boot.properties" &&
su - oracle -c "echo \"username=weblogic\" > ${SOA_DOMAIN_HOME}/servers/bam_server1/security/boot.properties" &&
su - oracle -c "echo \"password=welcome1\" >> ${SOA_DOMAIN_HOME}/servers/bam_server1/security/boot.properties" &&
cp -rf /assets/allServersStart.sh /usr/sbin/ &&
chmod +x /usr/sbin/allServersStart.sh

rm -rf /assets

exit $?
