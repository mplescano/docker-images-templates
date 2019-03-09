# docker build --no-cache -t mplescano/oracle-soa-test:11 .
# docker run -p 5556:5556 -p 1521:1521 -p 7001:7001 -p 9001:9001 -it mplescano/oracle-soa-test:11
# mplescano/oracle-soa:11.1.7 está incompleto
FROM mplescano/oracle-soa:11.1.1.7

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
EXPOSE 9001
EXPOSE 1521


# Define default command to start bash. 
CMD /usr/sbin/allServersStart.sh && /bin/bash