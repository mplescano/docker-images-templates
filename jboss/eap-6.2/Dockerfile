FROM mplescano/java-debian:8.211.12.jdk
LABEL MAINTAINER='mplescano@'
ENV PRODUCT='jboss-eap-6.3'                                                                            \
    JBOSS_USER='jboss'
ENV ADMIN_USER='admin'                                                                                 \
    ADMIN_PASSWORD='Admin.123'                                                                         \
    JDK_VERSION='jdk1.7.0_80'                                                                          \
    JBOSS_USER_HOME="/home/${JBOSS_USER}"                                                              \
    DOWNLOAD_BASE_URL="https://github.com/daggerok/${PRODUCT}/releases/download"                       \
    JBOSS_EAP_PATCH='6.3.0'
ENV JBOSS_HOME="${JBOSS_USER_HOME}/${PRODUCT}"                                                         \
    ARCHIVES_BASE_URL="${DOWNLOAD_BASE_URL}/archives"                                                  \
    PATCHES_BASE_URL="${DOWNLOAD_BASE_URL}/${JBOSS_EAP_PATCH}"
ENV PATH="${JBOSS_HOME}/bin:/tmp:${PATH}"                                                              \
    JAVA_HOME="/usr/lib/jvm/${JDK_VERSION}"
USER root
RUN yum update -y                                                                                   && \
    yum update --security -y                                                                        && \
    yum install -y wget ca-certificates unzip sudo openssh-client unzip zip net-tools               && \
    echo "${JBOSS_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers                                    && \
    adduser -U -m -d /home/jboss -s /bin/bash jboss                                                 && \
    usermod -a -G ${JBOSS_USER} ${JBOSS_USER}
USER ${JBOSS_USER}
CMD /bin/bash
ENTRYPOINT standalone.sh
EXPOSE 8080 8443 9990 9999
WORKDIR /tmp
ADD --chown=jboss ./install.sh .
RUN wget ${ARCHIVES_BASE_URL}/jboss-eap-6.3.0.zip                                                      \
         -q --no-cookies --no-check-certificate -O /tmp/jboss-eap-6.3.0.zip                         && \
    unzip -q /tmp/jboss-eap-6.3.0.zip -d ${JBOSS_USER_HOME}                                         && \
    add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent                                            && \
    echo 'JAVA_OPTS="-Djava.net.preferIPv4Stack=true -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0" \
         ' >> ${JBOSS_HOME}/bin/standalone.conf                                                     && \
    ( standalone.sh --admin-only                                                                       \
      & ( sudo chmod +x /tmp/install.sh                                                             && \
          install.sh                                                                                && \
          rm -rf /tmp/install.sh                                                                    && \
          sudo yum autoremove -y                                                                    && \
          sudo yum clean all -y                                                                     && \
          ( sudo rm -rf /tmp/* /var/cache/yum || echo 'something was not removed...' ) ) )
WORKDIR ${JBOSS_USER_HOME}
