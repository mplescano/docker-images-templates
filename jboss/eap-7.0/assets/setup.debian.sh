#!/bin/bash

apt-get update -q && \
    apt-get install -q -y --no-install-recommends ca-certificates curl unzip net-tools && \
    useradd -md /opt/jboss jboss && \
	printf 'jboss\njboss\n'|passwd jboss && \
	su - jboss -c "unzip -o -d /opt/jboss /assets/jboss-eap-7.0.0.zip" && \
	su - jboss -c "mv /opt/jboss/jboss-eap-7.0.0 /opt/jboss/eap-7.0.0" && \
	su - jboss -c "ln -s /opt/jboss/eap-7.0.0 /opt/wso2/eap" && \
	chown -R jboss:jboss /opt/jboss/* && \
	echo 'export JBOSS_EAP_HOME=/opt/wso2/eap' >> /etc/bash.bashrc && \
	/opt/wso2/eap/bin/add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent