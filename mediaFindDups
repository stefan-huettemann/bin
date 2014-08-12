if [ ! -e Dirs ]; then
	echo "Create directory list in file named 'Dirs' first."
	exit -1
fi

for d in `cat Dirs`; do
 echo "#"
 echo "#  Checking $d"
 echo "#"

 TMPFILE=`mktemp /tmp/temp.XXXXX`

 cat $d/shasum|awk '{print $1}'>${TMPFILE}

 for dd in `cat Dirs`; do
	if [ $d == $dd ]; then 
		echo "# SKIPPING $d";
		continue;
	fi;
	echo "# Compare $d with $dd";  

	for sha in `cat ${TMPFILE}`; do
		grep $sha $dd/shasum
	done
 done

 rm ${TMPFILE}
done
