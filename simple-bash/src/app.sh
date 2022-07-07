#!/bin/bash

DB="/apps/data"
VERSION="1.1"

echo -e "Script Path: $(readlink -f $0)\nVersion: $VERSION"

while true
do
  FIRST_NAME_LIST=$(echo -e "male-given-names.txt\nfemale-given-names.txt" | shuf -n1)
  FIRST_NAME=$(shuf -n1 $DB/$FIRST_NAME_LIST)
  LAST_NAME=$(shuf -n1 $DB/surnames.txt)
  AUDIT_EVENT=$(shuf -n1 $DB/events.txt)
  AUDIT_STATUS=$(echo -e "Success\nFailure" | shuf -n1)
  LOG_STRING="Timestamp=\"$(date +%s)\" Host=\"$HOSTNAME\" pid=\"$$\" Event=\"$AUDIT_EVENT\" Status=\"$AUDIT_STATUS\" User=\"$FIRST_NAME $LAST_NAME\""
  echo "$LOG_STRING"
  sleep 5
done
