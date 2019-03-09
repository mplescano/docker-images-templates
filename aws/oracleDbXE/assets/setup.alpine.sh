#!/bin/bash

# avoid dpkg frontend dialog / frontend warnings
export DEBIAN_FRONTEND=noninteractive

cat /assets/oracle-xe_11.2.0-1.0_amd64.deba* > /assets/oracle-xe_11.2.0-1.0_amd64.deb

# Install OpenSSH
#apt-get update &&
#apt-get install -y openssh-server &&
#mkdir /var/run/sshd &&
#echo 'root:admin' | chpasswd &&
#sed -i 's/^PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config &&
#sed -i 's/session\s*required\s*pam_loginuid.so/session optional pam_loginuid.so/g' /etc/pam.d/sshd &&
#echo 'export VISIBLE=now' >> /etc/profile &&

#Prepare to install Oracle
#apt-get install -y libaio1 net-tools bc &&
apk update &&
apk upgrade --update &&
apk add --update tar &&
apk add libaio net-tools bc dpkg &&
apk --no-cache add busybox-suid &&
touch /var/lib/dpkg/status &&
dpkg --configure -a &&
dpkg --add-architecture amd64 &&
ln -s /usr/bin/awk /bin/awk &&
#mkdir /var/lock/subsys &&
mv /assets/chkconfig /sbin/chkconfig &&
chmod 755 /sbin/chkconfig &&

# Install Oracle
dpkg --install /assets/oracle-xe_11.2.0-1.0_amd64.deb &&

# Backup listener.ora as template
cp /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora.tmpl &&
cp /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora.tmpl &&

mv /assets/init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts &&
mv /assets/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts &&

#see https://docs.oracle.com/cd/E17781_01/install.112/e18802/toc.htm#XEINL122
#A valid HTTP port for the Oracle Application Express (the default is 8080)
#A valid port for the Oracle database listener (the default is 1521)
#A password for the SYS and SYSTEM administrative user accounts
#Confirm password for SYS and SYSTEM administrative user accounts
#Whether you want the database to start automatically when the computer starts (next reboot)
printf 8080\\n1521\\nwelcome1\\nwelcome1\\ny\\n | /etc/init.d/oracle-xe configure &&

echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc &&
echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc &&
echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc &&

# Install startup script for container
mv /assets/startup.sh /usr/sbin/startup.sh &&
chmod +x /usr/sbin/startup.sh &&

# Remove installation files
rm -r /assets/


exit $?
