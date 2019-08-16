#!/bin/bash

apt-get update -q &&
apt-get install -q -y --no-install-recommends ca-certificates curl unzip nano net-tools &&
useradd -md /opt/jboss jboss &&
printf 'jboss\njboss\n'|passwd jboss &&
export JAVA_HOME="/opt/java" &&
export JBOSS_HOME=/opt/jboss/eap &&
echo 'export JBOSS_HOME=/opt/jboss/eap' >> /etc/bash.bashrc &&
echo 'export JBOSS_HOME=/opt/jboss/eap' >> /etc/profile.d/envs.sh &&
su - jboss -c "unzip -o -d /opt/jboss /assets/jboss-eap-7.0.0.zip" &&
su - jboss -c "mv /opt/jboss/jboss-eap-7.0 /opt/jboss/eap-7.0.0" &&
su - jboss -c "ln -s /opt/jboss/eap-7.0.0 /opt/jboss/eap" &&
chown -R jboss:jboss /opt/jboss/* &&
${JBOSS_HOME}/bin/add-user.sh mplescano Welcome1_2 --silent &&
echo 'JAVA_OPTS="$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0" \
         ' >> ${JBOSS_HOME}/bin/standalone.conf &&
mkdir /etc/jboss &&
cp /assets/jbosseap-server.conf /etc/jboss/ &&
cp /assets/jbosseap-server.sh /etc/init.d/ &&
chmod a+x /etc/init.d/jbosseap-server.sh &&
update-rc.d jbosseap-server.sh defaults &&
         
rm -rf /tmp/* &&
rm -rf /assets &&
apt-get remove --purge -y ca-certificates curl unzip &&
apt-get autoremove --purge -y &&
apt-get clean

exit $?