#!/bin/bash 

S1=irdstest
S2=irdsint

function help() {
	echo "==="
	echo "== This is $0 "
	echo "== List patches applied on different Interred servers."
	echo "== If parameters are supplied, it will use the two parameters as server-names for comparision."
	echo "== Server defaults to $S1, $S2"
	echo "==="
	echo
}

if [ $# != 2 -a $# != 0 ]; then
	help;
	exit -1;
fi

if [ $# == 2 ]; then
	S1=$1
	S2=$2
fi

echo "Using Servers:"
echo "-- left:  $S1"
echo "-- right: $S2"
echo
echo "please stand by ..."

# Temp files 
S1_PATCHES=`mktemp /tmp/S1.XXXX`
S2_PATCHES=`mktemp /tmp/S2.XXXX`
S1_DIFF=`mktemp /tmp/S1.XXXX`
S2_DIFF=`mktemp /tmp/S2.XXXX`

ssh interred@$S1 'cd /opt/InterRed/bild/patches; ls -1 *.patch' | sort > $S1_PATCHES
ssh interred@$S2 'cd /opt/InterRed/bild/patches; ls -1 *.patch' | sort > $S2_PATCHES

D=`mktemp /tmp/DFF.XXXX`
diff $S1_PATCHES $S2_PATCHES > $D

echo "== $S1 SYSTEM PATCHES ==" > $S1_DIFF
cat $D | grep '<' | sed 's/< //' >> $S1_DIFF
echo "== $S2 SYSTEM PATCHES ==" > $S2_DIFF
cat $D | grep '>' | sed 's/> //' >> $S2_DIFF

#vimdiff $S1_DIFF $S2_DIFF
vim -O $S1_DIFF $S2_DIFF

#
##
