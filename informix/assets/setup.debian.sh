#!/bin/bash
#
#see https://www.cursor-distribution.de/aktuell.12.10.xC1/documentation/ids_ix_bookmap.pdf
apt-get update &&
apt-get install -y file libaio1 expect expect-dev &&
rm -rf /var/lib/apt/lists/* &&
groupadd --system informix &&
useradd --system -m -d /opt/informix -g informix informix &&
echo "informix:informix" | chpasswd &&
cd /assets/ &&
tar xf iif.12.10.FC8DE.linux-x86_64.tar &&
export INFORMIXDIR=/opt/informix &&
touch /etc/profile.d/env_informix.sh &&
echo "export INFORMIXDIR=/opt/informix" > /etc/profile.d/env_informix.sh &&
/assets/ids_install_informix.exp &&
#response.properties dont work for minimal configuration
#/assets/ids_install -i silent -f /assets/response.properties &&
cp -rf /assets/startup.sh /usr/sbin/ &&
chmod +x /usr/sbin/startup.sh &&
cp -rf /assets/sqlhosts.ol_informix1210.std /opt/informix/etc &&
chmod 440 /opt/informix/etc/sqlhosts.ol_informix1210.std &&
cp -rf /assets/ol_informix1210.sh /opt/informix/ 
chown informix:informix /opt/informix/etc/sqlhosts.ol_informix1210.std &&
#for the first time, for the next on use oninit alone
su - informix -c ". /opt/informix/ol_informix1210.sh && printf 'y\\n'|oninit -i" &&
su - informix -c ". /opt/informix/ol_informix1210.sh && printf 'y\\n'|dbaccessdemo" &&
#If you would later like to bring the server down, then the following command can be issued:
#'.' is the equivalente of source in /bin/sh
su - informix -c ". /opt/informix/ol_informix1210.sh && onmode -kuy" &&
#Try to bring up the server: 
#oninit -i
#su - informix -c ". /opt/informix/ol_informix1210.sh && oninit -i"
#su - root -c "source /opt/informix/ol_informix1210.sh && oninit -i"
#Launch oninit -ivy for more details or see log on your MSGPATH file.
#Check to make sure it came up correctly by using the following command: 
#onstat -
rm -rf /assets/