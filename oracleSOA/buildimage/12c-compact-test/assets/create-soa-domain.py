debug("true")
# Compact domain is file based, SOA Composer will not edit --> See: Convert QS Domain File-Based MDS to DB-based (https://thecattlecrew.wordpress.com/2014/11/06/bpm-12c-file-based-mds-to-db-based-mds-in-compact-domain/)
domain_mode = 'Compact'
#domain_mode  = 'Expanded'
domain_name  = os.environ.get("DOMAIN_NAME", 'soa_devdomain')
domain_template = 'base_domain'
admin_port   = int(os.environ.get("ADMIN_PORT", '7001'))
admin_pass   = os.environ.get("ADMIN_PASSWORD", 'welcome1')
domain_path  = '/u01/app/oracle/user_projects/domains/' + domain_name
# hostname_db = os.environ.get("HOSTNAME", 'localhost')
hostname_db = 'localhost'

SOA_REPOS_DBURL          = 'jdbc:oracle:thin:@' + hostname_db + ':1521:XE'
SOA_REPOS_DBUSER_PREFIX  = 'DEV'
SOA_REPOS_DBPASSWORD     = 'welcome1'

def modifyServer(beanName, machine, listenPort):
    #nullClusterBean = getMBean("null")
    cd('/Servers/' + beanName)
    set('Machine'      ,machine)
    set('ListenPort', listenPort)
    #cmo.setCoherenceClusterSystemResource(nullClusterBean)

def alterDatasource(datasource_name, db_url, db_schema, db_password):
    print 'Change datasource ' + datasource_name
    cd('/')
    cd('/JDBCSystemResource/' + datasource_name + '/JdbcResource/' + datasource_name + '/JDBCConnectionPoolParams/NO_NAME_0');
    cmo.setInitialCapacity(1)
    cmo.setMaxCapacity(15)
    cmo.setMinCapacity(1)
    cmo.setStatementCacheSize(0)
    cmo.setTestConnectionsOnReserve(java.lang.Boolean('false'))
    cmo.setTestTableName('SQL SELECT 1 FROM DUAL')
    cmo.setConnectionCreationRetryFrequencySeconds(30)
    cd('/JDBCSystemResource/' + datasource_name + '/JdbcResource/' + datasource_name + '/JDBCDriverParams/NO_NAME_0')
    set('URL', db_url)
    set('PasswordEncrypted', db_password)
    cd('Properties/NO_NAME_0/Property/user')
    set('Value', db_schema)
    cd('/')

def changeDatasourceToXA(datasource):
  print 'Change datasource '+datasource
  cd('/')
  cd('/JDBCSystemResource/'+datasource+'/JdbcResource/'+datasource+'/JDBCDriverParams/NO_NAME_0')
  set('DriverName','oracle.jdbc.xa.client.OracleXADataSource')
  set('UseXADataSourceInterface','True') 
  cd('/JDBCSystemResource/'+datasource+'/JdbcResource/'+datasource+'/JDBCDataSourceParams/NO_NAME_0')
  set('GlobalTransactionsProtocol','TwoPhaseCommit')
  cd('/')

print 'Read template'
readTemplate('/u01/app/oracle/middleware/wlserver/common/templates/wls/wls.jar', domain_mode)
# Add the second template, in this example, the Web Services template
# addTemplate('/scratch/leturme/wls1213/oracle_common/common/templates/wls/oracle.wls-webservice-template_12.1.3.jar')
# addTemplate('c:/Oracle/Middleware/wlserver/common/templates/wls/DefaultWebApp.jar')

#create('defaultCoherenceCluster', 'CoherenceClusterSystemResource')
#nullClusterBean = getMBean("null")

print('Create machine LocalMachine with type Machine')
cd('/')
create('LocalMachine','Machine')
cd('Machines/LocalMachine')
create('LocalMachine','NodeManager')
cd('NodeManager/LocalMachine')
set('ListenAddress', 'localhost')
set('ListenPort', 5556)

#print 'Set server AdminServer'
#modifyServer("AdminServer", 'LocalMachine')

#cd('/Servers/AdminServer')
#set('Machine'      ,'LocalMachine')
#set('ListenAddress','')
#set('ListenPort', admin_port)
#set('CoherenceClusterSystemResource', 'defaultCoherenceCluster')
#set('CoherenceClusterSystemResource', nullClusterBean)
#cmo.setCoherenceClusterSystemResource(nullClusterBean)

