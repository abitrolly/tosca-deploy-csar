#!/bin/bash

httpdconf=/etc/httpd/conf/httpd.conf

SugarCrmHost=$PublicIP
SugarCrmSite=$SitePath
SugarCrmInstallDir=/var/www/html/$SugarCrmSite
SugarCrmSource=/tmp/tosca/artifacts/SugarCRMInstall/SugarCE-Full-6.5.14
SugarCrmConfigPhpSource=/tmp/tosca/artifacts/config.php
SugarCrmConfigOverridePhpSource=/tmp/tosca/artifacts/config_override.php
HtaccessSource=/tmp/tosca/artifacts/.htaccess

# configure overrides for apache
httpdconf_ext="
<Directory \"$SugarCrmInstallDir\">
  AllowOverride All
</Directory>"

echo "$httpdconf_ext" >> $httpdconf

# create webcontent dir and copy deployment artifacts
mkdir -p $SugarCrmInstallDir
cp -r $SugarCrmSource/* $SugarCrmInstallDir

# copy additional artifact: config files, custom site image, .htaccess
cp $SugarCrmConfigPhpSource $SugarCrmInstallDir/
cp $SugarCrmConfigOverridePhpSource $SugarCrmInstallDir/
cp $HtaccessSource $SugarCrmInstallDir/

# set access right for web content
chown -R apache:apache $SugarCrmInstallDir
chmod -R 755 $SugarCrmInstallDir

# customize config settings
ConfigFile=$SugarCrmInstallDir/config.php
sed -i "s/@SUGARCRM_HOST@/$SugarCrmHost/g" $ConfigFile
sed -i "s/@SUGARCRM_SITE@/$SugarCrmSite/g" $ConfigFile

