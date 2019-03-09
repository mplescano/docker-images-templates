#!/usr/bin/expect -f
#
#see http://www.admin-magazine.com/Articles/Automating-with-Expect-Scripts
#see http://www.wellho.net/mouth/1403_Square-Bracket-protection-in-Tcl.html
#see https://sourceforge.net/p/expect/discussion/41514/thread/da0e123a/?limit=25
#see https://linuxaria.com/howto/2-practical-examples-of-expect-on-the-linux-cli
#see http://stackoverflow.com/questions/30917857/autoexpect-on-docker-centos6-6-container-cannot-work
set timeout 60
spawn "/u01/app/oracle/middleware/soa/common/bin/config.sh"
expect {
	timeout exit
	"Enter index number to select OR \\\[Exit\\\]\\\[Next\\\]>"
}
send "next\r"
expect {
	timeout exit
	"Enter index number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send "next\r"
expect {
	timeout exit
	"Enter number exactly as it appears in brackets to toggle selection OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
send "2\r"
expect {
	timeout exit
	"Enter number exactly as it appears in brackets to toggle selection OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
send "7\r"
expect {
	timeout exit
	"Enter number exactly as it appears in brackets to toggle selection OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
send "8\r"
expect {
	timeout exit
	"Enter number exactly as it appears in brackets to toggle selection OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
send "11\r"
expect {
	timeout exit
	"Enter number exactly as it appears in brackets to toggle selection OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
send "next\r"
expect {
	timeout exit
	"Enter value for \"Name\" OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
#domain name
send "soa_devdomain\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]> "
}
send "next\r"
expect {
	timeout exit
	"Enter new Target Location OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send "next\r"
expect {
	timeout exit
	"Enter new Target Location OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send "next\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send "2\r"
expect {
	timeout exit
	"Enter new *User password: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send "3\r"
expect {
	timeout exit
	"Enter new *Confirm user password: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send "next\r"
expect {
	timeout exit
	"Enter index number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#development mode
send "next\r"
expect {
	timeout exit
	"Enter index number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#sun local jdk
send "next\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#soadatasource
send "1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#bamdatasource
send "2\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#edn local tx datasource
send "3\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#mds soa
send "4\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#wlsb it's derby database see https://blogs.oracle.com/jeffdavies/entry/running_multiple_weblogic_and
#but it has to be changed to XE
send "5\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send -- "2\r"
#Configure DRIVER VENDOR:\r   18|Oracle\r
expect -exact "Enter index number to select OR \[Down\]\[Exit\]\[Reset\]\[Accept\]> "
send -- "18\r"
expect -exact "Enter option number to select OR \[Down\]\[Exit\]\[Reset\]\[Accept\]> "
send -- "3\r"
#Configure DRIVER CLASS:\r ->3|*Oracle's Driver (Thin XA) for Instance connections; Versions:9.0.1 and \r
expect -exact "Enter index number to select OR \[Exit\]\[Reset\]\[Accept\]> "
send -- "3\r"
expect -exact "Enter option number to select OR \[Down\]\[Exit\]\[Reset\]\[Accept\]> "
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send -- "7\r"
expect -exact "Enter value for \"JDBC driver params user name\" OR \[Exit\]\[Reset\]\[Accept\]> "
send -- "DEV_SOAINFRA\r"
expect -exact "Enter option number to select OR \[Down\]\[Exit\]\[Reset\]\[Accept\]> "
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
#########


####
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#mds owsm
send "6\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#end datasource
send "7\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#soa local datasource
send "8\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#modify
send "1\r"
expect {
	timeout exit
	"Enter row number to modify OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
#ora sdpm datasource
send "9\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "4\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms name\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "XE\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "5\r"
expect {
	timeout exit
	"Enter value for \\\"JDBC driver params dbms host\\\" OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "localhost\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "8\r"
expect {
	timeout exit
	"Enter new *JDBC driver params user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "9\r"
expect {
	timeout exit
	"Enter new *JDBC driver params confirm user password encrypted: OR \\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "welcome1\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Down\\\]\\\[Exit\\\]\\\[Reset\\\]\\\[Accept\\\]>"
}
send "accept\r"
expect {
	timeout exit
	"Enter option number to select OR \\\[Exit\\\]\\\[Previous\\\]\\\[Next\\\]>"
}
send -- "next\r"
expect -exact "Enter index number to select OR \[Exit\]\[Previous\]\[Next\]> "
#->10|Skip JDBC Configuration\r
send -- "next\r"
expect -exact "Enter index number to select OR \[Exit\]\[Previous\]\[Next\]> "
#1|Administration Server \[x\]\r
send -- "1\r"
expect -exact "Enter index number to select OR \[Exit\]\[Previous\]\[Next\]> "
#3|Managed Servers, Clusters and Machines \[x\]\r
send -- "3\r"
expect -exact "Enter index number to select OR \[Exit\]\[Previous\]\[Next\]> "
#4|Deployments and Services \[x\]\r
send -- "4\r"
expect -exact "Enter index number to select OR \[Exit\]\[Previous\]\[Next\]> "
send -- "next\r"
expect -exact "Enter option number to select OR \[Exit\]\[Previous\]\[Next\]> "
#Configure the Administration Server:\r
send -- "next\r"
expect -exact "Enter option number to select OR \[Exit\]\[Previous\]\[Next\]> "
#Configure Managed Servers:\r
send -- "next\r"
expect -exact "Enter name for a new Cluster OR \[Exit\]\[Previous\]\[Next\]> "
#Configure Clusters:\r
send -- "next\r"
expect -exact "Enter option number to select OR \[Exit\]\[Previous\]\[Next\]> "
#Configure Machines:\r
send -- "next\r"
expect -exact "Enter name for a new Unix Machine OR \[Exit\]\[Previous\]\[Next\]> "
#Configure Unix Machines:\r
send -- "next\r"
expect -exact "Enter number exactly as it appears in brackets to toggle selection OR \[Exit\]\[Previous\]\[Next\]> "
#Assign Servers to Machines:\r
send -- "1.1\r"
expect -exact "Enter option number to select OR \[Exit\]\[Discard\]\[Accept\]> "
#Assign Servers to Machines:\r
#3 - Select All\r
send -- "3\r"
expect -exact "Enter option number to select OR \[Exit\]\[Discard\]\[Accept\]> "
#Assign Servers to Machines:\r
send -- "accept\r"
expect -exact "Enter number exactly as it appears in brackets to toggle selection OR \[Exit\]\[Previous\]\[Next\]> "
#Assign Servers to Machines:\r
send -- "next\r"
expect -exact "Enter number exactly as it appears in brackets to toggle selection OR \[Down\]\[Exit\]\[Previous\]\[Next\]> "
#Target Deployments to Clusters or Servers:\r
send -- "next\r"
expect -exact "Enter number exactly as it appears in brackets to toggle selection OR \[Down\]\[Exit\]\[Previous\]\[Next\]> "
#Target Services to Clusters or Servers:\r
send -- "next\r"
expect -exact "\r
\r
\r
\r
\r
<------------------- Fusion Middleware Configuration Wizard ------------------>\r
\r
Creating Domain...\r
\r
0%          25%          50%          75%          100%\r
\[------------|------------|------------|------------\]\r
\[***************************************************\]\r
\r
\r
**** Domain Created Successfully! ****\r
\r
\r
"
send -- "\r"
send -- ""
expect eof