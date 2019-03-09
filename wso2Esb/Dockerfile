#      docker build --no-cache -t mplescano/wso2-esb:5.0.0 .
#      docker run -it --rm -p 9443:9443 -p 9444:9444 mplescano/wso2-esb:5.0.0 /bin/bash
#      docker run -it -p 9443:9443 -p 9444:9444 -p 8280:8280 mplescano/wso2-esb:5.0.0 (there is executed CMD section)
#      -d is in mode detached
#      docker run -d -p 9443:9443 -p 9444:9444 -e mplescano/wso2-esb:5.0.0 /bin/bash
#      docker run -d -p 9443:9443 -p 9444:9444 mplescano/wso2-esb:5.0.0 /bin/bash
FROM mplescano/java-debian:7.80.15.jdk

MAINTAINER mplescano@

ADD assets /assets
RUN /assets/setup.debian.sh

#https://localhost:9443/carbon
EXPOSE 9443
EXPOSE 9444

#it's executed when instantiating a container without arguments..
CMD /usr/sbin/service wso2esb-analytics.sh start && /usr/sbin/service wso2esb-server.sh start && /bin/bash
