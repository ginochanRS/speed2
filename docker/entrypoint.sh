#!/bin/bash
set -e

[ ! -d "${SCRIPTS_DIR}"/log ] && mkdir -p "${SCRIPTS_DIR}"/log
crond

[ -f /tmp/crontab.list ] && rm -f /tmp/crontab.list
echo "0 1 * * * git -C ${SCRIPTS_DIR} pull | ts \"%Y-%m-%d %H:%M:%S\" >> ${SCRIPTS_DIR}/log/git_pull.log 2>&1" >>/tmp/crontab.list
echo "${XMLY_CRON} cd ${SCRIPTS_DIR} && python xmly_speed.py | ts \"%Y-%m-%d %H:%M:%S\" >> ${SCRIPTS_DIR}/log/xmly_speed.log 2>&1" >>/tmp/crontab.list

crontab /tmp/crontab.list
rm -f /tmp/crontab.list

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- python3 "$@"
fi

exec "$@"
