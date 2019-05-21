# 
#      $ sudo docker build -t mplescano/java-debian:8.211.12.jdk .
# usage docker run -it --rm mplescano/java-debian:8.211.12.jdk java -version
# for rebuild a image docker build --no-cache -t mplescano/java-debian:8.211.12.jdk .
# for start a session bash docker run -it --rm mplescano/java-debian:8.211.12.jdk
# or docker run -it --rm mplescano/java-debian:8.211.12.jdk /bin/bash
FROM debian:jessie

MAINTAINER mplescano@

#see https://github.com/docker/docker/issues/15383
#see http://unix.stackexchange.com/questions/117467/how-to-permanently-set-environmental-variables
#see http://unix.stackexchange.com/questions/74076/permanent-environment-variable-for-all-users
#ENV JAVA_VERSION_MAJOR=7 \
#    JAVA_VERSION_MINOR=80 \
#    JAVA_VERSION_BUILD=15 \
#    JAVA_PACKAGE=jdk \
#    JAVA_HOME=/opt/java \
#    JVM_OPTS="" \
#    PATH=${PATH}:/opt/java/bin \
#    LANG=C.UTF-8

ADD assets /assets

RUN /assets/setup.debian.sh

CMD /bin/bash