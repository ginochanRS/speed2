#!/bin/bash

DateDelLog=$(date "+%Y-%m-%d" -d "${RM_LOG_DAYS_BEFORE} days ago")
logList=$(ls "${SCRIPTS_DIR}"/log/*.log)
for log in ${logList}; do
  LineDel=$(grep -n "${DateDelLog}" "${log}" | tail -1 | awk -F ':' '{print $1}')
  sed -i "1,${LineDel}d" "${log}"
done
