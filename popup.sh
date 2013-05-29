#!/bin/bash

P_DIR="/Users/$USER/Library/Application Support/Firefox/Profiles/asv.default"
_E="Unkown error."

function error() {
	echo "ERROR: ${_E}"
	exit -1
}

if [ ! -d "${P_DIR}" ]; then
	_E="Firefox Profile asv.default for user $USER not found.";
	error;
fi


# Popups generell blockieren: immer auf true setzten
U_PREF='user_pref("dom.disable_open_during_load", true);'

grep -s -q 'dom.disable_open_during_load' user.js 
if [ "$?" == "0" ]; then
	# eintrag im user.js vorhanden -> change to 'true'
	sed -i '' -e 's/"dom.disable_open_during_load", false/"dom.disable_open_during_load", true/' user.js
else
	# kein user.js/kein eintrag vorhanden -> append to user.js
	echo ${U_PREF} >> user.js
fi 

# ausnahme eintragen mit sqlite3:
if [ -e `which sqlite3` ]; then
	if [ ! -f permissions.sqlite ]; then
		_E="File not found: permissions.sqlite"
		error;
	fi

	sqlite3 -line permissions.sqlite "select host from moz_hosts where host = 'interred.asv.local';" | grep -s -q 'interred.asv.local'
	if [ "$?" != "0" ]; then
		sqlite3 -line permissions.sqlite "insert into moz_hosts(host, type, permission)  values('interred.asv.local', 'popup', 1)"
	fi
fi

exit 0

#
##
