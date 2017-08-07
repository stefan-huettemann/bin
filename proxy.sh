#!/bin/bash
# switch proxy settings on/off

PROXY_HOST=localhost
PROXY_PORT=8888

if [ -z "$1" ]; then
	echo "USAGE: proxy [on|off] (Defined PROXY = ${PROXY_HOST}:${PROXY_PORT})"
	echo
fi

if [ "on" == "$1" ]; then
 ALL_PROXY="http://${PROXY_HOST}:${PROXY_PORT}"
 RSYNC_PROXY="http://${PROXY_HOST}:${PROXY_PORT}"
 http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
 https_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
 # java picks up proxy from network settings
 #_JAVA_OPTIONS="-Dhttp.proxyHost=proxy.service.asv.local -Dhttp.proxyPort=8080"

 # mvn settings:
 # maven:
(
 cd ~/.m2
 rm settings.xml
 ln -s settings.xml.charles settings.xml
 cd -
)
fi

if [ "off" == "$1" ]; then
 ALL_PROXY=""
 RSYNC_PROXY=""
 http_proxy=""
 https_proxy=""
 #_JAVA_OPTIONS=""

 # maven:
(
 cd ~/.m2
 rm settings.xml
 ln -s settings.xml.noproxy settings.xml
 cd -
)
fi

export http_proxy
export https_proxy
export ALL_PROXY
export RSYNC_PROXY
#export _JAVA_OPTIONS

# echo:
env | grep -i proxy
printf "%s" "mvn:" && (ls -l ~/.m2/settings.xml|/usr/bin/awk -F '->' '{print $2}')
printf "\n"
(cd ~/bin && javac ProxyTest.java && java ProxyTest)
#
##
