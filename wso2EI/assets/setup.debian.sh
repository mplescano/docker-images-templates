#!/bin/bash

apt-get update -q &&
apt-get install -q -y ca-certificates curl unzip nano net-tools telnet &&

useradd -md /opt/wso2 wso2 &&
printf 'wso2\nwso2\n'|passwd wso2 &&

#curl -jksSLH "Cookie: SSESSaef076ccd0010a62ad204370ca11c7d9=qz3P1vfFNA8jE2Hrs4nUOlyBIFHVo5jZk31f69UtV5E" -H "Referer: http://wso2.com/products/enterprise-service-bus/" -o /tmp/wso2esb-5.0.0.zip \
#      https://product-dist.wso2.com/products/enterprise-service-bus/5.0.0/wso2esb-5.0.0.zip &&
#curl -jksSLH "Cookie: SSESSaef076ccd0010a62ad204370ca11c7d9=qz3P1vfFNA8jE2Hrs4nUOlyBIFHVo5jZk31f69UtV5E" -H "Referer: http://wso2.com/products/enterprise-service-bus/" -o /tmp/wso2esb-analytics-5.0.0.zip \
#       http://product-dist.wso2.com/downloads/enterprise-service-bus/5.0.0/wso2esb-analytics-5.0.0.zip
#su - wso2 -c "unzip -o -d /opt/wso2 /tmp/wso2esb-5.0.0.zip" &&
#su - wso2 -c "unzip -o -d /opt/wso2 /tmp/wso2esb-analytics-5.0.0.zip" &&
su - wso2 -c "unzip -o -d /opt/wso2 /assets/wso2ei-6.1.1.zip" &&
su - wso2 -c "mv /opt/wso2/wso2ei-6.1.1 /opt/wso2/ei-6.1.1" &&
su - wso2 -c "ln -s /opt/wso2/ei-6.1.1 /opt/wso2/ei" &&
chown -R wso2:wso2 /opt/wso2/* &&
cp /assets/wso2ei-server.sh /etc/init.d/ &&
chmod a+x /etc/init.d/wso2ei-server.sh &&
update-rc.d wso2ei-server.sh defaults &&

su - wso2 -c "mkdir /opt/wso2/h2-1.3.175" &&
su - wso2 -c "ln -s /opt/wso2/h2-1.3.175 /opt/wso2/h2" &&
su - wso2 -c "mkdir /opt/wso2/h2/lib" &&
su - wso2 -c "mkdir /opt/wso2/h2/data" &&
su - wso2 -c "cp -f /opt/wso2/ei/wso2/components/default/configuration/org.eclipse.osgi/bundles/68/1/.cp/h2-1.3.175.jar /opt/wso2/h2-1.3.175/lib" &&
cp /assets/h2-server.sh /etc/init.d/ &&
chmod a+x /etc/init.d/h2-server.sh &&
update-rc.d h2-server.sh defaults &&

rm -rf /tmp/* &&
rm -rf /assets &&
apt-get remove --purge -y ca-certificates curl unzip &&
apt-get autoremove --purge -y &&
apt-get clean

exit $?