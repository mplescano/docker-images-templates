#!/bin/bash
#
#
#ARG MQ_URL=http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev902_linux_x86-64.tar.gz
#curl http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/10.0.0.7-IIB-LINUX64-DEVELOPER.tar.gz 
export MQ_PACKAGES="MQSeriesRuntime-*.rpm MQSeriesServer-*.rpm MQSeriesMsg*.rpm MQSeriesJava*.rpm MQSeriesJRE*.rpm MQSeriesGSKit*.rpm MQSeriesSamples*.rpm" && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    bash \
    bc \
    coreutils \
    curl \
    debianutils \
    findutils \
    gawk \
    grep \
    libc-bin \
    lsb-release \
    mount \
    passwd \
    procps \
    rpm \
    sed \
    tar \
    util-linux \
    sudo \
    telnet \
    net-tools \
    nano \
    unzip \
    zip \
    rsyslog &&
    
rm -rf /var/lib/apt/lists/* &&

#apt-get dist-upgrade -y &&

cd /assets/iib && \
    mkdir /assets/iib/mq-fixes && \
    tar -zxvf ./7.5.0-WS-MQ-LinuxX64-FP0008.tar.gz -C ./mq-fixes && \
	tar -zxvf ./9.0.0-IIB-LINUXX64-DEVELOPER-RUNTIME.tar.gz && \
	groupadd --gid 1000 mqm && \
  	useradd --create-home --home-dir /home/mqm --uid 1000 --gid mqm mqm && \
  	usermod -G mqm root && \
    cd /assets/iib/integrationbus_developer/WebSphere_MQ && \
    mkdir /usr/lib64 && 

# Accept the MQ license
/assets/iib/integrationbus_developer/WebSphere_MQ/mqlicense.sh -text_only -accept && \
    # Install MQ using the RPM packages
    rpm -ivh --force-debian $MQ_PACKAGES && \
    cd /assets/iib/mq-fixes && \
    rpm -ivh --force-debian $MQ_PACKAGES && \
    # Recommended: Set the default MQ installation (makes the MQ commands available on the PATH)
    /opt/mqm/bin/setmqinst -p /opt/mqm -i && \
    # Clean up all the downloaded files
    rm -rf /var/lib/apt/lists/* && \
    # rm -rf /var/mqm && 
    cp /assets/usr_local_bin_mq/9-listener.mqsc /opt/mqm/ && \
    cp /assets/usr_local_bin_mq/setup-var-mqm.sh /opt/mqm/ && \
    sed -i 's/password\t\[success=1 default=ignore\]\tpam_unix\.so obscure sha512/password\t[success=1 default=ignore]\tpam_unix.so obscure sha512 minlen=8/' /etc/pam.d/common-password && \
    # mkdir /etc/mqm && 
    # cp /assets/etc_mqm/* /etc/mqm/ &&
    # chmod +x /usr/local/bin/*.sh &&
    cp -f /assets/usr_local_bin_mq/mq-server.init /etc/init.d/mq-server && \
    chown -R mqm:mqm /opt/mqm/* && \
    update-rc.d mq-server defaults && \
    export LIBPATH=/usr/lib64 &&
    
cd /assets/iib/integrationbus_developer && \
    mkdir /opt/iib && \
    #rm -Rf ./iib-10.0.0.8/tools && 
    # mv ./iib-10.0.0.8 /opt/ibm &&
    #&& tar zx --exclude iib-10.0.0.8/tools --directory /opt/ibm 
    # /opt/ibm/iib-10.0.0.8/iib make registry global accept license silently &&
    ./setuplinuxx64.bin -i silent -f /assets/iib/install.rsp && \
    #cat /var/mqsi/WMBDBE_201.log &&
    touch /etc/ld.so.conf.d/iib-server.conf && \
    ln -s /opt/iib/9.0.0.2 /opt/iib/current && \
    echo "/opt/iib/current/lib" >> /etc/ld.so.conf.d/iib-server.conf && \
    echo "/opt/iib/current/xml4c/lib" >> /etc/ld.so.conf.d/iib-server.conf && \
    echo "/opt/iib/current/jre17/bin/j9vm" >> /etc/ld.so.conf.d/iib-server.conf && \
    echo "/opt/iib/current/xlxpc/lib" >> /etc/ld.so.conf.d/iib-server.conf && \
    sudo ldconfig &&

cd /assets && \
    echo "IIB_9:" > /etc/debian_chroot && \
    touch /var/log/syslog && \
    # && chown syslog:adm /var/log/syslog 
    chmod +x /assets/kernel_settings.sh;sync && \
    /assets/kernel_settings.sh &&
    
#useradd --uid 3002 -g mqm -G mqbrkrs,sudo -m --home-dir /opt/iib iibuser &&
useradd --create-home --home-dir /home/iibuser --gid mqbrkrs  -G mqm,sudo iibuser && 
    usermod -G mqbrkrs,sudo mqm && \
    cp -f /assets/usr_local_bin_iib/iib-server.init /etc/init.d/iib-server && \
    cp -f /assets/usr_local_bin_iib/9-activate.mqsc /opt/iib/current && \
    chown -R mqm:mqbrkrs /opt/iib && \
    update-rc.d iib-server defaults && \
    sed -e 's/^%sudo	.*/%sudo	ALL=NOPASSWD:ALL/g' -i /etc/sudoers && 
    
# Copy in script files
#cp /assets/usr_local_bin_iib/* /usr/local/bin/ && 
#    cp -f /assets/etc/* /etc/ &&

#cp /assets/iibuser/* /home/iibuser/ &&

#chgrp mqbrkrs /home/iibuser/agentx.json && 
# chown iibuser /home/iibuser/agentx.json && 
# chgrp mqbrkrs /home/iibuser/switch.json && 
# chown iibuser /home/iibuser/switch.json && 
# chmod +r /home/iibuser/agentx.json && 
# chmod +r /home/iibuser/switch.json && 
# chgrp mqbrkrs /etc/odbc.ini && 
# chown iibuser /etc/odbc.ini && 
# chmod 664 /etc/odbc.ini && 
# chmod +rx /usr/local/bin/*.sh && 
# chmod 666 /etc/hosts &&

/assets/hsqldb/setup.hsqldb.sh &&

rm -rf /assets/