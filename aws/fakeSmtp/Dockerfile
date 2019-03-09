# 
# docker build -t mplescano/fakesmtp:2.0 .
# docker run -it -p 25:25 --rm mplescano/fakesmtp:2.0
FROM mplescano/java-debian:7.80.15.jdk

MAINTAINER mplescano@

ADD assets /assets

RUN /assets/setup.debian.sh

EXPOSE 25

VOLUME /var/mail

ENTRYPOINT ["/opt/java/bin/java", "-jar", "/opt/fakeSMTP/2.0/fakeSMTP.jar", "--background", "--output-dir", "/var/mail", "--port", "25", "--start-server"]