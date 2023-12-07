#!/bin/sh

source stop_trap.sh

java -jar $SELENIUM_JAR \
	-port $SELENIUM_HUB_PORT \
	&
JAVA_PID=$!
wait $JAVA_PID