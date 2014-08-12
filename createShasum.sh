echo "Cleanup old shasum files..."
find . -name shasum -exec rm {} \;

if [ ! -e Dirs ]; then
	echo "Create directory list in file named 'Dirs' first."
	exit -1
fi

for d in `cat Dirs`; do
	echo "Creating shasum in $d..."
	find $d -type f -exec shasum {} \;>$d/shasum
done

