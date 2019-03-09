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

unzip /assets/V44416-01.zip -d /assets &&
rm -rf /assets/V44416-01.zip &&
su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/fmw_12.1.3.0.0_infrastructure.jar -silent -jreloc ${JAVA_HOME} -waitforcompletion -ignoreSysPrereqs -novalidation -invPtrLoc /assets/oraInst.loc -responseFile /assets/install.file" && 
rm -rf /assets/fmw_12.1.3.0.0_infrastructure.jar &&

unzip /assets/V44420-01.zip -d /assets &&
rm -rf /assets/V44420-01.zip &&

su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/fmw_12.1.3.0.0_soa.jar -silent -jreloc ${JAVA_HOME} -waitforcompletion -ignoreSysPrereqs -novalidation -invPtrLoc /assets/oraInst.loc -responseFile /assets/install_soa.file" && 

rm -rf /assets/fmw_12.1.3.0.0_soa.jar &&

unzip /assets/V44423-01.zip -d /assets &&
rm -rf /assets/V44423-01.zip &&

#@see http://middlewaresnippets.blogspot.pe/2014/08/set-up-12c-soabpm-infrastructure.html
su - oracle -c "export JAVA_HOME=/opt/java && export TZ='UTC' && printf 'welcome1\nwelcome1\n'|${MW_HOME}/oracle_common/bin/rcu -silent -createRepository -databaseType ORACLE -connectString 'localhost:1521:XE' -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -dbUser SYS -dbRole SYSDBA -selectDependentsForComponents true -component SOAINFRA -component MDS -component IAU -component IAU_APPEND -component IAU_VIEWER -component OPSS -component UCSUMS -component WLS -component STB -component ESS -variables SOA_PROFILE_TYPE=SMALL,HEALTHCARE_INTEGRATION=NO" &&
#su - oracle -c "                                                 printf 'welcome1\nwelcome1\n'|${MW_HOME}/oracle_common/bin/rcu -silent -createRepository -databaseType ORACLE -connectString 'localhost:1521:XE' -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -dbUser SYS -dbRole SYSDBA -selectDependentsForComponents true -component SOAINFRA -component MDS -component IAU -component IAU_APPEND -component IAU_VIEWER -component OPSS -component UCSUMS -component WLS -component STB -variables SOA_PROFILE_TYPE=SMALL,HEALTHCARE_INTEGRATION=NO " &&
#                                                                            -silent -createRepository -databaseType ORACLE -connectString r-pc:1521:orcl12    -schemaPrefix SOA -useSamePasswordForAllSchemaUsers true -dbUser sys -dbRole SYSDBA                                     -component SOAINFRA -component MDS -component IAU -component IAU_APPEND -component IAU_VIEWER -component OPSS -component UCSUMS -component WLS -component STB  -f < ${SCRIPT_PATH}/passwordfile.txt
#																			 -silent -createRepository -databaseType ORACLE -connectString 'localhost:1521:XE' -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -dbUser SYS -dbRole SYSDBA -selectDependentsForComponents true 
#su oracle -c "printf 'welcome1\nwelcome1\n'|/u01/app/oracle/middleware/oracle_common/bin/rcu 

su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/fmw_12.1.3.0.0_osb.jar -silent -jreloc ${JAVA_HOME} -waitforcompletion -ignoreSysPrereqs -novalidation -invPtrLoc /assets/oraInst.loc -responseFile /assets/install_osb.file" && 

rm -rf /assets/fmw_12.1.3.0.0_osb.jar &&

echo 'export OSB_ORACLE_HOME=/u01/app/oracle/middleware/osb' >> /etc/bash.bashrc &&
echo 'export SOA_ORACLE_HOME=/u01/app/oracle/middleware/soa' >> /etc/bash.bashrc &&
echo 'export MW_HOME=/u01/app/oracle/middleware' >> /etc/bash.bashrc &&
echo 'export WL_HOME=/u01/app/oracle/middleware/wlserver' >> /etc/bash.bashrc &&

#su oracle -c "printf 'welcome1\nwelcome1\n'|/u01/app/oracle/middleware/oracle_common/bin/rcu -silent -createRepository -databaseType ORACLE -connectString localhost:1521:XE -dbUser SYS -dbRole SYSDBA -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -selectDependentsForComponents true -variables SOA_PROFILE_TYPE=SMALL,HEALTHCARE_INTEGRATION=NO -component MDS -component IAU -component IAU_APPEND -component IAU_VIEWER -component OPSS -component UCSUMS -component WLS -component STB -component ESS -component SOAINFRA" &&

#chmod +x /assets/rcuHome/bin/rcu &&
#chmod -R 775 /assets/rcuHome &&
#su oracle -c "printf 'welcome1\nwelcome1\n'|/assets/rcuHome/bin/rcu -silent -createRepository -databaseType ORACLE -connectString 'localhost:1521:XE' -schemaPrefix DEV -useSamePasswordForAllSchemaUsers true -dbUser SYS -dbRole SYSDBA -selectDependentsForComponents true -component SOAINFRA -component BAM -component ORASDPM" &&
#rm -rf /assets/rcuHome &&
#see https://github.com/gibaholms/docker/tree/master/weblogic-base-domain/10.3.6
#see https://docs.oracle.com/cd/E24902_01/doc.91/e18840/install_config_10_3_6.htm#EOHWL190
#see https://docs.oracle.com/cd/E23943_01/doc.1111/e14142/silent.htm#WLSIG234
#see https://docs.oracle.com/cd/E23943_01/doc.1111/e14142/prepare.htm#WLSIG110
#su oracle -c "/opt/java/bin/java ${CONFIG_JVM_ARGS} -jar /assets/wls1036_generic.jar -mode=silent  -silent_xml=/assets/wls-silent.xml" && 
#echo 'export MW_HOME=/u01/app/oracle/middleware' >> /etc/bash.bashrc &&
#echo 'export WL_HOME=/u01/app/oracle/middleware/weblogic' >> /etc/bash.bashrc &&
#rm -rf /assets/wls1036_generic.jar &&
#unzip /assets/V37380-01_1of2.zip -d /assets/soa && rm -Rf /assets/V37380-01_1of2.zip &&
#unzip /assets/V37380-01_2of2.zip -d /assets/soa && rm -Rf /assets/V37380-01_2of2.zip &&
#su oracle -c "mkdir /u01/app/oracle/.inventory && /assets/soa/Disk1/runInstaller -waitforcompletion -nowait -nocheckForUpdates -ignoreSysPrereqs -novalidation -silent -jreloc ${JAVA_HOME} -invPtrLoc /assets/oraInst.loc -responseFile /assets/install.file" &&
#echo 'export SOA_ORACLE_HOME=/u01/app/oracle/middleware/soa' >> /etc/bash.bashrc &&
#rm -rf /assets/soa &&
#unzip /assets/ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip -d /assets/osb && rm -Rf /assets/ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip &&
#su oracle -c "/assets/osb/Disk1/runInstaller -waitforcompletion -nowait -nocheckForUpdates -ignoreSysPrereqs -novalidation -silent -jreloc ${JAVA_HOME} -invPtrLoc /assets/oraInst_osb.loc -responseFile /assets/install_osb.file" &&
#echo 'export OSB_ORACLE_HOME=/u01/app/oracle/middleware/osb' >> /etc/bash.bashrc &&

rm -rf /assets &&
rm -rf /tmp/* &&
#apt-get remove --purge -y unzip &&
#apt-get autoremove --purge -y &&
#apt-get clean

exit $?
