# © Copyright IBM Corporation 2015.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# docker build -t mplescano/iib-mq:v10 .
# docker run -p 4415:4415 -p 4414:4414 -p 7800:7800 -p 7883:7883 -p 1414:1414 -p 9443:9443 -it mplescano/iib-mq:v10
# 11884 4415

FROM debian:jessie

MAINTAINER Sam Rogers srogers@uk.ibm.com, mplescano@

ENV http_proxy=http://pxsis.sunat.peru:8080
ENV https_proxy=http://pxsis.sunat.peru:8080
ADD assets /assets

# Install packages
RUN /assets/setup.debian.sh

# Set BASH_ENV to source mqsiprofile when using docker exec bash -c
ENV BASH_ENV=/usr/local/bin/iib_env.sh
ENV ODBCINI=/etc/odbc.ini
ENV LICENSE=accept
ENV MQ_QMGR_NAME=IIB_MQMGR

# Expose default admin port and http port, plus MQ ports
EXPOSE 4415 4414 7800 7883 1414 9443

# USER iibuser

# Set entrypoint to run management script
# ENTRYPOINT ["/usr/local/bin/iib_manage.sh"]

CMD /usr/local/bin/iib_manage.sh && /bin/bash
