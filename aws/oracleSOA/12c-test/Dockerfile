# docker build --no-cache -t mplescano/oracle-soa-test:12c .
# docker run -p 5556:5556 -p 1521:1521 -p 7001:7001 -p 7003:7003 -p 7004:7004 -p 7005:7005 -it mplescano/oracle-soa-test:12c
# mplescano/oracle-soa:11.1.7 está incompleto
FROM mplescano/oracle-soa:12.1.3.0

# Maintainer
# ----------
MAINTAINER mplescano@

# SETUP FILESYSTEM AND ORACLE USER
# ------------------------------------------------------------

# Copy assets
ADD assets /assets
RUN /assets/setup.debian.sh

EXPOSE 5556
EXPOSE 7001
EXPOSE 7003
EXPOSE 7004
EXPOSE 7005
EXPOSE 1521

# Define default command to start bash. 
CMD /usr/sbin/allServersStart.sh && /bin/bash
