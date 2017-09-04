# © Copyright IBM Corporation 2015.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# docker build -t mplescano/iib-mq:v9.0.0.2 .
# docker run -p 7080:7080 -p 9001:9001 -p 8453:8453 -p 4415:4415 -p 4414:4414 -p 7800:7800 -p 7883:7883 -p 1414:1414 -p 9443:9443 -it mplescano/iib-mq:v9.0.0.2
# docker run -it mplescano/iib-mq:v9.0.0.2
# 11884 4415

FROM debian:jessie

MAINTAINER Sam Rogers srogers@uk.ibm.com, mplescano@

ENV http_proxy=http://pxsis.sunat.peru:8080
ENV https_proxy=http://pxsis.sunat.peru:8080
ADD assets /assets

# Install packages
RUN /assets/setup.debian.sh

# Set BASH_ENV to source mqsiprofile when using docker exec bash -c
# ENV BASH_ENV=/usr/local/bin/iib_env.sh
# ENV ODBCINI=/etc/odbc.ini
#ENV LICENSE=accept
#ENV MQ_QMGR_NAME=IIB_MQMGR

EXPOSE 4415 4414 7800 7883 1414 9443
# Expose default admin port and http port, plus MQ ports
# 8453 port of debug in iib
EXPOSE 8453
#Listen for HttpInputs
EXPOSE 7080
#Port HSQLDB
EXPOSE 9001

# USER iibuser

# Set entrypoint to run management script
# ENTRYPOINT ["/usr/local/bin/iib_manage.sh"]

CMD /usr/sbin/service rsyslog start && /usr/sbin/service mq-server start && /usr/sbin/service iib-server start && /bin/bash
#CMD /bin/bash
