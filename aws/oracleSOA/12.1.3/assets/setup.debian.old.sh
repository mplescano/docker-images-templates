#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive
export RCU_JDBC_TRIM_BLOCKS=true
export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom
export MW_HOME=/u01/app/oracle/middleware
export SOA_ORACLE_HOME=/u01/app/oracle/middleware/soa
export WL_HOME=/u01/app/oracle/middleware/wlserver
export JAVA_HOME=/opt/java
export TZ='UTC'

#restart DB
/usr/sbin/startup.sh &&
#apt-get update -q &&
apt-get install -q -y unzip &&
# Change the kernel parameters that need changing.
echo "net.core.rmem_max=4192608" > /assets/.sysctl.conf && 
echo "net.core.wmem_max=4192608" >> /assets/.sysctl.conf && 
sysctl -e -p /assets/.sysctl.conf &&

#unzip /assets/V44416-01.zip -d /assets &&
#rm -rf /assets/V44416-01.zip &&
#su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/fmw_12.1.3.0.0_infrastructure.jar -silent -jreloc ${JAVA_HOME} -waitforcompletion -ignoreSysPrereqs -novalidation -invPtrLoc /assets/oraInst.loc -responseFile /assets/install.file" && 
#rm -rf /assets/fmw_12.1.3.0.0_infrastructure.jar &&

su - -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/fmw_12.1.3.0.0_wls.jar -silent -invPtrLoc /assets/oraInst.loc -responseFile /assets/response-wls.rsp" oracle &&
rm -rf /assets/fmw_12.1.3.0.0_wls.jar &&

unzip /assets/V44420-01.zip -d /assets &&
rm -rf /assets/V44420-01.zip &&

#su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/fmw_12.1.3.0.0_soa.jar -silent -jreloc ${JAVA_HOME} -waitforcompletion -ignoreSysPrereqs -novalidation -invPtrLoc /assets/oraInst.loc -responseFile /assets/install_soa.file" && 

#rm -rf /assets/fmw_12.1.3.0.0_soa.jar &&


exit $?
