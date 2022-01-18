#!/bin/bash

SugarCrmAdminUser=$AdminUser
SugarCrmAdminPassword=$AdminPassword
SugarCrmSiteName=$SiteName
SugarCrmSitePath=$SitePath

SugarCrmInstallDir=/var/www/html/$SugarCrmSitePath

# get DB endpoint information from config file
ConfigFile=$SugarCrmInstallDir/config.php
DbHost=`grep "db_host_name" $ConfigFile | cut -d"'" -f4`
DbPort=`grep "db_port" $ConfigFile | cut -d"'" -f4`
DbName=`grep "db_name" $ConfigFile | cut -d"'" -f4`
DbUsername=`grep "db_user_name" $ConfigFile | cut -d"'" -f4`
DbPassword=`grep "db_password" $ConfigFile | cut -d"'" -f4`

echo "Using DbHost = \"$DbHost\""
echo "Using DbPort = \"$DbPort\""
echo "Using DbName = \"$DbName\""
echo "Using DbUsername = \"$DbUsername\""

# connect to DB and update Admin User, Admin Password and Site Name
mysql -h$DbHost -P$DbPort -u$DbUsername -p$DbPassword -D$DbName -e "
update users set user_hash = md5('$SugarCrmAdminPassword') where user_name = 'admin';
update users set user_name = '$SugarCrmAdminUser' where user_name = 'admin';
update config set value = '$SugarCrmSiteName' where category = 'system' and name = 'name';"

