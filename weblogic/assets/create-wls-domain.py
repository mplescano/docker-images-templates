

domain_name  = os.environ.get("DOMAIN_NAME", 'base_devdomain')
domain_template = 'base_domain'
admin_port   = int(os.environ.get("ADMIN_PORT", '7001'))
admin_pass   = os.environ.get("ADMIN_PASSWORD", 'welcome1')
domain_path  = '/u01/app/oracle/user_projects/domains/' + domain_name

readTemplate('/u01/app/oracle/middleware/wlserver/common/templates/wls/wls.jar')
# Add the second template, in this example, the Web Services template
# addTemplate('/scratch/leturme/wls1213/oracle_common/common/templates/wls/oracle.wls-webservice-template_12.1.3.jar')
# addTemplate('c:/Oracle/Middleware/wlserver/common/templates/wls/DefaultWebApp.jar')

cd('/Servers/AdminServer')
set('ListenAddress','')
set('ListenPort', admin_port)

cd('/')
cd('Security/' + domain_template + '/User/weblogic')
cmo.setPassword(admin_pass)
setOption('OverwriteDomain', 'true')

writeDomain(domain_path)
closeTemplate()
exit()
