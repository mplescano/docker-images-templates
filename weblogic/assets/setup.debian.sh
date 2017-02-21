#!/bin/bash
#
#TODO install java..
apt-get update -q &&
#git-core make build-essential
apt-get install -q -y ca-certificates curl unzip apache2 &&
JAVA_VERSION_MAJOR=7 &&
JAVA_VERSION_MINOR=80 &&
JAVA_VERSION_BUILD=15 &&
JAVA_PACKAGE=jdk &&
touch /etc/profile.d/env_java.sh &&
echo "export JAVA_HOME=/opt/java" >> /etc/profile.d/env_java.sh &&
echo "export PATH=${PATH}:/opt/java/bin" >> /etc/profile.d/env_java.sh &&
echo "export LANG=C.UTF-8" >> /etc/profile.d/env_java.sh &&
echo "export CONFIG_JVM_ARGS=\"-Djava.security.egd=file:/dev/./urandom\"" >> /etc/profile.d/env_java.sh &&
export JAVA_HOME=/opt/java &&
export PATH=${PATH}:/opt/java/bin &&
export LANG=C.UTF-8 &&
export CONFIG_JVM_ARGS="-Djava.security.egd=file:/dev/./urandom" &&
#cd /root &&
#git git clone https://github.com/wolfcw/libfaketime.git &&
#cd libfaketime/src &&
#make install &&
#export LD_PRELOAD=/usr/local/lib/faketime/libfaketime.so.1 &&
#echo "export LD_PRELOAD=/usr/local/lib/faketime/libfaketime.so.1" >> /etc/bash.bashrc &&
#export FAKETIME="@2016-01-15 12:00:00" &&
curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz &&
gunzip /tmp/java.tar.gz &&
tar -C /opt -xf /tmp/java.tar &&
ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} &&
curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/unlimited_jce_policy.zip "http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip" &&
unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip &&
rm -rf ${JAVA_HOME}/*src.zip \
           /tmp/* /var/cache/apk/* &&
apt-get remove --purge -y ca-certificates curl unzip &&
apt-get autoremove --purge -y &&
apt-get clean &&
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&
mkdir /u01 &&
mkdir /u01/app &&
groupadd oracle &&
useradd -md /u01/app/oracle -g oracle oracle &&
printf 'oracle\noracle\n'|passwd oracle &&

su - -c "java -jar /assets/fmw_12.1.3.0.0_wls.jar -silent -invPtrLoc /assets/oraInst-wls.loc -responseFile /assets/response-wls.rsp" oracle &&
touch /etc/profile.d/env_middleware.sh &&
echo "export MW_HOME=/u01/app/oracle/middleware" >> /etc/profile.d/env_middleware.sh &&
export MW_HOME=/u01/app/oracle/middleware &&

export DOMAIN_NAME=base_devdomain &&
export ADMIN_PORT=7001 &&
export ADMIN_PASSWORD=welcome1 &&
/u01/app/oracle/middleware/wlserver/common/bin/wlst.sh -skipWLSModuleScanning /assets/create-wls-domain.py &&
mkdir -p /u01/app/oracle/user_projects/domains/base_devdomain/servers/AdminServer/security &&
echo "username=weblogic" > /u01/app/oracle/user_projects/domains/${DOMAIN_NAME}/servers/AdminServer/security/boot.properties &&
echo "password=${ADMIN_PASSWORD}" >> /u01/app/oracle/user_projects/domains/${DOMAIN_NAME}/servers/AdminServer/security/boot.properties
#touch /etc/profile.d/env_base_devdomain.sh &&
#echo "export PATH=$PATH:/u01/app/oracle/middleware/wlserver/common/bin:/u01/app/oracle/middleware/user_projects/domains/${DOMAIN_NAME}/bin" >> /etc/profile.d/env_base_devdomain.sh &&
rm -Rf /assets


