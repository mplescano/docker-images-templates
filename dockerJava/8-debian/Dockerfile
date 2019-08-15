# 
#      $ sudo docker build -t mplescano/java-debian:8.221.11.jdk .
# usage docker run -it --rm mplescano/java-debian:8.221.11.jdk java -version
# for rebuild a image docker build --no-cache -t mplescano/java-debian:8.221.11.jdk .
# for start a session bash docker run -it --rm mplescano/java-debian:8.221.11.jdk
# or docker run -it --rm mplescano/java-debian:8.221.11.jdk /bin/bash
FROM debian:buster

MAINTAINER mplescano@

ADD assets /assets

RUN /assets/setup.debian.sh

CMD /bin/bash