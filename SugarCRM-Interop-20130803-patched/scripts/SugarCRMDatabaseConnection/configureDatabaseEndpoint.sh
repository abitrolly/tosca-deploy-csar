#!/bin/bash

SugarCrmSite=$Source_SitePath
SugarCrmInstallDir=/var/www/html/$SugarCrmSite

MySQLHost=$Target_PublicIP
MySQLPort=$Target_DBPort
MySQLUser=$Target_DBUser
MySQLPwd=$Target_DBPassword
MySQLDB=$Target_DBName

# set database endpoint properties in SugarCRM config file
ConfigFile=$SugarCrmInstallDir/config.php
sed -i "s/@MYSQL_HOST@/$MySQLHost/g" $ConfigFile
sed -i "s/@MYSQL_PORT@/$MySQLPort/g" $ConfigFile
sed -i "s/@MYSQL_DB@/$MySQLDB/g" $ConfigFile
sed -i "s/@MYSQL_USER@/$MySQLUser/g" $ConfigFile
sed -i "s/@MYSQL_PWD@/$MySQLPwd/g" $ConfigFile

