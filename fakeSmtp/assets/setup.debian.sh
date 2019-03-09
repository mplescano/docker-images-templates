#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive &&

apt-get update -q &&

apt-get install -q -y unzip &&

mkdir /opt/fakeSMTP &&

mkdir /opt/fakeSMTP/2.0 &&

unzip /assets/fakeSMTP-latest.zip -d /opt/fakeSMTP/2.0 &&

mv /opt/fakeSMTP/2.0/fakeSMTP-2.0.jar /opt/fakeSMTP/2.0/fakeSMTP.jar &&

# Remove installation files
rm -r /assets/

exit $?
