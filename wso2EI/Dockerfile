#      docker build --no-cache -t mplescano/wso2-ei:6.1.1 .
#      docker run -it --rm -p 8243:8243 -p 8280:8280 -p 9092:9092 -p 9005:9005 -p 9006:9006 -p 9443:9443 -p 9444:9444 -p 9445:9445 -p 9446:9446 -p 9765:9765 mplescano/wso2-ei:6.1.1 /bin/bash
#      docker run -it -p 8243:8243 -p 8280:8280 -p 9092:9092 -p 9005:9005 -p 9006:9006 -p 9443:9443 -p 9444:9444 -p 9445:9445 -p 9446:9446 -p 9765:9765 mplescano/wso2-ei:6.1.1 (there is executed CMD section)
#      -d is in mode detached
#      docker run -d -p 9443:9443 -p 9444:9444 -e mplescano/wso2-ei:6.1.1 /bin/bash
#      docker run -d -p 9443:9443 -p 9444:9444 mplescano/wso2-ei:6.1.1 /bin/bash
FROM mplescano/java-debian:7.80.15.jdk

MAINTAINER mplescano@

ADD assets /assets
RUN /assets/setup.debian.sh

#WSO2 EI https://localhost:9443/carbon
EXPOSE 9443
#WSO2 DAS https://localhost:9444/carbon/
EXPOSE 9444
#WSO2 BPS https://localhost:9445/carbon/
EXPOSE 9445
EXPOSE 9765
#WSO2 MB https://localhost:9446/carbon/
EXPOSE 9446
EXPOSE 9766
EXPOSE 5675
EXPOSE 8675
#ESB in Debug mode for super tenant Listen on ports : Command 9005 - Event 9006
EXPOSE 9005
EXPOSE 9006
#H2 Server
EXPOSE 9092
#Axis Server
EXPOSE 8280
EXPOSE 8243
#it's executed when instantiating a container without arguments..
CMD /usr/sbin/service h2-server.sh start && /usr/sbin/service wso2ei-server.sh start && /bin/bash
