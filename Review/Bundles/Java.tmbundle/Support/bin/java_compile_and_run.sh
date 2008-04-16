SOURCE="$1"
shift
TMP=/tmp/tm_javamate 
mkdir -p $TMP
cd $TMP
"$TM_JAVAC" -d $TMP -encoding UTF8 "$SOURCE"
if (($? >= 1)); then exit; fi
	
"$TM_JAVA" -Dfile.encoding=utf-8 $(basename -s .java "$SOURCE") $@
echo -e "\nProgram exited with status $?.";