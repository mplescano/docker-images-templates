#!/bin/bash
# © Copyright IBM Corporation 2015.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html


#mqsicreatebroker IB9NODE -q IB9QMGR -s active
#The broker creates the authorization queue SYSTEM.BROKER.AUTH. This
#queue is used to define which users are authorized to perform an action on the
#broker.
#The broker also assigns default permissions of inquire, put, and set authority to
#this queue. These permissions grant read, write, and execute authority on the
#broker to all members of the mqbrkrs group. Therefore, you must ensure that at
#least one member of your broker administration team is a member of this
#group.


set -e
#run dspmqaut -m IIB_MQMGR -t qmgr -g mqclient in order to see permission list setting
#run command mqsimode broker_name
#run console mq is runmqsc IIB_MQMGR and issue the command "display queue(SYSTEM.BROKER*)"
#previous IIBV1007
NODE_NAME=${NODE_NAME-IIBV09002}
EXEC_NAME=IS1
export JDBC_SERVICE=BROKER
export HOST_NAME=IIBDOCKER




stop()
{
	echo "----------------------------------------"
	echo "Stopping node $NODE_NAME..."
	mqsistop $NODE_NAME
	echo "Stopping Queue Manager $MQ_QMGR_NAME..."
	endmqm $MQ_QMGR_NAME
}
parameterCheck()
{
  : ${MQ_QMGR_NAME?"ERROR: You need to set the MQ_QMGR_NAME environment variable"}

  # We want to do parameter checking early as then we can stop and error early before it looks
  # like everything is going to be ok (when it won't)
  if [ ! -z ${MQ_TLS_KEYSTORE+x} ]; then
    if [ -z ${MQ_TLS_PASSPHRASE+x} ]; then
      echo "Error: If you supply MQ_TLS_KEYSTORE, you must supply MQ_TLS_PASSPHRASE"
      exit 1;
    fi
  fi
}
config()
{
  # Populate and update the contents of /var/mqm - this is needed for
	# bind-mounted volumes, and also to migrate data from previous versions of MQ

  setup-var-mqm.sh

  #if [ -z "${MQ_DISABLE_WEB_CONSOLE}" ]; then
  #  echo $MQ_ADMIN_PASSWORD
    # Start the web console, if it's been installed
  #  which strmqweb && setup-mqm-web.sh
  #fi

  ls -l /var/mqm
  source /opt/mqm/bin/setmqenv -s
  echo "----------------------------------------"
  dspmqver
  echo "----------------------------------------"

  QMGR_EXISTS=`dspmq | grep ${MQ_QMGR_NAME} > /dev/null ; echo $?`
  if [ ${QMGR_EXISTS} -ne 0 ]; then
    echo "Checking filesystem..."
    amqmfsck /var/mqm
    echo "----https://hub.jazz.net/code/edit/edit.html#/code/file/paj-OrionContent/paj%2520%257C%2520IIB-MQ-DB2/iib_manage.sh------------------------------------"
    MQ_DEV=${MQ_DEV:-"true"}
    if [ "${MQ_DEV}" == "true" ]; then
      # Turns on early adopt if we're using Developer defaults
      export AMQ_EXTRA_QM_STANZAS=Channels:ChlauthEarlyAdopt=Y
    fi
    crtmqm -q ${MQ_QMGR_NAME} || true
    if [ ${MQ_QMGR_CMDLEVEL+x} ]; then
      # Enables the specified command level, then stops the queue manager
      strmqm -e CMDLEVEL=${MQ_QMGR_CMDLEVEL} || true
    fi
    echo "----------------------------------------"
  fi
  strmqm ${MQ_QMGR_NAME}

  # Turn off script failing here because of listeners failing the script
  set +e
  for MQSC_FILE in $(ls -v /etc/mqm/*.mqsc); do
    runmqsc ${MQ_QMGR_NAME} < ${MQSC_FILE}
  done
  set -e

  echo "----------------------------------------"
  mq-dev-config.sh ${MQ_QMGR_NAME}
  echo "----------------------------------------"
}

state()
{
  dspmq -n -m ${MQ_QMGR_NAME} | awk -F '[()]' '{ print $4 }'
}


start()
{
    #su - iibuser << EOF
    source /opt/mqm/bin/setmqenv -s
    /usr/local/bin/iib_env.sh
    # echo "PATH=$PATH"
    echo "----------------------------------------"
    #/opt/ibm/iib-9.0.0.1/iib version
    echo "----------------------------------------"
    echo "NODE_NAME = $NODE_NAME"

  NODE_EXISTS=`mqsilist | grep $NODE_NAME > /dev/null ; echo $?`
  #mqsilist | grep $NODE_NAME > /dev/null
  #NODE_EXISTS=${?}
  echo "NODE_EXISTS = ${NODE_EXISTS}"
  
    if [ ${NODE_EXISTS} -ne 0 ]; then
    #if [ ${?} -ne 0 ]; then
    echo "----------------------------------------"
    echo "Node $NODE_NAME does not exist..."
    echo "Creating node $NODE_NAME"
        #see https://www.ibm.com/support/knowledgecenter/en/SSMKHH_10.0.0/com.ibm.etools.mft.doc/an28135_.htm
        #mqsicreatebroker IB9NODE -q IB9QMGR
        mqsicreatebroker $NODE_NAME -q ${MQ_QMGR_NAME}
		#mqsicreatebroker $NODE_NAME
		mqsistart $NODE_NAME
		mqsicreateexecutiongroup $NODE_NAME -e $EXEC_NAME
		mqsistop $NODE_NAME
		#other option
        #see https://developer.ibm.com/integration/docs/ibm-integration-bus/get-started/get-started-with-ibm-integration-bus-for-developers/installing-websphere-mq-for-use-with-ibm-integration-bus-for-developers/
        #./iib_createqueues.sh IIB_MQMGR mqbrkrs
        #mqsistop -i IIBV1007
        #mqsichangebroker IIBV1007 -q IIB_MQMGR
    echo "----------------------------------------"
	fi
	echo "----------------------------------------"
    echo "PATH=$PATH"
	echo "Starting syslog"
  sudo /usr/sbin/rsyslogd
  	echo "PATH=$PATH"
  	echo "Configuring db access"
  	mqsisetdbparms $NODE_NAME -n BROKER -u sa -p passw0rd
  	
	echo "Starting node $NODE_NAME"
  	
  	mqsistart $NODE_NAME
	echo "----------------------------------------"
	
  	
  	#echo "Starting Switch Server"
  	#SWITCH_EXISTS=`iibswitch create switch -c /home/iibuser/switch.json | grep "already" | wc -l`
  	#if [ ${SWITCH_EXISTS} -eq 0 ] ; then
  	#	echo "S starting Switch"
  	#	iibswitch start switch -c /home/iibuser/switch.json
  	#fi
  	#mqsichangeproperties $NODE_NAME -e $EXEC_NAME -o ComIbmIIBSwitchManager -n agentXConfigFile -p /home/iibuser/agentx.json
  	#mqsistop $NODE_NAME
  	#mqsistart $NODE_NAME

#EOF
}

monitor()
{
	# Loop until "dspmq" says the queue manager is running
  until [ "`state`" == "RUNNING" ]; do
    sleep 1
  done
  dspmq
  echo "IBM MQ Queue Manager ${MQ_QMGR_NAME} is now fully running"
  # Loop until "dspmq" says the queue manager is not running any more
  #until [ "`state`" != "RUNNING" ]; do
  #  sleep 5
  #done
#	echo "----------------------------------------"
#	echo "Running - stop container to exit"
	# Loop forever by default - container must be stopped manually.
  # Here is where you can add in conditions controlling when your container will exit - e.g. check for existence of specific processes stopping or errors being reported
#	while true; do
#		sleep 1
#	done
}
mq-license-check.sh
parameterCheck
config
iib-license-check.sh
start
trap stop SIGTERM SIGINT
monitor
