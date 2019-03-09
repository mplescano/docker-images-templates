#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive
export RCU_JDBC_TRIM_BLOCKS=true
export CONFIG_JVM_ARGS=-Djava.security.egd=file:/dev/./urandom
export MW_HOME=/u01/app/oracle/middleware
export SOA_ORACLE_HOME=/u01/app/oracle/middleware/soa
export WL_HOME=/u01/app/oracle/middleware/weblogic
export JAVA_HOME=/opt/java

apt-get update -q &&
apt-get install -q -y ca-certificates curl unzip &&
# Change the kernel parameters that need changing.
echo "net.core.rmem_max=4192608" > /assets/.sysctl.conf && 
echo "net.core.wmem_max=4192608" >> /assets/.sysctl.conf && 
sysctl -e -p /assets/.sysctl.conf &&

#see https://ariklalo.com/2013/04/16/repository-creation-utility-rcu-11-1-1-7-0-installation-on-oracle-linux-6-64bit/
#see https://docs.oracle.com/cd/E23943_01/doc.1111/e14259/rcu_schemas.htm#RCUUG170
#see https://docs.oracle.com/cd/E23943_01/doc.1111/e14259/rcu_silent.htm#RCUUG248
#-databaseType Type of database to which you are connecting. Valid options are ORACLE, IBMDB2, SQLSERVER, EBR, or MYSQL.
unzip /assets/ofm_rcu_linux_11.1.1.7.0_64_disk1_1of1.zip -d /assets &&
rm -rf /assets/ofm_rcu_linux_11.1.1.7.0_64_disk1_1of1.zip &&
chmod +x /assets/rcuHome/bin/rcu &&
chmod -R 775 /assets/rcuHome &&
/usr/sbin/startup.sh &&
su oracle -c "printf 'welcome1\nwelcome1\n'|/assets/rcuHome/bin/rcu -silent -createRepository -databaseType ORACLE -connectString 'localhost:1521:XE' -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -dbUser SYS -dbRole SYSDBA -selectDependentsForComponents true -component SOAINFRA -component BAM -component ORASDPM" &&
rm -rf /assets/rcuHome &&
#see https://github.com/gibaholms/docker/tree/master/weblogic-base-domain/10.3.6
#see https://docs.oracle.com/cd/E24902_01/doc.91/e18840/install_config_10_3_6.htm#EOHWL190
#see https://docs.oracle.com/cd/E23943_01/doc.1111/e14142/silent.htm#WLSIG234
#see https://docs.oracle.com/cd/E23943_01/doc.1111/e14142/prepare.htm#WLSIG110
su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/wls1036_generic.jar -mode=silent  -silent_xml=/assets/wls-silent.xml" && 
echo 'export MW_HOME=/u01/app/oracle/middleware' >> /etc/bash.bashrc &&
echo 'export WL_HOME=/u01/app/oracle/middleware/weblogic' >> /etc/bash.bashrc &&
rm -rf /assets/wls1036_generic.jar &&
unzip /assets/V37380-01_1of2.zip -d /assets/soa && rm -Rf /assets/V37380-01_1of2.zip &&
unzip /assets/V37380-01_2of2.zip -d /assets/soa && rm -Rf /assets/V37380-01_2of2.zip &&
su oracle -c "mkdir /u01/app/oracle/.inventory && /assets/soa/Disk1/runInstaller -waitforcompletion -nowait -nocheckForUpdates -ignoreSysPrereqs -novalidation -silent -jreloc ${JAVA_HOME} -invPtrLoc /assets/oraInst.loc -responseFile /assets/install.file" &&
echo 'export SOA_ORACLE_HOME=/u01/app/oracle/middleware/soa' >> /etc/bash.bashrc &&
rm -rf /assets/soa &&
unzip /assets/ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip -d /assets/osb && rm -Rf /assets/ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip &&
su oracle -c "/assets/osb/Disk1/runInstaller -waitforcompletion -nowait -nocheckForUpdates -ignoreSysPrereqs -novalidation -silent -jreloc ${JAVA_HOME} -invPtrLoc /assets/oraInst_osb.loc -responseFile /assets/install_osb.file" &&
echo 'export OSB_ORACLE_HOME=/u01/app/oracle/middleware/osb' >> /etc/bash.bashrc &&

rm -rf /assets &&
apt-get remove --purge -y ca-certificates curl unzip &&
apt-get autoremove --purge -y &&
apt-get clean

exit $?
