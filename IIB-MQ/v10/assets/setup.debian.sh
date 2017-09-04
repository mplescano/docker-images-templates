#!/bin/bash
#
#
#ARG MQ_URL=http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev902_linux_x86-64.tar.gz
#curl http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/10.0.0.7-IIB-LINUX64-DEVELOPER.tar.gz 
export MQ_PACKAGES="MQSeriesRuntime-*.rpm MQSeriesServer-*.rpm MQSeriesMsg*.rpm MQSeriesJava*.rpm MQSeriesJRE*.rpm MQSeriesGSKit*.rpm MQSeriesWeb*.rpm MQSeriesSamples*.rpm" && \
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
    rsyslog &&
    
rm -rf /var/lib/apt/lists/* &&

#apt-get dist-upgrade -y &&

cd /assets/mq && \
	tar -zxvf ./mqadv_dev902_linux_x86-64.tar.gz && \
	groupadd --gid 1000 mqm && \
  	useradd --create-home --home-dir /home/mqm --uid 1000 --gid mqm mqm && \
  	usermod -G mqm root && \
    cd /assets/mq/MQServer && \
    sed -i 's/UNAME_FLAG=-i/UNAME_FLAG=-m/' ./mqlicense.sh &&

# Accept the MQ license
/assets/mq/MQServer/mqlicense.sh -text_only -accept && \
    # Install MQ using the RPM packages
    rpm -ivh --force-debian $MQ_PACKAGES && \
    # Recommended: Set the default MQ installation (makes the MQ commands available on the PATH)
    /opt/mqm/bin/setmqinst -p /opt/mqm -i && \
    # Clean up all the downloaded files
    rm -rf /var/lib/apt/lists/* && \
    # rm -rf /var/mqm && 
    cp /assets/usr_local_bin_mq/* /usr/local/bin/ && \
    sed -i 's/password\t\[success=1 default=ignore\]\tpam_unix\.so obscure sha512/password\t[success=1 default=ignore]\tpam_unix.so obscure sha512 minlen=8/' /etc/pam.d/common-password && \
    mkdir /etc/mqm && \
    cp /assets/etc_mqm/* /etc/mqm/ && \
    chmod +x /usr/local/bin/*.sh &&
    
cd /assets/iib && \
    mkdir /opt/ibm && \
    tar -zxvf ./10.0.0.8-IIB-LINUX64-DEVELOPER.tar.gz && \
    rm -Rf ./iib-10.0.0.8/tools && \
    mv ./iib-10.0.0.8 /opt/ibm && \
    #&& tar zx --exclude iib-10.0.0.8/tools --directory /opt/ibm 
    /opt/ibm/iib-10.0.0.8/iib make registry global accept license silently &&
    
cd /assets && \
    echo "IIB_10:" > /etc/debian_chroot && \
    touch /var/log/syslog && \
    # && chown syslog:adm /var/log/syslog 
    chmod +x /assets/kernel_settings.sh;sync && \
    /assets/kernel_settings.sh &&
    
useradd --create-home --home-dir /home/iibuser -G mqbrkrs,sudo,mqm iibuser && \
    sed -e 's/^%sudo	.*/%sudo	ALL=NOPASSWD:ALL/g' -i /etc/sudoers &&
    
# Copy in script files
cp /assets/usr_local_bin_iib/* /usr/local/bin/ && \
    cp -f /assets/etc/* /etc/ &&

cp /assets/iibuser/* /home/iibuser/ &&

chgrp mqbrkrs /home/iibuser/agentx.json && \
 chown iibuser /home/iibuser/agentx.json && \
 chgrp mqbrkrs /home/iibuser/switch.json && \
 chown iibuser /home/iibuser/switch.json && \
 chmod +r /home/iibuser/agentx.json && \
 chmod +r /home/iibuser/switch.json && \
 chgrp mqbrkrs /etc/odbc.ini && \
 chown iibuser /etc/odbc.ini && \
 chmod 664 /etc/odbc.ini && \
 chmod +rx /usr/local/bin/*.sh && \
 chmod 666 /etc/hosts &&

rm -rf /assets/