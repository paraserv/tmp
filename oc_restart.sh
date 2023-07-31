#!/bin/bash
# This script pulls the names of all the containers running on the system, then gives the restart command,
# then waits 30 seconds, and sends an 'enter'.
# Needs to be run as a user with Docker permissions or root.



lrctl oc restart
wait 45
lrctl metrics restart
wait 45
for OUTPUT in $(docker ps --format '{{.Names}}')
do
        CONTAINER=$(echo $OUTPUT | grep -v -e "open_collector" -e "metrics")
        NAME=$(echo $OUTPUT | cut -f1 -d"_")
        lrctl $NAME restart -f $CONTAINER
        wait 45
done
