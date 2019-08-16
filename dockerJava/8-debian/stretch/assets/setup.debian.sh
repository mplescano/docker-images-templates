
JAVA_VERSION_MAJOR=8
JAVA_VERSION_MINOR=221
JAVA_VERSION_BUILD=11
JAVA_PACKAGE=jdk
export JAVA_HOME=/opt/java
JVM_OPTS=""
export LANG=C.UTF-8

echo 'export JAVA_HOME=/opt/java' >> /etc/bash.bashrc && \
echo 'export PATH=${PATH}:/opt/java/bin' >> /etc/bash.bashrc && \
touch /etc/profile.d/envs.sh &&
echo 'export JAVA_HOME=/opt/java' >> /etc/profile.d/envs.sh && \
echo 'export PATH=${PATH}:/opt/java/bin' >> /etc/profile.d/envs.sh && \
export PATH=${PATH}:/opt/java/bin && \
echo 'export LANG=C.UTF-8' >> /etc/bash.bashrc && \
echo 'export LANG=C.UTF-8' >> /etc/profile.d/envs.sh && \
echo 'deb http://ftp.debian.org/debian stretch main non-free contrib' >> /etc/apt/sources.list && \
	echo 'deb-src http://ftp.debian.org/debian stretch main non-free contrib' >> /etc/apt/sources.list && \
	apt-get -o Acquire::Check-Valid-Until=false update
	apt-get update -q && \
    apt-get install -q -y --no-install-recommends ca-certificates curl unzip && \
    mv /assets/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz /tmp/java.tar.gz && \
    gunzip /tmp/java.tar.gz && \
    tar -C /opt -xf /tmp/java.tar && \
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} && \
    mv /assets/jce_policy-8.zip /tmp/unlimited_jce_policy.zip && \
    unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip && \
    rm -rf ${JAVA_HOME}/*src.zip \
           ${JAVA_HOME}/lib/missioncontrol \
           ${JAVA_HOME}/lib/visualvm \
           ${JAVA_HOME}/lib/*javafx* \
           ${JAVA_HOME}/jre/plugin \
           ${JAVA_HOME}/jre/bin/javaws \
           ${JAVA_HOME}/jre/bin/jjs \
           ${JAVA_HOME}/jre/bin/keytool \
           ${JAVA_HOME}/jre/bin/orbd \
           ${JAVA_HOME}/jre/bin/pack200 \
           ${JAVA_HOME}/jre/bin/policytool \
           ${JAVA_HOME}/jre/bin/rmid \
           ${JAVA_HOME}/jre/bin/rmiregistry \
           ${JAVA_HOME}/jre/bin/servertool \
           ${JAVA_HOME}/jre/bin/tnameserv \
           ${JAVA_HOME}/jre/bin/unpack200 \
           ${JAVA_HOME}/jre/lib/javaws.jar \
           ${JAVA_HOME}/jre/lib/deploy* \
           ${JAVA_HOME}/jre/lib/desktop \
           ${JAVA_HOME}/jre/lib/*javafx* \
           ${JAVA_HOME}/jre/lib/*jfx* \
           ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
           ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
           ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
           ${JAVA_HOME}/jre/lib/amd64/libglass.so \
           ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
           ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
           ${JAVA_HOME}/jre/lib/amd64/libjfx*.so \
           ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
           ${JAVA_HOME}/jre/lib/ext/nashorn.jar \
           ${JAVA_HOME}/jre/lib/oblique-fonts \
           ${JAVA_HOME}/jre/lib/plugin.jar \
           /tmp/* /var/cache/apk/* && \
    apt-get remove --purge -y ca-certificates curl unzip && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*