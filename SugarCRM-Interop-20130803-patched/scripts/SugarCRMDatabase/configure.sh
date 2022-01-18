#!/bin/bash

DBName=$DBName
DBUser=$DBUser
DBPassword=$DBPassword
DBPort=$DBPort

##################################################
# 1. configure DB port and iptables
##################################################
iptables='/etc/sysconfig/iptables'
mySqlConfig='/etc/my.cnf'

## set mySql Port
cat $iptables | grep -q port=
if [ $? -ne 0 ]; then

#inserting data into /etc/my.cnf
sed -i '
/\[mysqld\]/ a\
port='$DBPort'
' $mySqlConfig

else
	sed -i "s/port=3306/ port=$DBPort/" $mySqlConfig
	service mysqld restart
fi

## open firewall for this port
iptables-save | grep -q "OUTPUT -p tcp --sport $DBPort -j ACCEPT"
if [ $? -eq 1 ];then
	iptables -I OUTPUT -p tcp --sport $DBPort -j ACCEPT
fi

iptables-save | grep -q "INPUT -p tcp --dport $DBPort -j ACCEPT"
if [ $? -eq 1 ];then
	iptables -I INPUT -p tcp --dport $DBPort -j ACCEPT
fi
	
iptables-save > $iptables
iptables-restore < $iptables

# restart mysql
ps -A | grep -q mysqld
if [ $? -eq 1 ]; then
    echo "mysqld is currently stopped, is getting started"
    service mysqld start
    if [ $? -ne 0 ]; then
    	echo "killing mysqld processes"
    	ps -ef | grep mysqld | grep -v grep | awk '{print $2}' | xargs kill -9
    	service mysqld start
    fi	
else
    echo "mysqld is already started. restarting"
    service mysqld restart
fi


##################################################
# 2. create DB and populate from dump file
##################################################

# file to pass admin credentials to SugarCRM DB Node
# this is used due to lack of parameter passing in TOSCA
CredentialsFile=/tmp/tosca/$DBName/mysql_access

. $CredentialsFile

# create DB user for SugarCRM; MySQLAdminUser and MySQLAdminPwd are defined in credentials file
mysql -u$MySQLAdminUser -p$MySQLAdminPwd -e "create user $DBUser;"
mysql -u$MySQLAdminUser -p$MySQLAdminPwd -e "grant all privileges on *.* to '$DBUser'@'%' identified by '$DBPassword';"

# create DB and populate with dump file
DbDumpFile=/tmp/tosca/artifacts/SugarCRMDB.sql
mysql -u$MySQLAdminUser -p$MySQLAdminPwd -e "create database $DBName;"
mysql -u$MySQLAdminUser -p$MySQLAdminPwd $DBName < $DbDumpFile

