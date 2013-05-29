#!/bin/bash
# switch proxy settings on/off
if [ -z "$1" ]; then
	echo "USAGE: proxy [on|off]"
	echo
fi

if [ "on" == "$1" ]; then
 ALL_PROXY="http://proxy.service.asv.local:8080"
 RSYNC_PROXY="http://proxy.service.asv.local:8080"
 http_proxy="http://proxy.service.asv.local:8080"
 https_proxy="http://proxy.service.asv.local:8080"
 # java picks up proxy from network settings
 #_JAVA_OPTIONS="-Dhttp.proxyHost=proxy.service.asv.local -Dhttp.proxyPort=8080"

 # mvn settings:
 # maven:
 cd ~/.m2
 rm settings.xml
 ln -s settings.xml.asv.local settings.xml
 cd -
fi

if [ "off" == "$1" ]; then
 ALL_PROXY=""
 RSYNC_PROXY=""
 http_proxy=""
 https_proxy=""
 #_JAVA_OPTIONS=""

 # maven:
 cd ~/.m2
 rm settings.xml
 ln -s settings.xml.noproxy settings.xml
 cd -
fi

export http_proxy
export https_proxy
export ALL_PROXY
export RSYNC_PROXY
#export _JAVA_OPTIONS

# echo:
env | grep -i proxy
printf "%s" "mvn:" && (ls -l ~/.m2/settings.xml|/usr/bin/awk -F '->' '{print $2}')
(javac ProxyTest.java && java ProxyTest)
#
##
