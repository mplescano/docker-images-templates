#      docker build --no-cache -t mplescano/oracle-db-xe:11.2 .
#      docker run -it --rm -p 1521:1521 mplescano/oracle-db-xe:11.2 /bin/bash
#      docker run -it --rm -p 1521:1521 mplescano/oracle-db-xe:11.2 (there is executed CMD section)
#      -d is in mode detached
#
FROM mplescano/java-debian:7.80.15.jdk

MAINTAINER mplescano@

ADD assets /assets
RUN /assets/setup.debian.sh

EXPOSE 1521

#it's executed when instantiating a container without arguments..
CMD /usr/sbin/startup.sh && /bin/bash
