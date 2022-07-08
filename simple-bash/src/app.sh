#!/bin/bash

# Description: Simple Bash script to generate audit-like test data.
# Version: 1.2
# Date: 9-Jul-2022
# Author: Daz Grant (dagrant@redhat.com)

DB="/apps/data"
VERSION="1.2"
AUDIT_LOG_DIR="/apps/logs"

[[ ! -d $AUDIT_LOG_DIR ]] && mkdir $AUDIT_LOG_DIR

log() {
  local TIMESTAMP="$(date +%s)"
  local MSG="$1"
  local SEVERITY="$2"

  [ -z "$MSG" ] && MSG="<empty>"
  [ -z "$SEVERITY" ] && SEVERITY="INFO"

  JSON_LOG_STRING="{\"log-event\":{\"timestamp\":\"$TIMESTAMP\",\"host\":\"$HOSTNAME\",\"pid\":\"$$\",\"message\":\"$MSG\",\"severity\":\"$SEVERITY\"}}}"
  echo $JSON_LOG_STRING
}

VERSION_INFO="Script Path: $(readlink -f $0) Version: $VERSION"

log "Starting" INFO
log "$VERSION_INFO" INFO

while true
do
  TIMESTAMP="$(date +%s)"
  FIRST_NAME_LIST=$(echo -e "male-given-names.txt\nfemale-given-names.txt" | shuf -n1)
  FIRST_NAME=$(shuf -n1 $DB/$FIRST_NAME_LIST)
  LAST_NAME=$(shuf -n1 $DB/surnames.txt)
  AUDIT_EVENT=$(shuf -n1 $DB/events.txt)
  AUDIT_STATUS=$(echo -e "Success\nFailure" | shuf -n1)
  LOG_STRING="Timestamp=\"$TIMESTAMP\" Host=\"$HOSTNAME\" pid=\"$$\" Event=\"$AUDIT_EVENT\" Status=\"$AUDIT_STATUS\" User=\"$FIRST_NAME $LAST_NAME\""
  JSON_LOG_STRING="{\"audit-event\":{\"timestamp\":\"$TIMESTAMP\",\"host\":\"$HOSTNAME\",\"pid\":\"$$\",\"event\":\"$AUDIT_EVENT\",\"status\":\"$AUDIT_STATUS\",\"user\":{\"firstname\":\"$FIRST_NAME\",\"surname\":\"$LAST_NAME\"}}}"
  echo $JSON_LOG_STRING | tee -a $AUDIT_LOG_DIR/audit-event-log.json
  sleep 5
done
