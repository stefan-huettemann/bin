#!/bin/bash
 
#
# this script expects environment from LaunchAgent plist
# SERVICE_NAME - a name for the service, e.g. JIRA/STASH
# CATALINA_HOME - which (tomcat) service 
#

function shutdown()
{
        date
        echo "Shutting down ${SERVICE_NAME}"
        $CATALINA_HOME/bin/stop-${SERVICE_NAME}
}

function error()
{
	echo $0 Error: $1
	exit -1
}

if [ -z "${CATALINA_HOME}" ]; then
	error "CATALINA_HOME env is missing."
fi 

# check for valid service names:
SERVICE_NAME=`echo $SERVICE_NAME | awk '{print tolower($0)}'`
case ${SERVICE_NAME} in 
	jira|stash) 
		# OK
	;; 
	*)
		error "unknown service name ${SERVICE_NAME}."
	;;

export CATALINA_PID=${CATALINA_HOME}/work/catalina.pid

# Uncomment to increase Tomcat's maximum heap allocation
# export JAVA_OPTS=-Xmx512M $JAVA_OPTS

 
date
echo "Starting ${SERVICE_NAME}"
. $CATALINA_HOME/bin/start-${SERVI E_NAME}
 
# Allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP
 
echo "Waiting for `cat $CATALINA_PID`"
wait `cat $CATALINA_PID`

#
##
