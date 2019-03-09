#!/usr/bin/expect -f
#
spawn /u01/app/oracle/middleware/soa/common/bin/config.sh
expect "Enter index number to select OR [Exit][Next]>"
send "next\r"
Enter index number to select OR [Exit][Previous][Next]>
send "next\r"
Enter number exactly as it appears in brackets to toggle selection OR [Exit][Previous][Next]>
send "2\r"
Enter number exactly as it appears in brackets to toggle selection OR [Exit][Previous][Next]>
send "7\r"
Enter number exactly as it appears in brackets to toggle selection OR [Exit][Previous][Next]>
send "8\r"
Enter number exactly as it appears in brackets to toggle selection OR [Exit][Previous][Next]>
send "11\r"
Enter number exactly as it appears in brackets to toggle selection OR [Exit][Previous][Next]>
send "next\r"
Enter value for "Name" OR [Exit][Previous][Next]>
send "soa_devdomain\r"
Enter option number to select OR [Exit][Previous][Next]>
send "next\r"
Enter new Target Location OR [Exit][Previous][Next]>
send "next\r"
Enter new Target Location OR [Exit][Previous][Next]>
send "next\r"
Enter option number to select OR [Exit][Previous][Next]>
send "2\r"
Enter new *User password: OR [Exit][Reset][Accept]>
send "welcome1\r"
Enter option number to select OR [Exit][Previous][Next]>
send "3\r"
Enter new *Confirm user password: OR [Exit][Reset][Accept]>
send "welcome1\r"
Enter option number to select OR [Exit][Previous][Next]>
send "next\r"
Enter index number to select OR [Exit][Previous][Next]>
send "next\r"
Enter index number to select OR [Exit][Previous][Next]>
send "next\r"
Enter option number to select OR [Exit][Previous][Next]>
send "1\r"
Enter row number to modify OR [Exit][Previous][Next]>
send "1\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "4\r"
Enter value for "JDBC driver params dbms name" OR [Exit][Reset][Accept]>
send "XE\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "5\r"
Enter value for "JDBC driver params dbms host" OR [Exit][Reset][Accept]>
send "localhost\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "8\r"
Enter new *JDBC driver params user password encrypted: OR [Exit][Reset][Accept]>
send "welcome1\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "9\r"
Enter new *JDBC driver params confirm user password encrypted: OR [Exit][Reset][Accept]>
send "welcome1\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "accept\r"


Enter option number to select OR [Exit][Previous][Next]>
send "1\r"
Enter row number to modify OR [Exit][Previous][Next]>
send "2\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "4\r"
Enter value for "JDBC driver params dbms name" OR [Exit][Reset][Accept]>
send "XE\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "5\r"
Enter value for "JDBC driver params dbms host" OR [Exit][Reset][Accept]>
send "localhost\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "8\r"
Enter new *JDBC driver params user password encrypted: OR [Exit][Reset][Accept]>
send "welcome1\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "9\r"
Enter new *JDBC driver params confirm user password encrypted: OR [Exit][Reset][Accept]>
send "welcome1\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "accept\r"

Enter option number to select OR [Exit][Previous][Next]>
send "1\r"
Enter row number to modify OR [Exit][Previous][Next]>
send "3\r"
Enter option number to select OR [Down][Exit][Reset][Accept]>
send "4\r"
send "XE\r"
send "5\r"
send "localhost\r"
send "8\r"
send "welcome1\r"
send "9\r"
send "welcome1\r"
send "accept\r"
send "1\r"
send "4\r"
send "4\r"
send "XE\r"
send "5\r"
send "localhost\r"
send "8\r"
send "welcome1\r"
send "9\r"
send "welcome1\r"
send "accept\r"

send "1\r"
send "5\r"
send "4\r"
send "osb_soa_devdomain\r"
send "accept\r"


send "1\r"
send "6\r"
send "4\r"
send "XE\r"
send "5\r"
send "localhost\r"
send "8\r"
send "welcome1\r"
send "9\r"
send "welcome1\r"
send "accept\r"


send "1\r"
send "7\r"
send "4\r"
send "XE\r"
send "5\r"
send "localhost\r"
send "8\r"
send "welcome1\r"
send "9\r"
send "welcome1\r"
send "accept\r"

send "1\r"
send "8\r"
send "4\r"
send "XE\r"
send "5\r"
send "localhost\r"
send "8\r"
send "welcome1\r"
send "9\r"
send "welcome1\r"
send "accept\r"

send "1\r"
send "9\r"
send "4\r"
send "XE\r"
send "5\r"
send "localhost\r"
send "8\r"
send "welcome1\r"
send "9\r"
send "welcome1\r"
send "accept\r"


######################



send "next\r"
send "next\r"
send "1\r"
send "3\r"
send "4\r"
send "next\r"
send "next\r"
send "next\r"
send "next\r"
send "next\r"
send "next\r"
send "1.1\r"
send "3\r"
send "accept\r"
send "next\r"
send "next\r"
send "next