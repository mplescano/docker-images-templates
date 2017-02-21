# docker build --no-cache -t mplescano/weblogic:12.1.3 .
# docker run -it mplescano/weblogic:12.1.3 /bin/bash
FROM mplescano/informix:12.10

#see https://github.com/docker/docker/issues/24697
ENV http_proxy=http://pxsis.sunat.peru:8080
ENV https_proxy=http://pxsis.sunat.peru:8080
ADD assets /assets

RUN /assets/setup.debian.sh

EXPOSE 9088
EXPOSE 7001


CMD /usr/sbin/startup.sh && /bin/bash