if [ ! -e Dirs ]; then
	echo "Create directory list in file named 'Dirs' first."
	exit -1
fi

for d in `cat Dirs`; do
 echo "#"
 echo "#  Checking internal duplicates of $d"
 echo "#"

 TMPFILE=`mktemp /tmp/temp.XXXXX`

 cat $d/shasum|awk '{print $1}'|sort|uniq -d > ${TMPFILE}

 for sha in `cat ${TMPFILE}`; do
	grep $sha $d/shasum
 done

 rm ${TMPFILE}
done
