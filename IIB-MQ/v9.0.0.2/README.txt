#query the config
#enter as id mqm
#exucute this first
. /opt/mqm/bin/setmqenv -s
. /opt/iib/current/bin/mqsiprofile
#then
runmqsc IIB_MQMGR
#then
display channel (*)
display channel (SYSTEM.DEF.SVRCONN)
display channel (SYSTEM.ADMIN.SVRCONN)
display channel (SYSTEM.BKR.CONFIG)
display CHLAUTH (*)
display CHLAUTH (SYSTEM.ADMIN.SVRCONN)
display CHLAUTH (SYSTEM.BKR.CONFIG)
#if you want to disable authentication mess
ALTER QMGR CHLAUTH(DISABLED)
#see https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_7.5.0/com.ibm.mq.mig.doc/q001110_.htm
#to quit
end

#see the logs
cd /var/mqm/qmgrs/IIB_MQMGR/errors
cat AMQERR01.LOG
nano AMQERR01.LOG

#add user remote for windows
#<user_windows> of 12 chars even when in windows could have more then 12 chars.
useradd --create-home --home-dir /home/<user_windows> --gid mqbrkrs  -G mqm,sudo <user_windows>


##############################


. /opt/iib/current/bin/mqsiprofile

mqsimode -i localhost -p 1414 -q IIB_MQMGR 

dspmqaut -m IIB_MQMGR -t qmgr -p njoaquin.programador

dspmqaut -m IIB_MQMGR -t qmgr -p mqm

dspmqaut -m IIB_MQMGR -t qmgr -g mqbrkrs


dspmqaut -m IIB_MQMGR -t queue -n SYSTEM.BROKER.AUTH -g mqbrkrs
dspmqaut -m IIB_MQMGR -t queue -n SYSTEM.BROKER.AUTH -p iibuser
dspmqaut -m IIB_MQMGR -t qmgr -p mqm 



iptables -t nat -A DOCKER -p tcp --dport 8453 -j DNAT --to-destination 172.17.0.3:8453
iptables -t nat -A POSTROUTING -j MASQUERADE -p tcp --source 172.17.0.3 --destination 172.17.0.3 --dport 8453
iptables -A DOCKER -j ACCEPT -p tcp --destination 172.17.0.3 --dport 8453



useradd --uid 3003 --gid 1000 -G 1001 -m --home /home/njoaquin.programador njoaquin.programador
useradd --uid 3002 --gid 1000 -G mqbrkrs,sudo -m --home-dir /home/iibuser iibuser
su -l mqm -c "setmqaut -m IIB_MQMGR -t qmgr -g mqbrkrs +connect +inq +dsp"

# DEFINE CHANNEL('SYSTEM.BKR.CONFIG') CHLTYPE(SVRCONN) REPLACE


SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(BLOCKUSER) USERLIST('nobody') DESCR('Allows admins on ADMIN channel') ACTION(REPLACE)
#SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('njoaquin.programador') USERSRC(CHANNEL) DESCR('Allows admin user to connect via ADMIN channel') ACTION(REPLACE)
#SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('*ramador') USERSRC(CHANNEL) DESCR('Allows admin user to connect via ADMIN channel') ACTION(REPLACE)
#SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('njoaquin.programador') MCAUSER('iibuser') USERSRC(CHANNEL) DESCR('Allows admin user to connect via ADMIN channel') ACTION(REPLACE)
#SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('iibuser') USERSRC(CHANNEL) DESCR('Allows admin user to connect via ADMIN channel') ACTION(REPLACE)
#If you set the MCAUSER attribute, then any incoming request from the IBM Integration Toolkit or the IBM Integration Explorer is processed by the broker as 
#if it was made by the user that is specified in the MCAUSER attribute, instead of the user that is running the IBM Integration Toolkit or the IBM Integration Explorer.


SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('njoaquin') MCAUSER('iibuser') USERSRC(MAP) DESCR('Allows admin user to connect via ADMIN channel') ACTION(REPLACE)
#SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('njoaquin.programador') MCAUSER('iibuser') USERSRC(MAP) DESCR('Allows admin user to connect via ADMIN channel') ACTION(REPLACE)


DEFINE CHANNEL('SYSTEM.BKR.CONFIG') CHLTYPE(SVRCONN) REPLACE
SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(ADDRESSMAP) ADDRESS('*') USERSRC(CHANNEL) DESCR('Allows connection via APP channel') ACTION(REPLACE)
ALTER CHANNEL('SYSTEM.BKR.CONFIG') CHLTYPE(SVRCONN) MCAUSER('iibuser')


SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('iibuser') ACTION(REMOVE)
SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(USERMAP) CLNTUSER('njoaquin') ACTION(REMOVE)
SET CHLAUTH('SYSTEM.BKR.CONFIG') TYPE(BLOCKUSER) USERLIST('nobody')  ACTION(REMOVE)