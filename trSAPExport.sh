#!/bin/bash

usage() {
	echo
	echo 'USAGE: $0 <INFILE> [<OUTFILE>]'
	echo
}

echo "Manuelle Schritte:"
echo " 1. export from SAP to HTML"
echo " 2. import HTML to Excel"
echo " 3. save Excel as 'Windows formatierter Text'"
echo " 4. use this script ..."

if [ -z "$1" ]; then
	usage;
fi
 
OUT=$2
if [ -z "${OUT}" ]; then
	OUT=$1.out
fi
 

echo $1 $OUT

cat $1 | sed 's/\t/;/' > $OUT

#
##