#cd('CoherenceClusterSystemResource/defaultCoherenceCluster/CoherenceResource/defaultCoherenceCluster/CoherenceClusterParams/NO_NAME_0')
#set('ClusteringMode', 'unicast')
#set('SecurityFrameworkEnabled','false')
#set('UnicastListenAddress', '127.0.0.1')
#set('UnicastListenPort', 9321)
#set('UnicastPortAutoAdjust', 'true')

print 'Set security'
cd('/')
cd('Security/' + domain_template + '/User/weblogic')
cmo.setPassword(admin_pass)
setOption('OverwriteDomain', 'true')
setOption('ServerStartMode', 'dev')

print 'Write domain'
writeDomain(domain_path)
closeTemplate()

print 'Adding Templates'
readDomain(domain_path)
#addTemplate('/u01/app/oracle/middleware/oracle_common/common/templates/wls/oracle.wls-webservice-template_12.1.3.jar')
addTemplate('/u01/app/oracle/middleware/osb/common/templates/wls/oracle.osb_template_12.1.3.jar')
addTemplate('/u01/app/oracle/middleware/soa/common/templates/wls/oracle.soa_template_12.1.3.jar')
addTemplate('/u01/app/oracle/middleware/soa/common/templates/wls/oracle.bam.server_template_12.1.3.jar')
addTemplate('/u01/app/oracle/middleware/soa/common/templates/wls/oracle.bpm_template_12.1.3.jar')
#addTemplate('/u01/app/oracle/middleware/oracle_common/common/templates/wls/oracle.ess.basic_template_12.1.3.jar')
#addTemplate('/u01/app/oracle/middleware/em/common/templates/wls/oracle.em_ess_template_12.1.3.jar')

dumpStack()

#already created by the templates
#modifyServer("bam_server1", 'LocalMachine', 7005)
#modifyServer("osb_server1", 'LocalMachine', 7003)
#modifyServer("soa_server1", 'LocalMachine', 7004)

print 'Change datasources'
#print 'Change datasource LocalScvTblDataSource'
#cd('/JDBCSystemResource/LocalSvcTblDataSource/JdbcResource/LocalSvcTblDataSource/JDBCDriverParams/NO_NAME_0')
#set('URL',SOA_REPOS_DBURL)
#set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
#cd('Properties/NO_NAME_0/Property/user')
#set('Value',SOA_REPOS_DBUSER_PREFIX+'_STB')
alterDatasource('LocalSvcTblDataSource', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_STB', SOA_REPOS_DBPASSWORD)

print 'Call getDatabaseDefaults which reads the service table'
getDatabaseDefaults()
changeDatasourceToXA('EDNDataSource')
changeDatasourceToXA('wlsbjmsrpDataSource')
changeDatasourceToXA('OraSDPMDataSource')
changeDatasourceToXA('SOADataSource')
changeDatasourceToXA('BamDataSource')

alterDatasource('opss-data-source', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_OPSS', SOA_REPOS_DBPASSWORD)
alterDatasource('opss-audit-viewDS', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_IAU_VIEWER', SOA_REPOS_DBPASSWORD)
alterDatasource('opss-audit-DBDS', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_IAU_APPEND', SOA_REPOS_DBPASSWORD)
alterDatasource('mds-soa', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_MDS', SOA_REPOS_DBPASSWORD)
alterDatasource('mds-owsm', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_MDS',  SOA_REPOS_DBPASSWORD)
alterDatasource('mds-bam', SOA_REPOS_DBURL, SOA_REPOS_DBUSER_PREFIX + '_MDS',  SOA_REPOS_DBPASSWORD)

#cd('/')
#create('bam_server1', 'Server')
#cd('/Servers/' + 'bam_server1')
#set('Machine'      ,'LocalMachine')
#set('ListenAddress','')
#set('ListenPort'   ,9001)
#set('CoherenceClusterSystemResource', 'defaultCoherenceCluster')
#set('CoherenceClusterSystemResource', nullClusterBean)
#cmo.setCoherenceClusterSystemResource(nullClusterBean)

updateDomain()
closeDomain()

exit()