#!/bin/bash

# This script downloads the ATND events and users from https://api.atnd.org/
# 
# Usage:
# ./get.sh <owner_id>
# 

# Endpoints
# Event Search API
URI_API_EVENTS="https://api.atnd.org/events/?format=json&count=100&owner_id="
# Users API
URI_API_USERS="https://api.atnd.org/events/users/?format=json&event_id="

# Save directory
SAVE_DIR=./json

# Check required commands
if ! (type curl > /dev/null 2>&1); then
    echo "`curl` command has not been found."
    exit 1
fi
if ! (type jq > /dev/null 2>&1); then
    echo "`jq` command has not been found."
    exit 1
fi

# Check parameters
if [ $# -ne 1 ]; then
    echo "missing owner_id"
    echo "Usage: ./get.sh [owner_id]"
    exit 1
fi

# Check if there are any events.
json=`curl -sS ${URI_API_EVENTS}${1}`
length=`echo ${json} | jq '.events' | jq length`
if [ $length -eq 0 ]; then
	echo "owner_id=${1} events not found."
    exit 1
fi
echo "${length} events found."

# Make save directory
mkdir -p $SAVE_DIR 2>/dev/null

# Get events data.
curl -sS "${URI_API_EVENTS}${1}" -o ${SAVE_DIR}/events.json
echo "Downloaded events data: events.json"

# Get users data.
for i in `seq 0 $(expr ${length} - 1)`
do
    event_id=`echo ${json} | jq .events[${i}].event.event_id`
	curl -sS "${URI_API_USERS}${event_id}" -o ${SAVE_DIR}/users_${event_id}.json
    echo "#${i}: Downloaded users data: users_${event_id}.json"
done

echo "Done!"
