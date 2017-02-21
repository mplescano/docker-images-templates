#   docker build --no-cache -t mplescano/informix:12.10 .
#   docker run -p 9088:9088 -it mplescano/informix:12.10
#   see
#   docker run -e TERM -p 9088:9088 --rm -it --entrypoint=//bin/bash mplescano/informix:12.10
#
FROM debian:jessie

#see https://github.com/docker/docker/issues/24697
ENV http_proxy=http://pxsis.sunat.peru:8080
ENV https_proxy=http://pxsis.sunat.peru:8080
ADD assets /assets

RUN /assets/setup.debian.sh

EXPOSE 9088
#EXPOSE 9089
#EXPOSE 27017

#USER informix
#CMD [ "/bin/bash", "/opt/informix/run.sh" ]
CMD /usr/sbin/startup.sh && /bin/bash