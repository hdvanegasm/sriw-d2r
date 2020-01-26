#!/bin/bash
if [ ! -e "./d2r-server" ]
then
  echo "Please cd into the D2R Server directory to run the server"
  exit 1
fi
D2RQ_ROOT="$( dirname "${BASH_SOURCE[0]}" )"
CP="$D2RQ_ROOT/build"
SEP=':'
if [ $(uname -s | grep -ic 'cygwin\|mingw') -gt 0 ]; then SEP=';'; fi
for jar in "$D2RQ_ROOT"/lib/*.jar "$D2RQ_ROOT"/lib/*/*.jar
do
  if [ ! -e "$jar" ]; then continue; fi
  CP="$CP$SEP$jar"
done
LOGCONFIG=${LOGCONFIG:-file:$D2RQ_ROOT/etc/log4j.properties}
exec java -cp "$CP" -Xmx1G "-Dlog4j.configuration=${LOGCONFIG}" d2rq.server "$@" -Dserver.port=$PORT