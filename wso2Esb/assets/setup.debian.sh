#!/bin/bash

apt-get update -q &&
apt-get install -q -y ca-certificates curl unzip &&

useradd -md /opt/wso2 wso2 &&
printf 'wso2\nwso2\n'|passwd wso2 &&

#curl -jksSLH "Cookie: SSESSaef076ccd0010a62ad204370ca11c7d9=qz3P1vfFNA8jE2Hrs4nUOlyBIFHVo5jZk31f69UtV5E" -H "Referer: http://wso2.com/products/enterprise-service-bus/" -o /tmp/wso2esb-5.0.0.zip \
#      https://product-dist.wso2.com/products/enterprise-service-bus/5.0.0/wso2esb-5.0.0.zip &&
#curl -jksSLH "Cookie: SSESSaef076ccd0010a62ad204370ca11c7d9=qz3P1vfFNA8jE2Hrs4nUOlyBIFHVo5jZk31f69UtV5E" -H "Referer: http://wso2.com/products/enterprise-service-bus/" -o /tmp/wso2esb-analytics-5.0.0.zip \
#       http://product-dist.wso2.com/downloads/enterprise-service-bus/5.0.0/wso2esb-analytics-5.0.0.zip
#su - wso2 -c "unzip -o -d /opt/wso2 /tmp/wso2esb-5.0.0.zip" &&
#su - wso2 -c "unzip -o -d /opt/wso2 /tmp/wso2esb-analytics-5.0.0.zip" &&
su - wso2 -c "unzip -o -d /opt/wso2 /assets/wso2esb-5.0.0.zip" &&
su - wso2 -c "unzip -o -d /opt/wso2 /assets/wso2esb-analytics-5.0.0.zip" &&
su - wso2 -c "mv /opt/wso2/wso2esb-5.0.0 /opt/wso2/esb-5.0.0" &&
su - wso2 -c "ln -s /opt/wso2/esb-5.0.0 /opt/wso2/esb" &&
cp -f /assets/synapse.properties /opt/wso2/esb/repository/conf/synapse.properties &&
su - wso2 -c "mv /opt/wso2/wso2esb-analytics-5.0.0 /opt/wso2/esb-analytics-5.0.0" &&
su - wso2 -c "ln -s /opt/wso2/esb-analytics-5.0.0 /opt/wso2/esb-analytics" &&
chown -R wso2:wso2 /opt/wso2/* &&
cp /assets/wso2esb-server.sh /etc/init.d/ &&
cp /assets/wso2esb-analytics.sh /etc/init.d/ &&
chmod a+x /etc/init.d/wso2esb-server.sh &&
chmod a+x /etc/init.d/wso2esb-analytics.sh &&
update-rc.d wso2esb-server.sh defaults &&
update-rc.d wso2esb-analytics.sh defaults &&
rm -rf /tmp/* &&
rm -rf /assets &&
apt-get remove --purge -y ca-certificates curl unzip &&
apt-get autoremove --purge -y &&
apt-get clean

exit $?