#      docker build --no-cache -t mplescano/jboss-eap:stretch-7.0.0 .
#      docker run -it --rm -p 8080:8080 -p 8443:8443 -p 9990:9990 -p 9999:9999 mplescano/jboss-eap:stretch-7.0.0 /bin/bash
FROM mplescano/java-debian:stretch-8.221.11.jdk

MAINTAINER mplescano@

ADD assets /assets
RUN /assets/setup.debian.sh

EXPOSE 8080 8443 9990 9999

CMD /usr/sbin/service jbosseap-server.sh start && /bin/bash